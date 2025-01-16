INCLUDE "constants.asm"

SECTION "engine/sprites/sprites.asm@RefreshSprites", ROMX

RefreshSprites:
	call GetPlayerSprite
	call CheckInteriorMap
	jr c, .outdoor
	call AddIndoorSprites
	call LoadUsedSpritesGfx
	ret
.outdoor
	call AddOutdoorSprites
	call LoadUsedSpritesGfx
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
.asm_14070
	push af
	ld a, [hl]
	and a
	jr z, .asm_1408d
	ld c, a
	call IsAnimatedSprite
	jr nc, .static_sprite
	ld de, wUsedStaticSprites
	ld b, 2
	call Function14099
	jr .asm_1408d
.static_sprite
	ld de, wUsedNPCSprites
	ld b, 8
	call Function14099
.asm_1408d
	ld de, $10
	add hl, de
	pop af
	inc a
	cp $10
	jp nz, .asm_14070
	ret

Function14099:
.loop
	ld a, [de]
	and a
	jr z, .asm_140a5
	cp c
	ret z
	dec b
	jr z, .asm_140a8
	inc de
	jr .loop

.asm_140a5
	ld a, c
	ld [de], a
	ret

.asm_140a8
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
	ld a, [wd642]
	ld c, a
	pop af
	ld [wd642], a
	ret

Function140d9:
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	res 7, [hl]
	set 6, [hl]
	call LoadUsedSpritesGfx
	pop af
	ld [wSpriteFlags], a
	ret

Function140ea:
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	set 7, [hl]
	res 6, [hl]
	call LoadUsedSpritesGfx
	pop af
	ld [wSpriteFlags], a
	ret

LoadUsedSpritesGfx:
	ld hl, vNPCSprites
	ld de, wUsedSprites
	ld b, SPRITE_SET_LENGTH
	ld c, 0
.asm_14105
	push bc
	push de
	push hl
	ld a, [de]
	and a
	jr z, .asm_1410f
	call LoadOverworldSprite
.asm_1410f
	pop hl
	ld bc, $c0
	add hl, bc
	pop de
	inc de
	pop bc
	inc c
	dec b
	jr nz, .asm_14105
	ld a, [de]
	and a
	jr z, .asm_14127
	push de
	ld hl, vNPCSprites + $780
	call LoadOverworldSprite
	pop de
.asm_14127
	inc de
	ld a, [de]
	and a
	jr z, .asm_14132
	ld hl, vNPCSprites + $7c0
	call LoadOverworldSprite
.asm_14132
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

Function14144:
	ld a, c
	ld hl, vNPCSprites
	jr LoadOverworldSprite

Function1414a:
	ld a, c
	ld hl, vNPCSprites + $c0
	jr LoadOverworldSprite

LoadOverworldSprite:
	push af
	call GetOverworldSpriteData
	push bc
	push hl
	push de
	ld a, [wSpriteFlags]
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
	ld a, [wSpriteFlags]
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
