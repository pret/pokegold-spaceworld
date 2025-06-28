INCLUDE "constants.asm"

SECTION "engine/sprites/sprites.asm@RefreshSprites", ROMX

RefreshSprites:
	call GetPlayerSprite
	call CheckInteriorMap
	jr c, .outdoor
	call AddIndoorSprites
	call LoadUsedSpritesGFX
	ret
.outdoor
	call AddOutdoorSprites
	call LoadUsedSpritesGFX
	ret

CheckInteriorMap:
	call GetMapEnvironment
	cp TOWN
	jr z, .got_outdoor
	cp ROUTE
	jr z, .got_outdoor
	xor a
	ret
.got_outdoor
	scf
	ret

AddIndoorSprites:
	ld hl, wUsedNPCSprites
	ld bc, SPRITE_SET_LENGTH
	xor a
	call ByteFill
	ld a, [wPlayerObjectSprite]
	ld [wUsedSprites], a
	ld hl, wMap2ObjectSprite
	ld a, 2
.loop
	push af
	ld a, [hl]
	and a
	jr z, .next
	ld c, a
	call IsAnimatedSprite
	jr nc, .animated_sprite
	ld de, wUsedStaticSprites
	ld b, 2
	call AddSpriteGFX
	jr .next

.animated_sprite
	ld de, wUsedNPCSprites
	ld b, 8
	call AddSpriteGFX
.next
	ld de, MAPOBJECT_LENGTH
	add hl, de
	pop af
	inc a
	cp NUM_OBJECTS
	jp nz, .loop
	ret

AddSpriteGFX:
.loop
	ld a, [de]
	and a
	jr z, .slot_found
	cp c
	ret z
	dec b
	jr z, .done
	inc de
	jr .loop

.slot_found
	ld a, c
	ld [de], a
	ret

.done
	scf
	ret


AddOutdoorSprites:
	ld a, [wPlayerObjectSprite]
	ld [wUsedSprites], a
	ld a, [wMapGroup]
	dec a
	ld c, a
	ld b, 0
	ld hl, MapGroupSpriteSets
	add hl, bc
	ld a, [hl]
	push af
	dec a
	ld hl, SpriteSets
	ld bc, SPRITE_SET_LENGTH
	call AddNTimes
	ld de, wUsedNPCSprites
	ld bc, SPRITE_SET_LENGTH
	call CopyBytes
	ld a, [wUnusedAddOutdoorSpritesReturnValue]
	ld c, a
	pop af
	ld [wUnusedAddOutdoorSpritesReturnValue], a
	ret

LoadStandingSpritesGFX:
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	res SPRITES_SKIP_STANDING_GFX_F, [hl]
	set SPRITES_SKIP_WALKING_GFX_F, [hl]
	call LoadUsedSpritesGFX
	pop af
	ld [wSpriteFlags], a
	ret

LoadWalkingSpritesGFX:
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	set SPRITES_SKIP_STANDING_GFX_F, [hl]
	res SPRITES_SKIP_WALKING_GFX_F, [hl]
	call LoadUsedSpritesGFX
	pop af
	ld [wSpriteFlags], a
	ret

LoadUsedSpritesGFX:
	ld hl, vNPCSprites
	ld de, wUsedSprites
	ld b, SPRITE_SET_LENGTH
	ld c, 0
.loop
	push bc
	push de
	push hl
	ld a, [de]
	and a
	jr z, .skip
	call LoadOverworldSprite
.skip
	pop hl
	ld bc, $c tiles
	add hl, bc
	pop de
	inc de
	pop bc
	inc c
	dec b
	jr nz, .loop
	ld a, [de]
	and a
	jr z, .no_still_sprite_1

	push de
	ld hl, vNPCSprites tile $78
	call LoadOverworldSprite
	pop de
.no_still_sprite_1
	inc de
	ld a, [de]
	and a
	jr z, .no_still_sprite_2
	ld hl, vNPCSprites tile $7c
	call LoadOverworldSprite
.no_still_sprite_2
	ret

Function14133:
	swap b
	ld a, b
	and $f0
	ld e, a
	ld a, b
	and $f
	ld d, a
	ld hl, vNPCSprites
	add hl, de
	ld a, c
	jr LoadOverworldSprite

LoadOverworldSprite_PlayerSlot:
	ld a, c
	ld hl, vNPCSprites
	jr LoadOverworldSprite

; Unreferenced
LoadOverworldSprite_FollowerSlot:
	ld a, c
	ld hl, vNPCSprites tile $0c
	jr LoadOverworldSprite

LoadOverworldSprite:
	push af
	call GetOverworldSpriteData
	push bc
	push hl
	push de
	ld a, [wSpriteFlags]
	bit SPRITES_SKIP_STANDING_GFX_F, a
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
	ld a, [wSpriteFlags]
	bit SPRITES_SKIP_WALKING_GFX_F, a
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
