#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from __future__ import division

import os
import sys
import argparse
import png
from mapreader import MapReader
from colorsys import hls_to_rgb

if __name__ == '__main__':
    # argument parser
    ap = argparse.ArgumentParser()
    ap.add_argument('-r', dest='romname')
    ap.add_argument('-o', dest='filename', default='coverage.png')
    ap.add_argument('-m', dest='mapfile', required=True)
    ap.add_argument('-b', dest='num_banks', required=True, type=lambda x: int(x, 0))
    args = ap.parse_args()
    
    bank_mask = 0x3FFF
    bank_size = 0x4000 # bytes
    width = 256 # pixels per row
    bpp = 8 # bytes per pixel
    
    romname = args.romname
    rom_size = args.num_banks * bank_size # bytes
    height = (args.num_banks * bank_size + (width * bpp - 1)) // (width * bpp) # pixels
    rows_per_bank = bank_size // (width * bpp)
    
    r = MapReader()
    try:
        with open(args.mapfile, 'r') as f:
            l = f.readlines()
    except UnicodeDecodeError:
        # Python 3 seems to choke on the file's encoding, but the `encoding` keyword only works on Py3
        with open(args.mapfile, 'r', encoding= 'utf-8') as f:
            l = f.readlines()
    r.read_map_data(l)
    
    default_bank_data = {'sections': [], 'used': 0, 'slack': bank_size}
    filler = [0x00, 0xFF]
    
    if (romname is not None):
        with open(romname, 'rb') as f:
            for rb in range(0, args.num_banks):
                bank_data = r.bank_data['ROM0 bank' if rb == 0 else 'ROMX bank']
                data = bank_data.get(rb, default_bank_data)
                bank = f.read(bank_size)
                if (bank[bank_size - 1] in filler):
                    fill = bank[bank_size - 1]
                    for i in reversed(range(-1, bank_size - 1)):
                        if (i < 0 or bank[i] != fill):
                            break
                    # i is now pointing to first different byte
                    beg = i + 1     + (0 if rb == 0 else bank_size)
                    end = bank_size + (0 if rb == 0 else bank_size)
                    data['sections'].append({'beg': beg, 'end': end, 'name': 'Section_Trailing_Fill', 'symbols': []})
    
    hit_data = [[0] * width for _ in range(height)]
    for bank in range(args.num_banks):
        bank_data = r.bank_data['ROM0 bank' if bank == 0 else 'ROMX bank']
        data = bank_data.get(bank, default_bank_data)
        for s in data['sections']:
            beg = (s['beg'] & bank_mask) + bank * bank_size
            end = ((s['end'] -1) & bank_mask) + bank * bank_size # end is exclusive
            # skip zero-sized entries
            if (s['beg'] == s['end']):
                continue
            y_beg = beg // (width * bpp)
            x_beg = (beg % (width * bpp)) // bpp
            y_end = end // (width * bpp)
            x_end = (end % (width * bpp)) // bpp
            #print('beg {0} end {1}: {2}/{3} -- {4}/{5}'.format(beg, end, y_beg, x_beg, y_end, x_end))
            # special case y_beg/x_beg and y_end/x_end
            if (y_beg == y_end and x_beg == x_end):
                hit_data[y_beg][x_beg] += end - beg + 1
            else:
                hit_data[y_beg][x_beg] += bpp - ((beg % (width * bpp)) - x_beg * bpp)
                hit_data[y_end][x_end] += ((end % (width * bpp)) - x_end * bpp + 1)
            # regular case
            for y in range(y_beg, y_end + 1):
                x_line_beg = 0         if y_beg != y else x_beg + 1
                x_line_end = width - 1 if y_end != y else x_end - 1
                for x in range(x_line_beg, x_line_end + 1):
                    hit_data[y][x] += bpp
    
    png_data = []
    for i, row in enumerate(hit_data):
        bank = i // rows_per_bank
        hue = 0 if bank % 2 else 120
        row_png_data = ()
        for col in row:
            hls = (hue/360.0, 1.0 - (col/bpp * (100 - 15))/100.0, 1.0)
            rgb = tuple(255 * x for x in hls_to_rgb(*hls))
            row_png_data += rgb
        png_data.append(row_png_data)
    
    with open(args.filename, 'wb') as f:
        w = png.Writer(width, height)
        w.write(f, png_data)
