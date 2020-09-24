#!/usr/bin/env python3

from sys import argv, stderr

def warn(s):
    print("WARNING:", s.rstrip(), file=stderr)

for i, line in enumerate(open(argv[1])):
    content = line.split(";", 1)[0].strip()

    bankaddr_name = content.split(" ", 1)
    if len(bankaddr_name) != 2:
        continue
    name = bankaddr_name[1].strip()

    bank_addr = bankaddr_name[0].split(":")
    if len(bank_addr) != 2:
        warn("Can't shim line %d: %s" % (i+1, line))
        continue
    bank = int(bank_addr[0], 16)
    addr = int(bank_addr[1], 16)

    if 0x0000 <= addr < 0x4000 and bank == 0:
        section = "ROM0"
        bank = None
    elif 0x4000 <= addr < 0x8000 and 1 <= bank < 128:
        section = "ROMX"
    elif 0x8000 <= addr < 0xA000 and 0 <= bank < 2:
        section = "VRAM"
    elif 0xA000 <= addr < 0xC000 and 0 <= bank < 16:
        section = "SRAM"
    elif 0xC000 <= addr < 0xD000 and bank == 0:
        section = "WRAM0"
        bank = None
    elif 0xD000 <= addr < 0xE000 and 0 <= bank < 16:
        section = "WRAMX"
    elif 0xFE00 <= addr < 0xFEA0 and bank == 0:
        section = "OAM"
        bank = None
    elif 0xFF80 <= addr < 0xFFFF and bank == 0:
        section = "HRAM"
        bank = None
    else:
        warn("Invalid bank/address on line %d: %s" % (i+1, line))
        continue

    bankdec = ", BANK[$%x]" % bank if bank is not None else ""
    print('SECTION "Shim %s", %s[$%x]%s' % (name, section, addr, bankdec))
    print("%s::" % name)
