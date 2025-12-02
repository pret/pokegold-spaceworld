#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import sys
from read_charmap import read_charmap

charmap = {}

bank_size = 0x4000

textcodes = {
    '<NEXT>'  : {'label': 'next',   'fin': False},
    '<LINE>'  : {'label': 'line',   'fin': False},
    '<PARA>'  : {'label': 'para',   'fin': False},
    '<CONT>'  : {'label': 'cont',   'fin': False},
    '<DONE>'  : {'label': 'done',   'fin': True},
    '<PROMPT>': {'label': 'prompt', 'fin': True},
}

# codes that end text control code 0x00
# True if this code exits control code parsing as well
end_codes = {
    '@'       : False,
    '<DONE>'  : True,
    '<PROMPT>': True,
}

def conv_address(x):
    if ':' in x:
        bank, addr = [ int(s, 16) for s in x.split(':') ]
        if (addr < bank_size and bank != 0):
            raise argparse.ArgumentTypeError('Illegal ROM bank 0x00 address {0:02X}:{1:04X}. '
                                             'Bank 0x{0:02X} must be 0x00.'.format(bank, addr))
        elif (addr >= bank_size and bank == 0):
            raise argparse.ArgumentTypeError('Illegal ROM bank 0x00 address {0:02X}:{1:04X}. '
                                             'Address 0x{1:04X} > 0x{2:04X}.'.format(bank, addr, bank_size - 1))
        elif (addr >= 2*bank_size):
            raise argparse.ArgumentTypeError('Illegal ROM bank address {0:02X}:{1:04X}. '
                                             'Address 0x{1:04X} > 0x{2:04X}.'.format(bank, addr, 2*bank_size - 1))
        return bank * 0x4000 + (addr & 0x3fff)
    return int(x, 0)

def addr2gb(addr):
    bank = addr // bank_size
    offset = addr % bank_size
    if (bank > 0):
        offset += bank_size
    return bank, offset

def transform_char(char, do_transform, is_begin):
    result = ''
    if (do_transform and char in textcodes):
        replace = textcodes[char]
        if (not is_begin):
            result += '"\n'
        result += replace['label']
        if (not replace['fin']):
            result += ' "'
        return replace['fin'], result
    else:
        if (is_begin):
            result += '"'
        return False, (result + char)

def dump_asm(data):
    
    result =  'start_asm ; text dumper cannot dump asm\n'
    result += '          ; Try dumping asm from the following offset and\n'
    result += '          ; then continue dumping text in control mode.\n'
    return True, result 
    
def dump_control(data, label, signature):

    lengths = {'b': 1, 'n': 1, 'w': 2}
    
    required_bytes = sum([lengths.get(c, 0) for c in signature])
    
    if (data['len'] - data['offset'] < required_bytes):
        #silently drop split control code
        return True, ''
    
    result = ''
    
    for c in signature:
        if result != '':
            result += ', '
        if c == 'b':
            byte = data['bytes'][data['offset']]
            data['offset'] += 1
            result += '${0:02x}'.format(byte)
        elif c == 'n':
            byte = data['bytes'][data['offset']]
            data['offset'] += 1
            result += '${0:01x}, ${1:01x}'.format(byte >> 4, byte & 0x0f)
        elif c == 'w':
            word = data['bytes'][data['offset']]
            data['offset'] += 1
            word |= data['bytes'][data['offset']] << 8
            data['offset'] += 1
            result += '${0:02x}'.format(word)
        else:
            raise ValueError('Unknown signature char in {0:s}\'s signature "{1:s}".'.format(label, signature))
    
    if (result != ''):
        result = ' ' + result
    return False, label + result

def dump_text(data):

    string = ''
    exit_control = False
    done = False
    while (not done):
        
        byte = data['bytes'][data['offset']]
        data['offset'] += 1
        
        char = charmap[byte]
        fin, tchar = transform_char(char, data['textmode'], string == '')
        string += tchar
        if (char in end_codes):
            done = True
            exit_control = end_codes[char]
            # end string if textmode didn't do it
            if not data['textmode'] or not fin:
                string += '"'
        if (data['offset'] >= data['len']):
            done = True
            string += '"'
    
    return exit_control, string 

def dump_text_control(data):
    
    res, text = dump_text(data)
    return res, 'text ' + text

