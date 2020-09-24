#define _DEFAULT_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <getopt.h>
#include <limits.h>
#include <unistd.h>

void usage(void) {
    printf("Usage: scan_includes [-h] [-o output] [-s] [-i path] [-b path] filename\n"
           "-h, --help\n"
           "    Print usage and exit\n"
           "-o, --output\n"
           "    Filename to store the output in\n"
           "-s, --strict\n"
           "    Fail if a file cannot be read\n"
           "-i, --include\n"
           "    Add an include path\n"
           "-b, --build-prefix\n"
           "    Set path to generate non-existing files in\n"
           "-t, --target\n"
           "    Generate a makefile fragment for target file\n");
}

struct Options {
    bool help;
    char *output;
    bool strict;
    char **include_paths;
    int include_paths_len;
    char *build_prefix;
    char *target;
};

struct Options Options = {0};

void *xmalloc(size_t size)
{
    void *ptr = malloc(size);
    if (!ptr) {
        perror("malloc");
        exit(1);
    }
    return ptr;
}

void *xrealloc(void *ptr, size_t size)
{
    ptr = realloc(ptr, size);
    if (!ptr) {
        perror("realloc");
        exit(1);
    }
    return ptr;
}

void options_add_file(char *filename)
{
    Options.include_paths_len++;
    Options.include_paths = xrealloc(Options.include_paths,
            sizeof(Options.include_paths[0]) * Options.include_paths_len);
    Options.include_paths[Options.include_paths_len - 1] = filename;
}

void filelist_append(char **string, char *append)
{
    size_t orig_len = *string ? strlen(*string) : 0;
    size_t len = orig_len + strlen(append) + 2;
    if (orig_len == 0) len--;
    *string = xrealloc(*string, len);

    if (orig_len != 0) {
        (*string)[orig_len + 0] = ' ';
        (*string)[orig_len + 1] = '\0';
    } else {
        (*string)[orig_len + 0] = '\0';
    }
    strcat(*string, append);
}

char *joinpath(char *dir, char *file)
{
    size_t len = strlen(dir) + strlen(file) + 1;
    char *path = xmalloc(len);
    snprintf(path, len, "%s%s", dir, file);
    return path;
}

char *find_file(char *filename) {
    if (access(filename, F_OK) == 0) {
        char *fname = strdup(filename);
        if (!fname) {
            perror("strdup");
            exit(1);
        }
        return fname;
    }

    // Try to find file in any of the include paths
    for (int i = 0; i < Options.include_paths_len; i++) {
        char *path = joinpath(Options.include_paths[i], filename);
        if (access(path, F_OK) == 0) return path;
        free(path);
    }

    if (Options.strict) {
        fprintf(stderr, "Could not open file: '%s'\n", filename);
        exit(1);
    }
    return NULL;
}

void scan_file(char **includes, char **incbins, char *filename) {
    FILE *f = fopen(filename, "r");
    if (!f) return;

    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    rewind(f);

    char *buffer = xmalloc(size + 1);
    char *orig = buffer;
    size = fread(buffer, 1, size, f);
    buffer[size] = '\0';
    fclose(f);

    for (; buffer && (buffer - orig < size); buffer++) {
        bool is_include = false;
        bool is_incbin = false;
        switch (*buffer) {
        case ';':
            buffer = strchr(buffer, '\n');
            if (!buffer) {
                fprintf(stderr, "%s: no newline at end of file\n", filename);
                break;
            }
            break;

        case '"':
            buffer++;
            buffer = strchr(buffer, '"');
            if (!buffer) {
                fprintf(stderr, "%s: unterminated string\n", filename);
                break;
            }
            buffer++;
            break;

        case 'i':
        case 'I':
            if ((strncmp(buffer, "INCBIN", 6) == 0) ||
                    (strncmp(buffer, "incbin", 6) == 0)) {
                is_incbin = true;
            } else if ((strncmp(buffer, "INCLUDE", 7) == 0) ||
                    (strncmp(buffer, "include", 7) == 0)) {
                is_include = true;
            }
            if (is_incbin || is_include) {
                buffer = strchr(buffer, '"');
                if (!buffer) {
                    break;
                }
                buffer++;

                size_t length = strcspn(buffer, "\"");
                buffer[length] = '\0';
                char *include = find_file(buffer);

                char *append = buffer;
                if (Options.build_prefix) {
                    append = include;
                    if (!include) {
                        append = joinpath(Options.build_prefix, buffer);
                    }
                }
                if (is_include) filelist_append(includes, append);
                if (is_incbin) filelist_append(incbins, append);
                if (Options.build_prefix && !include) free(append);

                if (include && is_include) scan_file(includes, incbins, include);

                if (include) free(include);
                buffer += length + 1;
            }
            break;

        }
        if (!buffer) {
            break;
        }

    }

    free(orig);
}

int main(int argc, char* argv[]) {
    int i = 0;
    struct option long_options[] = {
        {"help", no_argument, 0, 'h'},
        {"output", required_argument, 0, 'o'},
        {"strict", no_argument, 0, 's'},
        {"include", required_argument, 0, 'i'},
        {"build-prefix", required_argument, 0, 'b'},
        {"target", required_argument, 0, 't'},
        {0}
    };
    int opt = -1;
    while ((opt = getopt_long(argc, argv, "ho:si:b:t:", long_options, &i)) != -1) {
        switch (opt) {
        case 'h':
            Options.help = true;
            break;
        case 'o':
            Options.output = optarg;
            break;
        case 's':
            Options.strict = true;
            break;
        case 'i':
            options_add_file(optarg);
            break;
        case 'b':
            Options.build_prefix = optarg;
            break;
        case 't':
            Options.target = optarg;
            break;
        default:
            usage();
            exit(1);
            break;
        }
    }
    argc -= optind;
    argv += optind;
    if (Options.help) {
        usage();
        return 0;
    }
    if (argc < 1) {
        usage();
        exit(1);
    }

    char *includes = NULL;
    char *incbins = NULL;
    char *filename = find_file(argv[0]);
    if (filename) scan_file(&includes, &incbins, filename);

    FILE *f = stdout;
    if (Options.output) {
        f = fopen(Options.output, "w");
        if (!f) {
            perror("fopen");
            exit(1);
        }
    }

    if (Options.target) {
        fprintf(f, "%s:", Options.target);
    }
    if (includes) fprintf(f, " %s", includes);
    if (incbins) fprintf(f, " %s", incbins);
    fprintf(f, "\n");

    if (Options.target && Options.output) {
        fprintf(f, "%s:", Options.output);
        if (includes) fprintf(f, " %s", includes);
        fprintf(f, "\n");
    }
    return 0;
}
