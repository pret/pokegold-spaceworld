INCLUDE "constants.asm"

SECTION "engine/items/item_effects.asm", ROMX

ApplyPPUp:
	ld a, MON_MOVES
	call GetPartyParamLocation
	push hl
	ld de, wStringBuffer1
	predef FillPP
	pop hl
	ld c, MON_PP - MON_MOVES
	ld b, 0
	add hl, bc
	ld de, wStringBuffer1 + 1
	ld b, 0
.loop
	inc b
	ld a, b
	cp NUM_MOVES + 1
	ret z
	ld a, [wce37]
	dec a
	jr nz, .use
	ld a, [wMenuCursorY]
	inc a
	cp b
	jr nz, .skip
.use
	ld a, [hl]
	and PP_UP_MASK
	call nz, ComputeMaxPP
.skip
	inc hl
	inc de
	jr .loop

ComputeMaxPP:
	push bc
	; Divide the base PP by 5.
	ld a, [de]
	ldh [hDividend + 3], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide
	; Get the number of PP, which are bits 6 and 7 of the PP value stored in RAM.
	ld a, [hl]
	ld b, a
	swap a
	and $f
	srl a
	srl a
	ld c, a
.loop
	; Normally, a move with 40 PP would have 64 PP with three PP Ups.
	; Since this would overflow into bit 6, we prevent that from happening
	; by decreasing the extra amount of PP each PP Up provides, resulting
	; in a maximum of 61.
	ldh a, [hQuotient + 3]
	cp $8
	jr c, .okay
	ld a, $7
.okay
	add b
	ld b, a
	ld a, [wce37]
	dec a
	jr z, .no_pp_up
	dec c
	jr nz, .loop
.no_pp_up
	ld [hl], b
	pop bc
	ret
