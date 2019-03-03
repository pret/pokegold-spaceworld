INCLUDE "constants.asm"

; if DEBUG
SECTION "home/clear_sprites.asm", ROM0
; else
; SECTION "Sprite clearing", ROM0[$32A0]
; endc

ClearSprites:: ; 32dc
	ld hl, wVirtualOAM
	ld b, wVirtualOAMEnd - wVirtualOAM
	xor a
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

HideSprites:: ; 32e7
	ld hl, wVirtualOAM
	ld de, SPRITEOAMSTRUCT_LENGTH
	ld b, NUM_SPRITE_OAM_STRUCTS
	ld a, SPRITEOAMSTRUCT_LENGTH * NUM_SPRITE_OAM_STRUCTS
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret