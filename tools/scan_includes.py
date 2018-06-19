#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Get all the dependencies of RGBDS assembly files recursively,
and output them using Make dependency syntax.
"""

# Script adapted from the Telefang disassembly / fan translation project.

from __future__ import print_function
from __future__ import unicode_literals

import argparse
import os
import re
import sys
if sys.version_info[0] < 3:
    from codecs import open

INCLUDE_RE = re.compile(r"^(?:[a-zA-Z0-9_.]+:?:?)?\s*(INC(?:LUDE|BIN))", re.IGNORECASE)

def dependencies_in(asm_file_paths, build_dirs=[]):
    asm_file_paths = list(asm_file_paths)
    dependencies = {}
    
    for path in asm_file_paths:
        if path not in dependencies:
            asm_dependencies, bin_dependencies = shallow_dependencies_of(path, build_dirs)
            dependencies[path] = asm_dependencies | bin_dependencies
            asm_file_paths += asm_dependencies

    return dependencies

def shallow_dependencies_of(asm_file_path, build_dirs=[]):
    asm_dependencies = set()
    bin_dependencies = set()

    with open(asm_file_path, 'r', encoding='utf-8') as f:
        for line in f:
            m = INCLUDE_RE.match(line)
            if m is None:
                continue
            
            keyword = m.group(1).upper()
            line = line.split(';', 1)[0]
            # RGBDS treats absolute(-looking) paths as relative,
            # so leading slashes should be stripped.
            path = line[line.index('"') + 1:line.rindex('"')].lstrip('/')
            if keyword == 'INCLUDE':
                asm_dependencies.add(path)
            else:
                if os.path.isfile(path) or not build_dirs:
                    bin_dependencies.add(path)
                else:
                    bin_dependencies.update(os.path.join(d, path) for d in build_dirs)
    
    return asm_dependencies, bin_dependencies

def main(argv):
    script_name = os.path.basename(__file__)
    parser = argparse.ArgumentParser(prog=script_name, add_help=False)
    parser.add_argument('-h', '--help', action='help', help="Show this help and exit.")
    parser.add_argument('-b', metavar="build directories", action='append', default=[],
                        help="Build directory to generate dependencies for "
                        "if files don't exist at the exact path specified. "
                        "Multiple build directories may be specified.")
    parser.add_argument('files', metavar='file', nargs='+',
                        help="An assembly file to generate dependencies for.")
    
    args = parser.parse_args(argv)

    for path, dependencies in dependencies_in(args.files, args.b).items():
        # It seems that if A depends on B which depends on C, and
        # C is modified, Make needs you to change the modification
        # time of B too. That's the reason for the "@touch $@".
        # This does mean mtimes on .asm files are updated when building,
        # but the alternative opens up a whole can of problems.
        if dependencies:
            print("{}: {}\n\t@touch $@".format(path, ' '.join(dependencies)))

if __name__ == '__main__':
    main(sys.argv[1:])
