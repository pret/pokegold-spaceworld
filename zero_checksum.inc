
; This is part of a workaround to RGBFIX 0.3.7, which does not compute the global checksum correctly
; if it's not 0 in the pre-fix ROM. See https://github.com/rednex/rgbds/issues/280

SECTION "RGBFIX 0.3.7 workaround", ROM0[$14E]
    dw 0