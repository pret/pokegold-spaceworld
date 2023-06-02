INCLUDE "constants.asm"

SECTION "home/clear_sprites.asm", ROM0

ClearSprites::
	ld hl, wShadowOAM
	ld b, wShadowOAMEnd - wShadowOAM
	xor a
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

HideSprites::
	ld hl, wShadowOAM
	ld de, SPRITEOAMSTRUCT_LENGTH
	ld b, NUM_SPRITE_OAM_STRUCTS
	ld a, SPRITEOAMSTRUCT_LENGTH * NUM_SPRITE_OAM_STRUCTS
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret
