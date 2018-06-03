# #!/usr/bin/env python3
# coding: utf-8

from __future__ import division

import os
import sys
import argparse
import png
from mapreader import MapReader
from colorsys import hls_to_rgb

if __name__ == "__main__":
    # argument parser
    ap = argparse.ArgumentParser()
    ap.add_argument("-o", dest="filename", default="coverage.png")
    ap.add_argument("-s", dest="statsname", default="coverage.log")
    ap.add_argument("-m", dest="mapfile", required=True)
    ap.add_argument("-b", dest="num_banks", required=True, type=lambda x: int(x, 0))
    args = ap.parse_args()
    
    bank_mask = 0x3FFF
    bank_size = 0x4000 # bytes
    width = 256 # pixels per row
    bpp = 8 # bytes per pixel
    
    rom_size = args.num_banks * bank_size # bytes
    height = (args.num_banks * bank_size + (width * bpp - 1)) // (width * bpp) # pixels
    rows_per_bank = bank_size // (width * bpp)
    
    r = MapReader()
    with open(args.mapfile, 'r', encoding= "utf-8") as f:
        l = f.readlines()
    r.read_map_data(l)
    
    hit_data = [[0] * width for _ in range(height)]
    default_bank_data = {'sections': [], 'used': 0, 'slack': bank_size}
    for bank in range(args.num_banks):
        data = r.bank_data['ROM Bank'].get(bank, default_bank_data)
        for s in data['sections']:
            beg = (s['beg'] & bank_mask) + bank * bank_size
            end = (s['end'] & bank_mask) + bank * bank_size
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
    
    with open(args.statsname, 'w') as stats:
        # TODO: write stats
        pass
    
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
