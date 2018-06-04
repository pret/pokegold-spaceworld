#include <stdio.h>
#include <getopt.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

struct Section {
    unsigned short end;
    bool invalid;
    char * name;
    bool banked;
};

typedef struct Section section_t;

// These functions are like strspn and strcspn, but from the right of the string rather than the left.
size_t strrspn(const char *s1, const char *s2) {
    const char * _s1 = s1;
    const char * _s2;

    while (*_s1++);
    _s1--;
    while (_s1 > s1) {
        for (_s2 = s2; *_s2; _s2++) {
            if (_s1[-1] == *_s2) {
                break;
            }
        }
        if (*_s2 == 0)
            break;
        _s1--;
    }

    return _s1 - s1;
}

size_t strrcspn(const char *s1, const char *s2) {
    const char * _s1 = s1;
    const char * _s2;

    while (*_s1++);
    _s1--;
    while (_s1 > s1) {
        for (_s2 = s2; *_s2; _s2++) {
            if (_s1[-1] == *_s2)
                break;
        }
        if (*_s2)
            break;
        _s1--;
    }

    return _s1 - s1;
}

#define RIP(errmsg) {                                                \
    fprintf(stderr, "%s:%d:%s: %s\n", fname, lineno, eline, errmsg); \
    if (file) fclose(file);                                          \
    return 1;                                                        \
}

int main(int argc, char * argv[]) {
    int ch;
    char line[16*1024];
    char eline[16*1024];
    char *lineptr = NULL;
    char *fname;
    int lineno;

    section_t section_list[] = {
        {0x4000, false, "ROM0", false},
        {0x8000, false, "ROMX", true},
        {0xA000, false, "VRAM", true},
        {0xC000, false, "SRAM", true},
        {0xD000, false, "WRAM0", false},
        {0xE000, false, "WRAMX", true},
        {0xFE00, true, "Echo RAM", false},
        {0xFEA0, false, "OAM", false},
        {0xFF80, true, "FEXX / IO", false},
        {0xFFFF, false, "HRAM", false},
        {}
    };

    while ((ch = getopt(argc, argv, "wdt")) != -1) {
        switch (ch) {
            case 'w':
            case 'd':
                section_list[4].end = 0xE000;
                break;
            case 't':
                section_list[0].end = 0x8000;
                break;
        }
    }

    for (int arg_idx = optind; arg_idx < argc; arg_idx++) {
        eline[0] = 0;
        lineno = 0;
        fname = argv[arg_idx];
        FILE * file = fopen(fname, "r");
        if (file == NULL)
            RIP("Unable to open file");
        while ((lineptr = fgets(line, sizeof(line), file)) != NULL) {
            lineno++;
            unsigned short bank = 0;
            unsigned short pointer = 0;
            char * symbol = NULL;
            char * end;
            char * addr_p;
            strcpy(eline, line);  // Unmodified copy for tracebacks
            *strrchr(eline, '\n') = 0;

            // line = line.split(";")[0].strip()
            lineptr += strspn(lineptr, " \t\n");
            end = strchr(lineptr, ';');
            if (end) *end = 0;
            lineptr[strrspn(lineptr, " \t\n")] = 0;
            if (!*lineptr)
                continue;

            // Get the bank, address, and symbol
            end = lineptr + strcspn(lineptr, " \t\n");
            symbol = end + strspn(end, " \t\n");
            if (!*symbol)
                RIP("Declaration not in \"bank:addr Name\" format");
            *end = 0;
            addr_p = strchr(lineptr, ':');
            if (!addr_p)
                RIP("Pointer not in bank:addr format");
            *addr_p++ = 0;
            pointer = strtoul(addr_p, &end, 16);
            if (pointer == 0 && end == addr_p)
                RIP("Unable to parse symbol address");
            bank = strtoul(lineptr, &end, 16);
            if (bank == 0 && end == lineptr)
                RIP("Unable to parse bank number");

            // Main loop
            const char * section = NULL;
            section_t * section_type;

            for (section_type = section_list; section_type->end; section_type++) {
                if (pointer < section_type->end) {
                    if (section_type->invalid) {
                        fprintf(stderr, "Warning: cannot shim '%s' in section type '%s'\n", symbol, section_type->name);
                    } else {
                        section = section_type->name;
                        if (!section_type->banked)
                            bank = 0;
                    }
                    break;
                }
            }

            if (section == NULL)
                // Found section, but cannot shim it
                continue;

            printf("SECTION \"Shim for %s\", %s[$%04X]", symbol, section, pointer);
            if (bank)
                printf(", BANK[$%04X]", bank);
            printf("\n%s::\n\n", symbol);
            fflush(stdout);
        }
        fclose(file);
    }
    return 0;
}
