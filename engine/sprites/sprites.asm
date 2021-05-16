INCLUDE "constants.asm"

SECTION "engine/sprites/sprites.asm@LoadOverworldSprite", ROMX

LoadOverworldSprite:
	push af
	call GetOverworldSpriteData
	push bc
	push hl
	push de
	ld a, [wcdaf]
	bit 7, a
	jr nz, .dont_copy
	call Get2bpp
.dont_copy
	pop de
	ld hl, SPRITE_TILE_SIZE * 3
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld bc, vChars1 - vChars0
	add hl, bc
	pop bc
	pop af
	call IsAnimatedSprite
	ret c
	ld a, [wcdaf]
	bit 6, a
	ret nz
	call Get2bpp
	ret

; get the data for overworld sprite in a
; returns: gfx ptr in hl, length in c, bank in b
GetOverworldSpriteData:
	push hl
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld bc, OverworldSprites
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld c, [hl]
	swap c
	inc hl
	ld b, [hl]
	pop hl
	ret
