INCLUDE "constants.asm"

if DEBUG
SECTION "Misc Utility Functions", ROM0[$341F]
else
SECTION "Misc Utility Functions", ROM0[$33E3]
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

AddNTimes:: ; 3429 (0:3429)
	and a
	ret z
.asm_342b
	add hl, bc
	dec a
	jr nz, .asm_342b
	ret
; 0x3430

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
