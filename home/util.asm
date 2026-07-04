INCLUDE "constants.asm"

SECTION "home/util.asm", ROM0

Copy2x2TilesToVRAM:: ; unreferenced
; Copies a 2D rectangle from hl (src) to de (dst) with size in (b = y, c = x).
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
.row_offset
	add hl, bc
	dec a
	jr nz, .row_offset
	pop bc
	dec b
	ld a, b
	push hl
	add hl, bc
	ld d, h
	ld e, l
	pop hl
.col_loop
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
	jr nz, .col_loop
	pop hl
	pop de
	jp CopyBytes

SkipNames::
; Returns hl + a * 6
	and a
	ret z
	ld bc, 6
.loop:
	add hl, bc
	dec a
	jr nz, .loop
	ret

AddNTimes::
; Adds bc to hl, a times
	and a
	ret z
.loop
	add hl, bc
	dec a
	jr nz, .loop
	ret

CompareBytes::
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

; INPUT:
; a = oam block index (each block is 4 oam entries)
; b = Y coordinate of upper left corner of sprite
; c = X coordinate of upper left corner of sprite
; de = base address of 4 tile number and attribute pairs
WriteOAMBlock::
; Place 2x2 sprite from *de into OAM at slot a with size in (b = y, c = x).
	ld h, HIGH(wShadowOAM)
	swap a ; multiply by 16
	ld l, a
	call .Load ; upper left
	push bc
	ld a, $8
	add c
	ld c, a
	call .Load ; upper right
	pop bc
	ld a, $8
	add b
	ld b, a
	call .Load ; lower left
	ld a, $8
	add c
	ld c, a
	                      ; lower right
.Load:
	ld [hl], b ; Y coordinate
	inc hl
	ld [hl], c ; X coordinate
	inc hl
	ld a, [de] ; tile number
	inc de
	ld [hli], a
	ld a, [de] ; attribute
	inc de
	ld [hli], a
	ret
