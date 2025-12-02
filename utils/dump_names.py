#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import sys, os, io
from read_charmap import read_charmap

def calc_bank(p):
	return p // 0x4000

def calc_address(p):
	b = calc_bank(p)
	o = b * 0x4000
	return 0x4000 + p - o

def get_sym_loc(p):
	b, a = calc_bank(p), calc_address(p)
	return '%02x:%04x' % (b, a)

def get_project_dir():
	script_path = os.path.realpath(__file__)
	script_dir = os.path.dirname(script_path)
	project_dir = os.path.join(script_dir, '..')
	return os.path.normpath(project_dir)
	
def get_baserom_path():
	project_dir = get_project_dir()
	return os.path.join(project_dir, 'baserom.gb')

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

p = 0xfcaaf # Landmarks
print get_sym_loc(p)
data = read_data(calc_bank(p), calc_address(p), 45)
dump_strings(data)
