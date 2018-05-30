INCLUDE "constants.asm"

SECTION "Empty function", ROM0[$2F97]

InexplicablyEmptyFunction:: ; 2f97
REPT 16
    nop
ENDR
    ret


; TODO:
; 1. Figure out what these are. Might be related to RTC, like ClearRTCStatus and the ilk.
; 2. Give them proper names.
; 3. Move them to their own file(s).

SECTION "Unknown functions", ROM0[$1FF4]

_1FF4:: ; 1ff4
    ld a, BANK(s0_a600)
    call OpenSRAM
    ld hl, s0_a600 ; TODO: label this.
    ld bc, 7
    xor a
    call ByteFill
    call CloseSRAM
    ret

_2007:: ; 2007
    ld a, BANK(s0_a600)
    call OpenSRAM
    ld a, [s0_a600]
    and 8
    ld [wce5f], a
    call CloseSRAM
    ret
