INCLUDE "constants.asm"

SECTION "home/mon_stats.asm", ROM0

DrawBattleHPBar::
	push hl
	push de
	push bc
	ld a, $60
	ld [hli], a
	ld a, $61
	ld [hli], a
	push hl
	ld a, $62
.asm_3957:
	ld [hli], a
	dec d
	jr nz, .asm_3957
	ld a, $6b
	add b
	ld [hl], a
	pop hl
	ld a, e
	and a
	jr nz, .asm_396a
	ld a, c
	and a
	jr z, .asm_397d
	ld e, $1
.asm_396a:
	ld a, e
	sub $8
	jr c, .asm_3979
	ld e, a
	ld a, $6a
	ld [hli], a
	ld a, e
	and a
	jr z, .asm_397d
	jr .asm_396a

.asm_3979:
	ld a, $62
	add e
	ld [hl], a
.asm_397d:
	pop bc
	pop de
	pop hl
	ret

PrepMonFrontpic::
	ld a, $1
	ld [wSpriteFlipped], a
_PrepMonFrontpic::
	ld a, [wCurPartySpecies]
	and a
	jr z, .asm_39a8
	cp NUM_POKEMON + 1
	jr nc, .asm_39a8
	push hl
	ld de, vFrontPic
	call LoadMonFrontSprite
	pop hl
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	xor a
	ld [wSpriteFlipped], a
	ret

.asm_39a8:
	xor a
	ld [wSpriteFlipped], a
	inc a
	ld [wCurPartySpecies], a
	ret
