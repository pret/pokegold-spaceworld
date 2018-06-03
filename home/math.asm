include "constants.asm"

if DEBUG
SECTION "Home Math", ROM0[$341F]
else
SECTION "Home Math", ROM0[$33E3]
endc

_341F:: ; 341f
; Returns hl + a * 6
    and a
    ret z
    ld bc, 6
.loop:
    add hl, bc
    dec a
    jr nz, .loop
    ret

AddAMulBC:: ; 3429
; Returns hl + a * bc
    and a
    ret z
.loop:
    add hl, bc
    dec a
    jr nz, .loop
    ret

memcmp:: ; 3430
; Compare c bytes at hl and de
; Returns z if all equal, nz otherwise.
.loop:
    ld a, [de]
    cp [hl]
    ret nz
    inc de
    inc hl
    dec c
    jr nz, .loop
    ret
