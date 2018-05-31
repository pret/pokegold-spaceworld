# #!/usr/bin/env python3
# coding: utf-8

from __future__ import division
import os
import argparse
from mapreader import MapReader
import png
from colorsys import hls_to_rgb

if __name__ == "__main__":
    # argument parser
    ap = argparse.ArgumentParser()
    ap.add_argument("-o", dest="filename", default="coverage.png")
    ap.add_argument("-s", dest="statsname", default="coverage.stats")
    ap.add_argument("-m", dest="mapfile", required=True)
    ap.add_argument("-b", dest="num_banks", required=True, type=lambda x: int(x, 0))
    
    args = ap.parse_args()
    
    width = 256
    bpp = 8 #bytes per pixel
    height = (args.num_banks * 0x4000 + (width * bpp - 1)) // (width * bpp)
    
    r = MapReader()
    f = open(args.mapfile, 'r')
    l = f.readlines()
    f.close()
    
    r.read_map_data(l)
    bank_data = r.bank_data
    hit_data = [[0 for x in range(width)] for y in range(height)]
    
    with open(args.statsname, 'w') as stats:
        
        for bank in range(0,args.num_banks):
            
            data = bank_data['ROM Bank'].get(bank, {'sections': [], 'used': 0, 'slack': 0x4000})
            
            for s in data['sections']:
                beg = (s['beg'] & 0x3FFF) + bank * 0x4000
                end = (s['end'] & 0x3FFF) + bank * 0x4000
                y_beg = beg // (width * bpp)
                x_beg = (beg % (width * bpp)) // bpp
                
                y_end = end // (width * bpp)
                x_end = (end % (width * bpp)) // bpp
                
                #print('beg {0} end {1}: {2}/{3} -- {4}/{5}'.format(beg, end, y_beg, x_beg, y_end, x_end))
                
                # special case y_beg/x_beg and y_end/x_end
                if (end - beg + 1 < bpp):
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

    
    with open(args.filename, 'wb') as pngfile:
    
        w = png.Writer(width, height);
        
        pngdata = []
        for row in hit_data:
            row_png_data = ()
            for col in row:
                
                if (0 != col):
                    print('Here')
                rgb = [255 * x for x in hls_to_rgb(120/360, 1.0 - (col/bpp * (100 - 15))/100, 100/100)]
                row_png_data += tuple(rgb)
            
            pngdata.append(row_png_data)
    
        w.write(pngfile, pngdata)
