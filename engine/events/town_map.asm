INCLUDE "constants.asm"

SECTION "engine/events/town_map.asm", ROMX

TownMap::
	call InitTownMap
	callfar ClearSpriteAnims
	call TownMap_InitPlayerIcon
	call WaitBGMap
	call SetPalettes
.loop
	call DelayFrame
	call GetJoypadDebounced
	callfar PlaySpriteAnimations
	ld hl, hJoyDown
	ld a, [hl]
	and A_BUTTON | B_BUTTON
	jr z, .loop
	ret

FlyMap::
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], 1
	call InitTownMap
	callfar ClearSpriteAnims
	call TownMap_InitPlayerIcon
	call FlyMap_InitPidgeyIcon
	ld hl, wFlyIconAnimStructPointer
	ld [hl], c
	inc hl
	ld [hl], b
	hlcoord 1, 15
	ld de, ChooseADestinationText
	call PlaceString
	call WaitBGMap
	call SetPalettes
	xor a
	ld [wFlyDestination], a
.loop
	call DelayFrame
	call GetJoypadDebounced
	callfar PlaySpriteAnimations
	ld hl, hJoyDown
	ld a, [hl]
	and B_BUTTON
	jr nz, .cancel
	ld a, [hl]
	and A_BUTTON
	jr nz, .fly
	call .HandleDPad
	callfar GetFlyPointMapLocation
	ld d, 0
	ld hl, LandmarkPositions
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld hl, wFlyIconAnimStructPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	jr .loop

.cancel
	ld a, -1
	ld [wFlyDestination], a
.fly
	pop af
	ldh [hInMenu], a
	ret

.HandleDPad:
	ld a, [wFlyDestination]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, FlyPointPaths
	add hl, de
	ld de, hJoySum
	ld a, [de]
	and D_UP
	jr nz, .get_point
	inc hl
	ld a, [de]
	and D_DOWN
	jr nz, .get_point
	inc hl
	ld a, [de]
	and D_LEFT
	jr nz, .get_point
	inc hl
	ld a, [de]
	and D_RIGHT
	jr nz, .get_point
	ret
.get_point
	ld a, [hl]
	cp -1
	ret z
	ld [wFlyDestination], a
	ret

ChooseADestinationText:
	db "とびさき　を　えらんでください@"

Pokedex_GetArea:
	ld a, [wNestIconBlinkCounter]
	push af
	xor a
	ld [wNestIconBlinkCounter], a

	call InitTownMap
	ld de, PokedexNestIconGFX
	ld hl, vChars0 tile $7f
	lb bc, BANK(PokedexNestIconGFX), 1
	call Request1bpp

	call GetPokemonName
	hlcoord 4, 15
	call PlaceString

	hlcoord 9, 15
	ld de, .String_SNest
	call PlaceString

	call WaitBGMap
	call SetPalettes
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	callfar FindNest
.loop
	call .PlaceNest
	call GetJoypadDebounced
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .done

	ld hl, wNestIconBlinkCounter
	inc [hl]
	call DelayFrame
	jr .loop
.done
	pop af
	ld [wNestIconBlinkCounter], a
	ret

.String_SNest:
	db "の　すみか@"

.PlaceNest:
	ld a, [wNestIconBlinkCounter]
	and $10
	jr z, .done_nest

	ld de, wTileMap
	ld hl, wShadowOAMSprite00
.nestloop
	ld a, [de]
	and a
	ret z
	
	push de
	push hl
	ld e, a
	ld d, $00
	ld hl, LandmarkPositions
	add hl, de
	add hl, de
	ld e, l
	ld d, h

	; load into OAM
	pop hl
; X position
	ld a, [de]
	inc de
	sub 4
	ld [hli], a
; Y position
	ld a, [de]
	inc de
	sub 4
	ld [hli], a
; Nest icon -> Tile ID
	ld a, $7f
	ld [hli], a
; Blank out attributes
	xor a
	ld [hli], a
	
	pop de
	inc de
	jr .nestloop
.done_nest
	call ClearSprites
	ret

InitTownMap:
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	call DisableLCD

	ld hl, TownMapGFX
	ld de, vTilesetEnd
	ld bc, TownMapGFX.End - TownMapGFX
	ld a, BANK(TownMapGFX)
	call FarCopyData

	ld hl, wTileMap
	call DecompTownMapTilemap
	hlcoord 0, 13
	ld b, 3
	ld c, 18
	call DrawTextBox

	ld a, 3
	call UpdateSoundNTimes
	call EnableLCD
	ld b, SGB_TOWN_MAP
	call GetSGBLayout
	ret

DecompTownMapTilemap:
	ld de, TownMapTilemap
.loop
	ld a, [de]
	and a
	ret z

	ld b, a
	inc de
	ld a, [de]
	ld c, a
	ld a, b
	add $60
.keep_placing_tile
	ld [hli], a
	dec c
	jr nz, .keep_placing_tile
	inc de
	jr .loop

TownMap_InitPlayerIcon:
	ld de, GoldSpriteGFX
	ld hl, vChars0
	lb bc, BANK(GoldSpriteGFX), $04
	call Request2bpp

	ld de, GoldSpriteGFX + 12 tiles
	ld hl, vChars0 tile $04
	lb bc, BANK(GoldSpriteGFX), $04
	call Request2bpp

	depixel 0, 0
	ld a, SPRITE_ANIM_OBJ_MAP_CHARACTER_ICON
	call InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $00

	push bc
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
	call GetWorldMapLocation

	ld e, a
	ld d, $00
	ld hl, LandmarkPositions
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	pop bc
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

FlyMap_InitPidgeyIcon:
	ld de, PidgeySpriteGFX
	ld hl, vChars0 tile $08
	lb bc, BANK(PidgeySpriteGFX), 4
	call Request2bpp
	
	ld de, PidgeySpriteGFX + 12 tiles
	ld hl, vChars0 tile $0c
	lb bc, BANK(PidgeySpriteGFX), 4
	call Request2bpp

	depixel 0, 0
	ld a, SPRITE_ANIM_OBJ_MAP_CHARACTER_ICON
	call InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], 8
	ret

TownMapTilemap:
INCBIN "gfx/trainer_gear/town_map.tilemap.rle"
