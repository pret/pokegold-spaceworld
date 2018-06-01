#!/usr/bin/python3

from sys import argv, stdout
from read_charmap import read_charmap


bank_size = 0x4000

charmap = read_charmap()

if len(argv) != 4:
	print(f"Usage: {argv[0]} path/to/ROM.gb start_offset end_offset\noffsets are in the form bank:address (both hex), and end_offset is *not* included.")
	exit(1)


try:
	start_bank,start_addr = [ int(s, 16) for s in argv[2].split(':') ]
	end_bank,  end_addr   = [ int(s, 16) for s in argv[3].split(':') ]
	if start_bank != 0:
		start_addr += (start_bank - 1) * bank_size
	if end_bank != 0:
		end_addr   += (end_bank   - 1) * bank_size
except Error:
	print("Please specify valid offsets (bank:address, both hex)")
	exit(1)


with open(argv[1], "rb") as f:
	f.seek(start_addr)

	string = ""
	while start_addr < end_addr:
		b = f.read(1)
		v = int.from_bytes(b, "little")
		string += char_table[ v ]
		start_addr += 1

	stdout.buffer.write( f"db \"{string}\"\n".encode('utf-8') )
