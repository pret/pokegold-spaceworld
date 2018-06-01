import os, io

def parse_int(s):
	# assumes integers are literal; no +-*/, etc
	s = s.strip()
	if s.startswith('$'):
		return int(s[1:], 16)
	if s.startswith('%'):
		return int(s[1:], 2)
	return int(s)

def parse_string(s):
	# assumes strings are literal; no STRCAT() etc
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
