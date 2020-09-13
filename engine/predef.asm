INCLUDE "constants.asm"

SECTION "engine/predef.asm", ROMX

GetPredefPointer:: ; 1:62b0
	ld a, h
	ld [wPredefHL], a
	ld a, l
	ld [wPredefHL + 1], a
	ld hl, wPredefDE
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, b
	ld [hli], a
	ld [hl], c

	ld a, [wPredefID]
	ld e, a
	ld d, 0
	ld hl, PredefPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, [hl]
	inc hl
	ld d, [hl]
	ret

INCLUDE "data/predef_pointers.inc"
