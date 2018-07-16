#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""Separate strings in code files out to translatable CSVs."""

import csv
import os
import re
import sys
from collections import namedtuple

LABEL_RE = re.compile(r"^(?P<label>\.?[A-Za-z0-9_]+)::?\s*(?P<line>.*?)\s*$")

LineStart = namedtuple('LineStart', ('name', 'length', 'is_end'))
String = namedtuple('String', ('label', 'lines'))
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

def strings_in(asm):
    label = ''
    cur_lines = []
    for line in asm.splitlines():
        m = LABEL_RE.match(line)
        if m:
            line = m.group('line')
            if not m.group('label').startswith('.'):
                if cur_lines:
                    yield label, cur_lines
                    cur_lines = []
                label = m.group('label')
    
        # This won't be too happy if there's a semicolon in a string,
        # but that doesn't happen in the Japanese text.
        line = line.rsplit(';', maxsplit=1)[0].strip()
        if not line:
            continue

        start, rest = (line.split(maxsplit=1) + [''])[:2]
        if start not in LINE_STARTS or start == 'db' and '"' not in rest:
            if cur_lines:
                yield label, cur_lines
                cur_lines = []
            continue
        
        text = None if LINE_STARTS[start].is_end else rest[rest.index('"') + 1:rest.rindex('"')]

        cur_lines.append(Line(start, text))

    if cur_lines:
        yield label, cur_lines

def to_csv(strings, out_path):
    with open(out_path, 'w', newline="", encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(("Label", "Starts (JP)", "Japanese", "English", "Draft", "Notes"))

        for label, lines in strings:
            starts = ""
            japanese = ""
            for start, text in lines:
                if start == 'para':
                    starts += "\n"
                    japanese += "\n"
                starts += start + "\n"
                japanese += (text or "") + "\n"
            
            # Get the trailing newline off.
            starts = starts[:-1] if starts else starts
            japanese = japanese[:-1] if japanese else japanese

            if len(label) <= 18 - 2:
                placeholder = "[{}]".format(label)
            else:
                placeholder = "[{}]".format(label[:18 - 2 - 1] + "…")
            writer.writerow((label, starts, japanese, placeholder))

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
    
    to_csv(strings_in(s), csv_path)

    print("Extracting the strings from \"{}\" to \"{}\"...".format(asm_path, csv_path))


if __name__ == '__main__':
    sys.exit(main(sys.argv))
