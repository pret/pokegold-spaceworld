#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import re
import sys
from collections import OrderedDict


class MapFile:
    LINETYPE_BLANK = -1
    LINETYPE_BANK = 0
    LINETYPE_SECTION = 1
    LINETYPE_SYMBOL = 2
    LINETYPE_SLACK = 3
    LINETYPE_EMPTY = 4

    bank_types = ('ROM', 'VRAM', 'SRAM', 'WRAM', 'OAM', 'HRAM')
    bank_starts = (0x4000, 0x8000, 0xa000, 0xd000, 0xfe00, 0xff80)

    class MapFileLine:
        def __init__(self, linestr):
            self.raw = linestr

        def __str__(self):
            return self.raw

    class BlankLine(MapFileLine):
        def __init__(self, linestr):
            super().__init__(linestr)

    class BankLine(MapFileLine):
        def __init__(self, linestr):
            super().__init__(linestr)
            match = re.search('#(\d+)', linestr, re.I)
            if match is None:
                self.bankno = 0
            else:
                self.bankno = int(match.group(1))
            bankname = linestr.split()[0].rstrip(':')
            try:
                self.banktype = MapFile.bank_types.index(bankname)
            except ValueError as e:
                raise ValueError(f'Unrecognized bank type: {bankname}') from e

        @property
        def name(self):
            if self.banktype == 0:  # ROM
                if self.bankno == 0:
                    return 'ROM0'
                else:
                    return f'ROMX ${self.bankno:02x}'
            elif self.banktype == 3:  # WRAM
                if self.bankno == 0:
                    return 'WRAM0'
                else:
                    return f'WRAMX ${self.bankno:02x}'
            elif self.banktype < 3:
                return f'{MapFile.bank_types[self.banktype]} {self.bankno:d}'
            else:
                return f'{MapFile.bank_types[self.banktype]}'

        @property
        def start(self):
            if self.bankno == 0:
                if self.banktype == 0:
                    return 0x0000
                elif self.banktype == 3:
                    return 0xc000
            return MapFile.bank_starts[self.banktype]

        def __hash__(self):
            return hash(self.name)

    class SectionLine(MapFileLine):
        def __init__(self, linestr):
            super().__init__(linestr)
            match = re.search(r'\$([0-9A-F]{4}) \(\$([0-9A-F]+) bytes\) \["(.+)"\]', linestr, re.I)
            end, size, self.name = match.groups()
            self.end = int(end, 16)
            self.size = int(size, 16)
            if self.size > 0:
                self.end += 1
            self.start = self.end - self.size
            self.symbols = []

    class SymbolLine(MapFileLine):
        def __init__(self, linestr):
            super().__init__(linestr)

    class SlackLine(MapFileLine):
        def __init__(self, linestr):
            super().__init__(linestr)
            match = re.search(r'\$([0-9A-F]{4}) bytes', linestr, re.I)
            self.slack = int(match.group(1), 16)

    class EmptyLine(MapFileLine):
        def __init__(self, linestr):
            super().__init__(linestr)

    line_classes = {
        LINETYPE_BLANK: BlankLine,
        LINETYPE_BANK: BankLine,
        LINETYPE_SECTION: SectionLine,
        LINETYPE_SYMBOL: SymbolLine,
        LINETYPE_SLACK: SlackLine,
        LINETYPE_EMPTY: EmptyLine
    }

    def __init__(self, fname, *fpargs, **fpkwargs):
        self.fname = fname
        self.fp = None
        self.fpargs = fpargs
        self.fpkwargs = fpkwargs

    def open(self):
        if self.fp is None or self.fp.closed:
            self.fp = open(self.fname, *self.fpargs, **self.fpkwargs)

    def close(self):
        if not self.fp.closed:
            self.fp.close()
        self.fp = None

    def __enter__(self):
        self.open()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.fp.__exit__(exc_type, exc_val, exc_tb)
        self.fp = None

    def __iter__(self):
        if self.fp is None or self.fp.closed:
            print('Warning: Cowardly refusing to read closed file', file=sys.stderr)
            raise StopIteration
        for line in self.fp:
            linestr = line.strip('\n')
            if linestr == '':
                line_type = self.LINETYPE_BLANK
            elif 'SECTION:' in linestr:
                line_type = self.LINETYPE_SECTION
            elif 'SLACK:' in linestr:
                line_type = self.LINETYPE_SLACK
            elif linestr == '  EMPTY':
                line_type = self.LINETYPE_EMPTY
            elif ' = ' in linestr:
                line_type = self.LINETYPE_SYMBOL
            else:
                line_type = self.LINETYPE_BANK
            yield self.line_classes[line_type](linestr)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('mapfile', type=MapFile)
    parser.add_argument('linkfile', type=argparse.FileType('w'))
    args = parser.parse_args()

    rom_map = OrderedDict()
    cur_bank = None

    print('; Automatically generated by map2link.py', file=args.linkfile)

    with args.mapfile:
        for line in args.mapfile:
            if isinstance(line, MapFile.BankLine):
                cur_bank = line
                rom_map[cur_bank] = []
            elif isinstance(line, MapFile.SectionLine):
                rom_map[cur_bank].append(line)

    for bank, sections in rom_map.items():
        if len(sections) == 0:
            continue
        sections.sort(key=lambda s: s.start)
        print(bank.name, file=args.linkfile)
        start = bank.start
        for section in sections:
            if section.start > start:
                print(f'\t; ${start:04x}', file=args.linkfile)
                print(f'\torg ${section.start:04x}', file=args.linkfile)
            print(f'\t"{section.name}" ; ${section.start:04x}, size: ${section.size:04x}', file=args.linkfile)
            start = section.end


if __name__ == '__main__':
    main()
