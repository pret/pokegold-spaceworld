INCLUDE "constants.asm"

SECTION "VBlank handler", ROM0[$150]

VBlank:: ; 0150
    push af
    push bc
    push de
    push hl
    ldh a, [hVBlank]
    and 3
    ld e, a
    ld d, 0
    ld hl, .blanks
    add hl, de
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, .return
    push de
    jp hl
.return
    pop hl
    pop de
    pop bc
    pop af
    reti

.blanks
    ; TODO
