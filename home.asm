
SECTION "Entry point", ROM0[$100]
    nop
    jp Init

SECTION "Global check value", ROM0[$14E]
; The ROM has an incorrect global check, so set it here
; It is not corrected by RGBFIX
    db $21, $C6


SECTION "VBlank handler", ROM0[$150]
    ; TODO


SECTION "Init", ROM0[$52F]

Init:
    di
    xor a