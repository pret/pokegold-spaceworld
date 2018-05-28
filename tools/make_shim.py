#!/usr/bin/env python

from __future__ import print_function
from sys import argv, stderr, exit


section_list = [
    {'end': 0x4000, 'invalid': False, 'name': "ROM0",  'banked': False},
    {'end': 0x8000, 'invalid': False, 'name': "ROMX",  'banked': True},
    {'end': 0xA000, 'invalid': False, 'name': "VRAM",  'banked': True},
    {'end': 0xC000, 'invalid': False, 'name': "SRAM",  'banked': True},
    {'end': 0xD000, 'invalid': False, 'name': "WRAM0", 'banked': False},
    {'end': 0xE000, 'invalid': False, 'name': "WRAMX", 'banked': True},
    {'end': 0xFE00, 'invalid': True , 'name': "Echo RAM"},
    {'end': 0xFEA0, 'invalid': False, 'name': "OAM",   'banked': False},
    {'end': 0xFF80, 'invalid': True , 'name': "FEXX / IO"},
    {'end': 0xFFFF, 'invalid': False, 'name': "HRAM",  'banked': False}
]


argv_id = 1
file_list = []
options = []
while argv_id < len(argv):
    arg = argv[argv_id]

    if arg[0] != '-':
        file_list.append(arg)
        argv_id += 1
        continue

    # An empty '--' stops parsing arguments
    if arg == '--':
        argv_id += 1
        break

    if arg[1] == '-':
        options.append(option[2:])
    elif arg[1] != '-':
        for option in arg[1:]:
            options.append(option)

    argv_id += 1

# Add remaining files to the list
for arg in argv[argv_id:]:
    file_list.append(arg)


if 'w' in options or 'd' in options:
    section_list[4]['end'] = 0xE000

if 't' in options:
    section_list[0]['end'] = 0x8000


for file_name in file_list:
    for line in open(file_name, "rt"):

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
        except:
            print("Error: Cannot parse line: %s" % line, file=stderr)
            exit(1)

        section = None
        for section_type in section_list:
            if pointer < section_type['end']:
                if section_type['invalid']:
                    print("Warning: cannot shim '%s' in section type '%s'" % (symbol, section_type['name']), file=stderr)
                    section = False
                else:
                    section = section_type['name']
                    if not section_type['banked']:
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
