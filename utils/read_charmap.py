#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from re import compile
from sys import stderr

charmap_regex = compile('[ \t]*charmap[ \t]+"(.*?)",[ \t]*(\$[0-9A-Fa-f]{2}|%[01]{8}|[0-9]{3})')
# A charmap line is
# [ \t]*   - zero or more space chars
# charmap  - literal charmap
# [ \t]+   - one or more space chars
# "(.*?)"  - a lazily-matched text identifier in quotes
# ,        - literal comma
# [ \t]*   - zero or more space chars
# (        - either of
#   \$[0-9A-Fa-f]{2} - two hexadecimal digits preceeded by literal $
#   %[01]{8}         - eight dual digits preceeded by literal %
#   [0-9]{3}         - three decimal digits
# )

def parse_int(s):
	# assumes integers are literal; no +-*/, etc
	s = s.strip()
	if s.startswith('$'):
		return int(s[1:], 16)
	if s.startswith('%'):
		return int(s[1:], 2)
	return int(s)

def read_charmap(charmap_path):
	charmap = {}
	with open(charmap_path, 'r', encoding='utf-8') as f:
		lines = f.readlines()
	for line in lines:
		m = charmap_regex.match(line)
		if m is None:
			continue
		char = m.group(1)
		value = parse_int(m.group(2))
		if value in charmap:
			print('Value {0:s} already in charmap, dropping it in favor of first charmap entry'.format(m.group(2)))
			continue
		charmap[value] = char
	return charmap
