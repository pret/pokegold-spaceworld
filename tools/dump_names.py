#!/usr/bin/env python

import sys, os, io

def parse_int(s):
	s = s.strip()
	if s.startswith('$'):
		return int(s[1:], 16)
	if s.startswith('%'):
		return int(s[1:], 2)
	return int(s)

def parse_string(s):
	# assumes strings are literal, no STRCAT() etc
	return s.strip('" ')

def strip_comment(s):
	# assumes ";" is not in the charmap
	return s.split(';')[0].rstrip()

def get_project_dir():
	script_path = os.path.realpath(__file__)
	script_dir = os.path.dirname(script_path)
	project_dir = os.path.join(script_dir, '..')
	return os.path.normpath(project_dir)

def get_charmap_path():
	project_dir = get_project_dir()
	return os.path.join(project_dir, 'charmap.asm')

def get_baserom_path():
	project_dir = get_project_dir()
	return os.path.join(project_dir, 'baserom.gb')

def read_charmap():
	charmap_path = get_charmap_path()
	charmap = {}
	with io.open(charmap_path, 'r', encoding='utf-8') as f:
		lines = f.readlines()
	for line in lines:
		line = strip_comment(line).lstrip()
		if not line.startswith('charmap '):
			continue
		char, value = line[len('charmap '):].rsplit(',', 1)
		char = parse_string(char)
		value = parse_int(value)
		charmap[value] = char
	return charmap

def dump_strings(data):
	charmap = read_charmap()
	ss = []
	chars = []
	for v in data:
		if v in charmap:
			c = charmap[v]
			chars.append(c)
		else:
			if chars:
				ss.append('"%s"' % ''.join(chars))
				chars = []
			ss.append('$%02x' % v)
		if v == 0x50:
			if chars:
				ss.append('"%s"' % ''.join(chars))
				chars = []
			print '\tdb %s' % ', '.join(ss)
			ss = []
	if ss:
		print '\tdb %s' % ', '.join(ss)

def read_data(bank, address, n):
	offset = bank * 0x4000 + address - 0x4000
	baserom_path = get_baserom_path()
	with open(baserom_path, 'rb') as f:
		f.seek(offset)
		data = []
		i = 0
		while i < n:
			c = f.read(1)
			v = ord(c)
			if v == 0x50:
				i += 1
			data.append(v)
	return data

#data = read_data(0x0E, 0x4D90, 64) # TrainerClassNames
#data = read_data(0x01, 0x6FEC, 255) # ItemNames
#data = read_data(0x10, 0x52A1, 251) # MoveNames
data = read_data(0x14, 0x6D75, 251) # PokemonNames

dump_strings(data)
