#!/usr/bin/python3.6

import argparse
from functools import total_ordering


@total_ordering
class GBSection:
    ROM0 = 0
    ROMX = 1
    VRAM = 2
    SRAM = 3
    WRAM0 = 4
    WRAMX = 5

    __thresholds__ = (0x4000, 0x8000, 0xa000, 0xc000, 0xd000, 0xe000)

    def __init__(self, addr):
        self.ident = sum(x <= addr for x in self.__thresholds__)

    @property
    def start(self):
        if self.ident == self.ROM0:
            return 0
        return self.__thresholds__[self.ident - 1]

    @property
    def end(self):
        return self.__thresholds__[self.ident]

    def __eq__(self, other):
        return self.ident == other.ident

    def __lt__(self, other):
        return self.ident < other.ident


def read_sym(filename):
    with open(filename) as fp:
        for line in fp:
            try:
                line, *rest = line.split(';')
                pointer, name = line.split()
                bank, addr = (int(part, 16) for part in pointer.split(':'))
                yield bank, addr, name
            except ValueError:
                continue


def sort_key(args):
    bank, addr, name = args
    return GBSection(addr), bank, addr, name


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('symfile')
    args = parser.parse_args()

    symbols = list(read_sym(args.symfile))
    symbols.sort(key=sort_key)
    with open(args.symfile, 'w') as fp:
        for bank, addr, name in symbols:
            print(f'{bank:02X}:{addr:04X}', name, file=fp)


if __name__ == '__main__':
    main()
