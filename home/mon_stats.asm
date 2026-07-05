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
.fill_bar
	ld [hli], a
	dec d
	jr nz, .fill_bar
	ld a, $6b ; bar end
	add b
	ld [hl], a
	pop hl
	ld a, e
	and a
	jr nz, .dec_hp
	ld a, c
	and a
	jr z, .done_bar
	ld e, $1
.dec_hp
	ld a, e
	sub $8
	jr c, .write_dmg
	ld e, a
	ld a, $6a ; full bar
	ld [hli], a
	ld a, e
	and a
	jr z, .done_bar
	jr .dec_hp

.write_dmg
	ld a, $62 ; empty bar
	add e
	ld [hl], a
.done_bar
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
	jr z, .no_pokemon
	cp NUM_POKEMON + 1
	jr nc, .no_pokemon
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

.no_pokemon
	xor a
	ld [wSpriteFlipped], a
	inc a
	ld [wCurPartySpecies], a
	ret
