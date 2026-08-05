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
	ld de, OBJ_SIZE
	ld b, OAM_COUNT
	ld a, OBJ_SIZE * OAM_COUNT
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret
