#!/usr/bin/env python3

"""Compile strings from CSVs to the text bank and
into macros for inclusion in assembly files.
"""

import csv
import os
import sys
from collections import namedtuple
from separatetext import *

String = namedtuple('String', ('label', 'lines', 'space'))

def strings_in_csv(csv_path):
    strings = []
    total_space = 0
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)

        next(reader)
        target_space = int(next(reader)[1])
        next(reader)
        
        total_space = 0
        for label, num_bytes, jp_starts, _, text in (row[:5] for row in reader):
            num_bytes = int(num_bytes)
            jp_starts = jp_starts.split('\n')
            text = text.strip()
            
            starts_present = set(filter(
                lambda start: start and not LINE_STARTS[start].is_end,
                jp_starts
            ))
            if starts_present == {'db'}:
                # Where each line is just a db, starts should be a bunch of dbs.
                lines = [Line('db', line) for line in text.split('\n')]
            elif 'next' in starts_present:
                # Menus and such get the nexty treatment.
                raw_lines = text.split('\n')
                lines = []
                lines.append(Line(jp_starts[0], raw_lines[0]))
                lines += [Line('next', line) for line in raw_lines[1:]]
            else:
                # Otherwise, we gotta use an a bit more ~sophisticated~ strategy!
                lines = []
                line_in_paragraph = 0
                for line_num, line in enumerate(text.split('\n')):
                    if line_in_paragraph == 0:
                        if line_num == 0:
                            start = jp_starts[0]
                        else:
                            start = 'para'
                    elif line_in_paragraph == 1:
                        start = 'line'
                    else:
                        start = 'cont'
                    
                    if line:
                        lines.append(Line(start, line))
                        line_in_paragraph += 1
                    else:
                        line_in_paragraph = 0
            
            if LINE_STARTS[jp_starts[-1]].is_end:
                lines.append(Line(jp_starts[-1], None))

            strings.append(String(label, lines, num_bytes))
            total_space += num_bytes

    if total_space != target_space:
        raise ValueError("Number of bytes allocated for strings doesn't match the target size.")

    return strings

def to_asm(string):
    asm = ""
    for line in string.lines:
        if line.start == 'para':
            asm += "\n"

        if line.text is None:
            asm += "\t{}\n".format(line.start)
        else:
            asm += "\t{} \"{}\"\n".format(line.start, line.text.replace('"', '\\"'))
    
    return asm

def compile(csv_path):
    strings = strings_in_csv(csv_path)
    macro_code = ""
    text_bank_code = ""
    
    for row_num, (string, macro) in enumerate(zip(strings, string_macros(strings)), 4):
        macro_code += "{}: MACRO\n".format(macro)

        # If more space is needed in the patch text bank, this can be modified
        # to fill as much as possible of the space available before the far
        # text control code. For now, though, this is clean and nice!

        num_bytes = num_bytes_in(string)
        if num_bytes <= string.space:
            # Translations that fit within the space of the original should go there.
            macro_code += to_asm(string)
        else:
            # Otherwise, they need to get put in the fearsome PATCH TEXT BANK!
            label = macro[0].upper() + macro[1:]
            text_bank_code += "{}::\n".format(label)
            text_bank_code += to_asm(string)
            text_bank_code += "\n"

            first_start = string.lines[0].start
            if first_start == 'db':
                raise ValueError(
                    "DB string too long (row {})! "
                    "Adjust some byte lengths, maybe?".format(row_num)
                )
            
            macro_code += "\t{} \"<FAR_TEXT>\"\n".format(first_start)
            macro_code += "\tdw {}\n".format(label)

            num_bytes = 4
            if num_bytes > string.space:
                raise ValueError(
                    "Too little space for a far text code (row {})! "
                    "Make space for 4 bytes, maybe?".format(row_num)
                )
        
        if num_bytes < string.space:
            macro_code += "\nREPT {} - {}\n\tdb \"@\"\nENDR\n".format(string.space, num_bytes)
        macro_code += "ENDM\n\n"

    return macro_code, text_bank_code

def main(argv):
    script_name = os.path.split(argv[0])[-1]
    if len(argv) == 1:
        print("Usage: {} <CSV input files...>".format(script_name))
        return 1
    
    for csv_path in argv[1:]:
        print ("Compiling \"{}\" to .inc and .asm...".format(csv_path))

        macro_code, text_bank_code = compile(csv_path)
        inc_path = os.path.join('build', os.path.splitext(csv_path)[0] + '.inc')
        asm_path = os.path.splitext(inc_path)[0] + '.asm'
        os.makedirs(os.path.split(inc_path)[0], exist_ok=True)

        with open(inc_path, 'w', encoding='utf-8') as f:
            f.write(macro_code)
        with open(asm_path, 'w', encoding='utf-8') as f:
            f.write(text_bank_code)

if __name__ == '__main__':
    sys.exit(main(sys.argv))
