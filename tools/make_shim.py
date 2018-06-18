#!/usr/bin/env python

from __future__ import print_function
import argparse
from sys import stderr
from collections import OrderedDict, namedtuple

Section = namedtuple('Section', ('end', 'invalid', 'banked'))
section_list = OrderedDict((
    ('ROM0', Section(0x4000, False, False)),
    ('ROMX', Section(0x8000, False, True)),
    ('VRAM', Section(0xA000, False, True)),
    ('SRAM', Section(0xC000, False, True)),
    ('WRAM0', Section(0xD000, False, False)),
    ('WRAMX', Section(0xE000, False, True)),
    ('EchoRAM', Section(0xFE00, True, False)),
    ('OAM', Section(0xFEA0, False, False)),
    ('IO', Section(0xFF80, True, False)),
    ('HRAM', Section(0xFFFF, False, False))
))

parser = argparse.ArgumentParser()
parser.add_argument('files', nargs='+', type=argparse.FileType())
parser.add_argument('-w', action='store_true')
parser.add_argument('-d', action='store_true')
parser.add_argument('-t', action='store_true')
args = parser.parse_args()


if args.w or args.d:
    section_list['WRAM0'] = Section(0xE000, *section_list['WRAM0'][1:])

if args.t:
    section_list['ROM0'] = Section(0x8000, *section_list['ROM0'][1:])


for f in args.files:
    for line in f:

        # Strip out the comment
        line = line.split(";")[0].strip()
        if not line:
            continue

        # Read the address
        try:
            address, symbol = line.split()
            bank, pointer = address.split(":")
            bank = int(bank, 16)
            pointer = int(pointer, 16)
        except ValueError:
            print("Error: Cannot parse line: %s" % line, file=stderr)
            raise

        section = None
        for name, section_type in section_list.items():
            if pointer < section_type.end:
                if section_type.invalid:
                    print("Warning: cannot shim '%s' in section type '%s'" % (symbol, name), file=stderr)
                    section = False
                else:
                    section = name
                    if not section_type.banked:
                        bank = None
                break
        else:
            # Didn't find a section
            print("Unknown section for '%s'" % line, file=stderr)
            continue

        if not section:
            # Found section, but cannot shim it
            continue

        print("SECTION \"Shim for %s\", %s[$%04X]" % (symbol, section, pointer), end='')
        if bank:
            print(", BANK[$%04X]" % bank, end='')
        print("\n%s::\n\n" % symbol)
