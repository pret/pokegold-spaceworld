#!/usr/bin/env python3

"""Separate strings in code files out to translatable CSVs."""

import csv
import os
import re
import sys
from collections import namedtuple, Counter

LABEL_RE = re.compile(r"^(?P<label>(?:[A-Za-z0-9_]+::?|\.[A-Za-z0-9_]+:{0,2}))\s*(?P<line>.*?)\s*$")
LINE_RE = re.compile(r"^(?P<start>\s*[A-Za-z0-9_]+)(?P<rest>.*)$")

LineStart = namedtuple('LineStart', ('name', 'length', 'is_end'))
String = namedtuple('String', ('label', 'lines', 'first_line', 'last_line'))
Line = namedtuple('Line', ('start', 'text'))

LINE_STARTS = {
    'db':       LineStart('db',       0, False),
    'text':     LineStart('text',     1, False),
    'next':     LineStart('next',     1, False),
    'line':     LineStart('line',     1, False),
    'para':     LineStart('para',     1, False),
    'cont':     LineStart('cont',     1, False),
    'done':     LineStart('done',     1, True),
    'prompt':   LineStart('prompt',   1, True),
    'text_end': LineStart('text_end', 1, True)
}

CHARMAP_RE = re.compile(r"^\s*(?:charmap\s*\"(?P<string>(?:[^\"]|\\\")+)\"\s*,\s*\$(?P<byte>[0-9A-F]{1,2}))?(?:\s*;.*)?$", re.IGNORECASE)
def parse_charmap(asm):
    charmap = {}
    for line in asm.splitlines():
        m = CHARMAP_RE.match(line)
        if not m.group('string'):
            continue
        charmap[m.group('string')] = int(m.group('byte'), 16)
    return charmap

with open('charmap.asm', 'r', encoding='utf-8') as f:
    CHARMAP = parse_charmap(f.read())

def strings_in_asm(asm):
    label = ''
    cur_lines = []
    first_line = None
    for line_num, line in enumerate(asm.splitlines()):
        m = LABEL_RE.match(line)
        if m:
            line = m.group('line')
            if cur_lines:
                yield String(label, cur_lines, first_line, last_line)
                cur_lines = []
                first_line = None
            if not m.group('label').startswith('.'):
                label = m.group('label').rstrip(':')
    
        # This won't be too happy if there's a semicolon in a string,
        # but that doesn't happen in the Japanese text.
        line = line.rsplit(';', maxsplit=1)[0].strip()
        if not line:
            continue

        m = LINE_RE.match(line)
        start, rest = m.group('start'), m.group('rest')
        if start not in LINE_STARTS or start == 'db' and '"' not in rest:
            if cur_lines:
                yield String(label, cur_lines, first_line, last_line)
                cur_lines = []
                first_line = None
            continue
        
        text = None if LINE_STARTS[start].is_end else rest[rest.index('"') + 1:rest.rindex('"')]

        cur_lines.append(Line(start, text))
        first_line = line_num if first_line is None else first_line
        last_line = line_num

    if cur_lines:
        yield String(label, cur_lines, first_line, last_line)

def num_bytes_in(string):
    x = ""
    n = 0
    for line in string.lines:
        n += LINE_STARTS[line.start].length
        if not line.text:
            continue

        i = 0
        num_chars = len(line.text)
        while i < num_chars:
            max_matching_length = 0
            for s in CHARMAP:
                cur_length = len(s)
                if line.text[i:i + cur_length] == s and cur_length >= max_matching_length:
                    max_matching_length = cur_length
            if max_matching_length == 0:
                raise ValueError("String contains a character not in the charmap: {}.".format(line.text[i]))
            i += max_matching_length
            n += 1
    return n

def to_csv(strings, out_path):
    with open(out_path, 'w', newline="", encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(("Label", "Bytes", "Starts (JP)", "Japanese", "English", "Draft", "Notes"))

        lengths = [num_bytes_in(string) for string in strings]

        writer.writerow(("Original total", sum(lengths)))
        # Normally "B4:B" would work here, but a bug in Google Sheets(!)
        # prevents imported CSVs from immediately using unbounded ranges.
        writer.writerow(("Current total", "=SUM(B4:B9999)"))

        for string, num_bytes in zip(strings, lengths):
            starts = ""
            japanese = ""
            for start, text in string.lines:
                if start == 'para':
                    starts += "\n"
                    japanese += "\n"
                starts += start + "\n"
                japanese += (text or "") + "\n"
            
            # Get the trailing newline off.
            starts = starts[:-1] if starts else starts
            japanese = japanese[:-1] if japanese else japanese

            starts_present = set(filter(
                lambda start: start and not LINE_STARTS[start].is_end,
                (line.start for line in string.lines)
            ))
            if starts_present == {'db'} or 'next' in starts_present:
                placeholder = japanese
            elif len(string.label) <= 18 - 2:
                placeholder = "[{}]".format(string.label)
            else:
                placeholder = "[{}]".format(string.label[:18 - 2 - 1] + "…")
            writer.writerow((string.label, num_bytes, starts, japanese, placeholder))

def string_macros(strings):
    total_label_counts = Counter(string.label for string in strings)
    cur_label_counts = {label: 0 for label in total_label_counts} 

    for string in strings:
        cur_label_counts[string.label] += 1
        if total_label_counts[string.label] > 1:
            yield "text_{}_{}".format(string.label, cur_label_counts[string.label])
        else:
            yield "text_{}".format(string.label)

def indirect_strings(asm, strings, csv_path):
    lines = asm.splitlines()
    edited_lines = []

    # Replace all the strings in the file with macros the CSV generates.
    prev_end = 0
    for string, macro in zip(strings, string_macros(strings)):
        edited_lines += lines[prev_end:string.first_line]
        
        first_line = lines[string.first_line]
        m = LABEL_RE.match(first_line)
        if m:
            edited_lines.append(m.group('label'))
        
        edited_lines.append("\t{}".format(macro))

        prev_end = string.last_line + 1
    
    edited_lines += lines[prev_end:]

    # Include the macro file the CSV generates.
    include_i = next((i for i, line in enumerate(lines) if not line.lower().startswith('include')), 0)
    inc_path = os.path.splitext(csv_path)[0] + '.inc'
    inc_path = os.path.normpath(inc_path).replace('\\', '/')
    edited_lines.insert(include_i, "INCLUDE \"{}\"".format(inc_path))

    return '\n'.join(edited_lines)

def main(argv):
    script_name = os.path.split(argv[0])[-1]
    try:
        asm_path = argv[1]
        csv_path = argv[2]
    except IndexError:
        print("Usage: {} <asm input file> <csv output file>".format(script_name))
        return 1
    
    with open(asm_path, 'r', encoding='utf-8') as f:
        s = f.read()
    
    strings = list(strings_in_asm(s))
    
    to_csv(strings, csv_path)
    with open(asm_path, 'w', encoding='utf-8') as f:
        f.write(indirect_strings(s, strings, csv_path))

    print("Separating the strings from \"{}\" to \"{}\"...".format(asm_path, csv_path))

if __name__ == '__main__':
    sys.exit(main(sys.argv))
