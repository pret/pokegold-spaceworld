INCLUDE "constants.asm"

if DEBUG
SECTION "Misc Utility Functions", ROM0[$33EF]
else
SECTION "Misc Utility Functions", ROM0[$33B3]
endc

Function33ef::
	; hl = src
	; de  = dest
	; b = y
	; c = x
	push hl
	push de
	push bc
	ld a, b
	dec a
	dec a
	ld b, $0
.asm_33f7: ; 00:33f7
	add hl, bc
	dec a
	jr nz, .asm_33f7
	pop bc
	dec b
	ld a, b
	push hl
	add hl, bc
	ld d, h
	ld e, l
	pop hl
.asm_3403: ; 00:3403
	push af
	push bc
	call CopyBytes
	pop bc
	push bc
	ld a, c
	xor $ff
	ld c, a
	ld b, $ff
	inc bc
	add hl, bc
	ld d, h
	ld e, l
	add hl, bc
	pop bc
	pop af
	dec a
	jr nz, .asm_3403
	pop hl
	pop de
	jp CopyBytes

SkipNames:: ; 341f
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
