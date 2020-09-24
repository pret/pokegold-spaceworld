#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Usage: python3 mask.py [pokegold-spaceworld.map] [mask.png]

Generate a 2BPP visualizing the space used by each bank in the ROM.
"""

import sys

from mapreader import MapReader

def main():
    mapfile = sys.argv[1] if len(sys.argv) >= 2 else 'pokegold-spaceworld.map'
    filename = sys.argv[2] if len(sys.argv) >= 3 else 'mask.w1024.2bpp'

    num_banks = 0x40
    bank_mask = 0x3FFF
    bank_size = 0x4000 # bytes

    r = MapReader()
    with open(mapfile, 'r', encoding='utf-8') as f:
        l = f.readlines()
    r.read_map_data(l)

    default_bank_data = {'sections': [], 'used': 0, 'slack': bank_size}
    with open(filename, 'wb') as f:
        for bank in range(num_banks):
            hits = bytearray([0x00] * bank_size)
            data = r.bank_data['rom bank'].get(bank, default_bank_data)
            for s in data['sections']:
                if s['beg'] > s['end']:
                    continue
                if s['beg'] == 0x0000 and s['end'] > 0xFFFF:
                    # https://github.com/gbdev/rgbds/issues/515
                    continue
                beg = s['beg'] & bank_mask
                end = s['end'] & bank_mask
                for i in range(beg, end + 1):
                    hits[i] = 0xFF
            f.write(hits)

if __name__ == '__main__':
    main()
