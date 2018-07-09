import os, errno
import re
import fix_sections_directory

os.chdir("..")
cwd = os.getcwd()

debug_lines_startswith = [
    "SECTION ",
    "else",
    "SECTION ",
    "endc"
]

with open("pokegold-spaceworld-gen.link", "r") as f:
    linkerscript = f.read()

def clean_section(line, file, multiple):
    global linkerscript
    lines = line.lstrip().split("\"")
    if "@" in lines[1] or file == lines[1] or file == "hram.asm" or file == "vram.asm" or file == "sram.asm":
        file = lines[1]
    else:
        file += ("@" + lines[1]) if multiple else ""
    
    linkerscript = linkerscript.replace("\"" + lines[1] + "\"", "\"" + file + "\"")
    if "ROMX" in lines[2]:
        return "SECTION \"%s\", ROMX" % file
    elif "HRAM" in lines[2]:
        return "SECTION \"%s\", HRAM" % file
    elif "VRAM" in lines[2]:
        return "SECTION \"%s\", VRAM" % file
    elif "ROM0" in lines[2]:
        return "SECTION \"%s\", ROM0" % file
    elif "SRAM" in lines[2]:
        return "SECTION \"%s\", SRAM" % file
    else:
        raise

TEMP_PATH = fix_sections_directory.TEMP_DIRECTORY

for root, dirs, files in os.walk(cwd):
    for file in files:
        rel_root = os.path.relpath(root, cwd)
        if not rel_root.startswith("build") and not rel_root.startswith("temp") and file.endswith(".asm") and file != "rst.asm" and file != "wram.asm" and file != "zero_checksum.asm":
            canonical_path = os.path.join(root, file)
            rel_path = os.path.relpath(canonical_path, cwd)
            with open(canonical_path, "r") as f:
                contents = f.read()
            content_lines = contents.splitlines()
            
            if "SECTION" in contents:
                print(canonical_path)
                modify_flag = False
                skip_next_line = False
                for i, line in enumerate(content_lines):
                    if not skip_next_line:
                        if line.lstrip().startswith("SECTION"):
                            modify_flag = True
                            content_lines[i] = clean_section(content_lines[i], rel_path, contents.count("SECTION") > 1)
                        elif "if DEBUG" in line:
                            debug_content_lines = content_lines[i+1:i+5]
                            debug_code = False
                            for debug_content_line, debug_line_startswith in zip(debug_content_lines, debug_lines_startswith):
                                if not debug_content_line.lstrip().startswith(debug_line_startswith):
                                    break
                            else:
                                modify_flag = True
                                content_lines[i] = "; " + content_lines[i]
                                content_lines[i+1] = clean_section(content_lines[i+1], rel_path, contents.count("SECTION") > 2)
                                content_lines[i+2] = "; " + content_lines[i+2]
                                content_lines[i+3] = "; " + content_lines[i+3]
                                content_lines[i+4] = "; " + content_lines[i+4]
                                skip_next_line = True
                    else:
                        skip_next_line = False
                
                if modify_flag:
                    output = "\n".join(content_lines)
                    print("rel root: " + rel_root)
                    try:
                        os.makedirs(TEMP_PATH + rel_root)
                    except OSError as e:
                        if e.errno != errno.EEXIST:
                            raise
                    
                    with open(TEMP_PATH + rel_path, "w+") as f:
                        f.write(output)

linkerscript_lines = linkerscript.splitlines()

i = 0
clean_wram = False

while i < len(linkerscript_lines):
    line = linkerscript_lines[i]
    if clean_wram:
        if "org $dfff" not in line:
            print(linkerscript_lines.pop(i))
        else:
            clean_wram = False
            i += 1
    elif "\"Shim for " in line:
        no_pop_count = 0
        shim_addr = line.replace(", ", " ; ").split(" ; ")[1]
        if linkerscript_lines[i-1] == "\torg " + shim_addr and linkerscript_lines[i-1] != "\torg $4000":
            print(linkerscript_lines.pop(i-1))
        else:
            no_pop_count += 1
        print(linkerscript_lines.pop(i-1 + no_pop_count))
        
        if linkerscript_lines[i-1 + no_pop_count] == "\t; " + shim_addr:
            print(linkerscript_lines.pop(i-1 + no_pop_count))
        else:
            no_pop_count += 1
        
        i -= 3 - no_pop_count
        print("")
    elif "ROMX" in line and "org $4000" not in linkerscript_lines[i+1]:
        linkerscript_lines.insert(i+1, "\torg $4000")
        i += 1
    elif line.startswith("WRAM0"):
        linkerscript_lines.insert(i+1, "\torg $c000")
        i += 1
    elif "\"Map Buffer\"" in line:
        clean_wram = True
        i += 1
    else:
        i += 1

for i in range(len(linkerscript_lines)):
    linkerscript_lines[i] = linkerscript_lines[i].split(" ; ")[0]

linkerscript = "\n".join(linkerscript_lines) + "\n"

with open(TEMP_PATH + "pokegold-spaceworld.link", "w+") as f:
    f.write(linkerscript)