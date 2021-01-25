INCLUDE "constants.asm"

SECTION "engine/dumps/bank23.asm@AnimateTilesetImpl", ROMX

AnimateTilesetImpl:
	ldh a, [hMapAnims]
	and a
	ret z

	ld a, [wTilesetAnim]
	ld e, a
	ld a, [wTilesetAnim+1]
	ld d, a
	ldh a, [hTileAnimFrame]
	ld l, a
	inc a
	ldh [hTileAnimFrame], a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