control_codes = {
    0x00: dump_text_control,
    0x01: lambda data: dump_control(data, 'text_from_ram'           , 'w'   ),
    0x02: lambda data: dump_control(data, 'text_bcd'                , 'wb'  ),
    0x03: lambda data: dump_control(data, 'text_move'               , 'w'   ),
    0x04: lambda data: dump_control(data, 'text_box'                , 'wbb' ),
    0x05: lambda data: dump_control(data, 'text_low'                , ''    ),
    0x06: lambda data: dump_control(data, 'text_waitbutton'         , ''    ),
    0x07: lambda data: dump_control(data, 'text_scroll'             , ''    ),
    0x08: dump_asm,
    0x09: lambda data: dump_control(data, 'deciram'                 , 'wn'  ),
    0x0A: lambda data: dump_control(data, 'text_exit'               , ''    ),
    0x0B: lambda data: dump_control(data, 'sound_dex_fanfare_50_79' , ''    ),
    0x0C: lambda data: dump_control(data, 'text_dots'               , 'b'   ),
    0x0D: lambda data: dump_control(data, 'link_wait_button'        , ''    ),
    0x0E: lambda data: dump_control(data, 'sound_dex_fanfare_20_49' , ''    ),
    0x0F: lambda data: dump_control(data, 'sound_item'              , ''    ),
    0x10: lambda data: dump_control(data, 'sound_caught_mon'        , ''    ),
    0x11: lambda data: dump_control(data, 'sound_dex_fanfare_80_109', ''    ),
    0x12: lambda data: dump_control(data, 'sound_fanfare'           , ''    ),
    0x13: lambda data: dump_control(data, 'sound_slot_machine_start', ''    ),
    0x14: lambda data: dump_control(data, 'cry_nidorina'            , ''    ),
    0x15: lambda data: dump_control(data, 'cry_pidgeot'              , ''    ),
    0x16: lambda data: dump_control(data, 'cry_dewgong'               , ''    ),
    0x50: lambda data: (True, 'text_end\n'),
}

def print_location(data):
    return '.loc_{0:04X}:\n'.format(data['offset'] + (bank_size if data['source'] > bank_size else 0))

if __name__ == '__main__':
    # argument parser
    ap = argparse.ArgumentParser()
    ap.add_argument('--cc', dest='ccmode', action='store_true',
                    help='dump in control code mode, implies text code macro mode'
                    )
    ap.add_argument('--endless', dest='endless', action='store_true',
                    help='continue dumping even if string end text code was reached'
                    )
    ap.add_argument('--tc', dest='textmode', action='store_true', 
                    help='dump text codes (line breaks, prompt etc) as macros instead of inline text'
                    )
    ap.add_argument('-o', dest='outfile', default=sys.stdout, help='output file name')
    ap.add_argument('-m', dest='charmap', default='../constants/charmap.asm', help='charmap file name')
    ap.add_argument('rom', help='path to ROM')
    ap.add_argument('start', help='start offset', type=conv_address)
    ap.add_argument('end', help='end offset', type=conv_address, nargs='?')
    
    args = ap.parse_args()
    romname = args.rom
    start_addr = args.start
    end_addr = start_addr + bank_size if args.end is None else args.end
    ccmode = args.ccmode
    endless = args.endless
    outfile = args.outfile
    charmap = read_charmap(args.charmap)
    
    if (end_addr < start_addr):
        print('End address 0x{0:06X} ({1:02X}:{2:04X}) is before '
              'start address 0x{3:06X} ({4:02X}:{5:04X}).'.format(
                end_addr,
                *addr2gb(end_addr),
                start_addr,
                *addr2gb(start_addr)
                ),
              file=sys.stderr
        )
        sys.exit(-1)
    
    bank_addr = start_addr & (~(bank_size - 1))
    offset = start_addr - bank_addr
    end_offset = end_addr - bank_addr
    
    with open(romname, 'rb') as f:
        f.seek(bank_addr)
        bank_data = f.read(bank_size)
   
    data = {'offset': offset,
            'bytes': bank_data,
            'len': min(end_offset, len(bank_data)),
            'textmode': args.textmode,
            'source': bank_addr,
           }
    
    with open(outfile, 'wb') if outfile != sys.stdout else outfile.buffer as f:
        string = print_location(data)
        while(data['offset'] < data['len']):
            if (not ccmode):
                # dumb mode
                _, text = dump_text(data)
                # start with db unless starting with a control code
                # in textmode
                if text[0] == '"' and data['textmode']:
                    string += '\tdb   '
                elif text[0] == '"':
                    string += '\tdb '
                string += text.replace('\n', '\n\t')
                string += '\n{0:s}'.format(print_location(data))
                if (not endless):
                    break
            else:
                # control code mode
                control_byte = data['bytes'][data['offset']]
                data['offset'] += 1
                
                if (control_byte in control_codes):
                    res, text = control_codes[control_byte](data)
                    string += '\t' + text.replace('\n', '\n\t')
                    string += '\n'
                    if (res):
                        string += print_location(data)
                    # exit out of control code parsing
                    if (res and not endless):
                        break
                else:
                    print('Encountered unknown control code 0x{0:02X}. Abort...'.format(control_byte), file=sys.stderr)
                    break
            
        f.write(string.encode('utf-8'))
        f.close()
