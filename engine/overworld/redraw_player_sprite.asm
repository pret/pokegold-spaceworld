_RedrawPlayerSprite::
	call GetPlayerSprite
	ld hl, vChars0
	call LoadOverworldSprite
	ret

GetPlayerSprite:
	ld a, [wPlayerState]
	ld hl, PlayerSpriteTable
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr z, .match
	inc hl
	cp -1
	jr nz, .loop
	xor a
	ld [wPlayerState], a
	ld a, SPRITE_GOLD
	jr .skip
.match
	ld a, [hl]
.skip
	ld [wUsedSprites], a
	ld [wPlayerSprite], a
	ld [wPlayerObjectSprite], a
	ret

PlayerSpriteTable:
; state, sprite
	db PLAYER_NORMAL, SPRITE_GOLD
	db PLAYER_BIKE,   SPRITE_GOLD_BIKE
	db PLAYER_SKATE,  SPRITE_GOLD_SKATEBOARD
	db PLAYER_SURF,   SPRITE_LAPRAS
	db -1
