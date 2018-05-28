from sys import argv, stderr


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
    elif arg[1] != '-':
        for option in arg[1:]:
            options.append(option)
    else:
        options.append(option[2:])
    argv_id += 1


if 'w' in options or 'd' in options:
    section_list[4]['end'] = 0xE000

if 't' in options:
    section_list[0]['end'] = 0x8000


for file_name in file_list:
    with open(file_name, "rt") as f:
        for line in f:
            line = line.split(";")[0]
            line = line.strip()
            if line and " " in line:
                address, symbol = line.split()
                bank, pointer = address.split(":")
                bank = int(bank, 16)
                pointer = int(pointer, 16)

                section = None
                for section_type in section_list:
                    if pointer < section_type['end']:
                        if section_type['invalid']:
                            stderr.write(f"Warning: cannot shim '{symbol}' in section type '{section_type['name']}'\n")
                            section = False
                        else:
                            section = section_type['name']
                            if not section_type['banked']:
                                bank = None
                        break
                
                if section == False: # Found section, but cannot shim it
                    continue
                
                if section == None: # Didn't find a section at all
                    stderr.write(f"Unknown section for {line}\n")
                
                if section:
                    if bank:
                        print(f"SECTION \"Shim for {symbol}\", {section}[${pointer:x}], BANK[${bank:x}]")
                    else:
                        print(f"SECTION \"Shim for {symbol}\", {section}[${pointer:x}]")
                    print(f"{symbol}::\n\n")

    
    
