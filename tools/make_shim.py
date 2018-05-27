from sys import argv, stderr

for line in open(argv[1]):
    line = line.split(";")[0]
    line = line.strip()
    if line and " " in line:
        address, symbol = line.split()
        bank, pointer = address.split(":")
        bank = int(bank, 16)
        pointer = int(pointer, 16)
        section = None
        if bank == 0 and pointer < 0x4000:
            section = "ROM0"
            bank = None
        elif pointer < 0x8000:
            section = "ROMX"
        elif pointer < 0xa000:
            section = "VRAM"
        elif pointer < 0xc000:
            section = "SRAM"
        elif bank == 0 and pointer < 0xd000:
            section = "WRAM0"
            bank = None
        elif pointer < 0xe000:
            section = "WRAMX"
        elif pointer > 0xff80 and pointer <= 0xffff:
            section = "HRAM"
        else:
            stderr.write(f"Unknown section for {line}\n")
        
        if section:
            if bank:
                print(f"SECTION \"Shim for {symbol}\", {section}[${pointer:x}], BANK[${bank:x}]")
            else:
                print(f"SECTION \"Shim for {symbol}\", {section}[${pointer:x}]")
            print(f"{symbol}::\n\n")

    
    
