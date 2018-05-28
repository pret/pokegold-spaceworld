; rst vectors

SECTION "rst00", ROM0[$000]
    rst $38

SECTION "rst08", ROM0[$008]
    rst $38

SECTION "rst10", ROM0[$010]
    rst $38

SECTION "rst18", ROM0[$018]
    rst $38

SECTION "rst20", ROM0[$020]
    rst $38

SECTION "rst28", ROM0[$028]
    rst $38

SECTION "rst30", ROM0[$030]
    rst $38

SECTION "rst38", ROM0[$038]
    jp $F080 ; Jumps in the middle of unmapped memory. Probably used to trigger a breakpoint of sorts.
