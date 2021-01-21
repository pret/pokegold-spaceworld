INCLUDE "constants.asm"

SECTION "engine/trainer_gear.asm", ROMX

TRAINERGEAR_GFX_MAP_ICON   EQU $10
TRAINERGEAR_GFX_RADIO_ICON EQU $14
TRAINERGEAR_GFX_PHONE_ICON EQU $18

TRAINERGEAR_END_LOOP_F EQU 7

OpenTrainerGear:
	ld hl, wce5f
	ld a, [hl]
	push af
	set 4, [hl]
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ldh a, [hJoypadSum]
	push af

	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	call TrainerGear_Init
	call DelayFrame
.loop
	call TrainerGear_Loop
	jr nc, .loop
	pop af
	ld [wVramState], a

	pop af
	ldh [hJoypadSum], a
	pop af
	ldh [hMapAnims], a
	pop af
	ld [wce5f], a
	call ClearJoypad
	ret

TrainerGear_Init:
	call ClearBGPalettes
	call DisableLCD
	call ClearSprites
	ld b, SGB_TRAINER_GEAR
	call GetSGBLayout
	ld hl, TrainerGearGFX
	ld de, vChars2
	ld bc, $20 tiles
	ld a, BANK(TrainerGearGFX)
	call FarCopyData
	call TrainerGear_InitTilemap
	call TrainerGear_PlaceIcons
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	ld [wJumptableIndex], a
	ld [wFlyDestination], a
	ld a, $ff
	ld [wcb60], a
	ld a, 7
	ldh [hWX], a
	ld a, 8
	call UpdateSoundNTimes
	ld a, $e3
	ldh [rLCDC], a
	call WaitBGMap
	call SetPalettes
	ld a, $e0
	ldh [rOBP1], a
	ret

TrainerGear_InitTilemap:
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, "　"
	call ByteFill
	ld de, wTileMap
	ld hl, .Tilemap
	ld bc, $3c
	call CopyBytes
	ret

.Tilemap:
	db $0d, $1c, $1d, $0b, $1c, $1d, $0b, $1c
	db $1d, $0c, $01, $05, $05, $05, $05, $05
	db $05, $05, $05, $02, $08, $1e, $1f, $0a
	db $1e, $1f, $0a, $1e, $1f, $07, $08, $7f
	db $7f, $0f, $7f, $7f, $0f, $7f, $7f, $07
	db $03, $06, $06, $09, $06, $06, $09, $06
	db $06, $04, $03, $06, $06, $06, $06, $06
	db $06, $06, $06, $04

TrainerGear_PlaceIcons:
	coord hl, 1, 0
	ld a, TRAINERGEAR_GFX_MAP_ICON
	call .PlaceIcon

	coord hl, 4, 0
	ld a, TRAINERGEAR_GFX_RADIO_ICON
	call .PlaceIcon

	coord hl, 7, 0
	ld a, TRAINERGEAR_GFX_PHONE_ICON
	call .PlaceIcon
	ret

.PlaceIcon:
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc a
	ld [hli], a
	inc a
	ld [hld], a
	ret

TrainerGear_Loop:
	call UpdateTime
	call GetJoypadDebounced
	ld a, [wJumptableIndex]
	bit TRAINERGEAR_END_LOOP_F, a
	jr nz, .done
	call TrainerGear_PerformFunction
	ld a, BANK(EffectObjectJumpNoDelay)
	ld hl, EffectObjectJumpNoDelay
	call FarCall_hl
	call TrainerGear_UpdateTime
	call DelayFrame
	and a
	ret
.done
	ld hl, InitEffectObject
	ld a, BANK(InitEffectObject)
	call FarCall_hl
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

TrainerGear_UpdateTime:
	coord hl, 11, 1
	ld a, "　"
	ld [hli], a
	ld [hl], a

	ld de, hRTCHours
	coord hl, 11, 1
	lb bc, 1, 2
	call PrintNumber
	inc hl

	ld de, hRTCMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	inc hl

	ld de, hRTCSeconds
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	ret

TrainerGear_PerformFunction:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw TrainerGear_InitPointerSprite
	dw TrainerGear_ReadInput
	dw TrainerGear_Map
	dw TrainerGear_MapLoop
	dw TrainerGear_Radio
	dw Function8d62
	dw TrainerGear_Phone
	dw Function8e9e

TrainerGear_Next:
	ld hl, wJumptableIndex
	inc [hl]
	ret

TrainerGear_InitPointerSprite:
	callab InitEffectObject
	ld de, PointerGFX
	ld hl, vChars0 tile $7c
	lb bc, BANK(PointerGFX), 4
	call Request2bpp
	ld a, $29
	ld hl, wTileMapBackup
	ld [hli], a
	ld [hl], $7c
	depixel 4, 3, 4, 4
	ld a, SPRITE_ANIM_INDEX_44
	call InitSpriteAnimStruct
	call TrainerGear_Next
	ret

TrainerGear_ReadInput:
	ld hl, hJoySum
	ld a, [hl]
	and B_BUTTON
	jr nz, .exit
	ld a, [hl]
	and A_BUTTON
	ret z
	call TrainerGear_DetermineView
	ret
.exit
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

TrainerGear_DetermineView:
	ld a, [wFlyDestination]
	ld hl, wcb60
	cp [hl]
	ret z
	ld [wcb60], a
	and $03
	ld e, a
	ld d, $00
	ld hl, .Views
	add hl, de
	ld a, [hl]
	ld [wJumptableIndex], a
	ret

.Views:
; these are jumptable indices
	db $02, $04, $06, $02

TrainerGear_Map:
	call TrainerGear_Next
	call TrainerGear_ClearView
	call WaitForAutoBgMapTransfer
	ld b, SGB_PACKPALS
	call GetSGBLayout
	ld de, TownMapGFX
	ld hl, vTilesetEnd
	lb bc, BANK(TownMapGFX), ((TownMapGFX.End - TownMapGFX) / LEN_2BPP_TILE - 1)
	call Request2bpp
	coord hl, 0, 3
	call DecompTownMapTilemap
	call WaitBGMap
	call Function886a
	ld hl, $0005
	add hl, bc
	ld a, [hl]
	add $18
	ld [hl], a
	ret

TrainerGear_MapLoop:
	ld hl, hJoyDown
	ld a, [hl]
	and B_BUTTON
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

TrainerGear_Radio:
	call TrainerGear_Next
	call TrainerGear_ClearView
	call WaitForAutoBgMapTransfer
	ld b, $15
	call GetSGBLayout
	ld de, RadioGFX
	ld hl, vTilesetEnd
	lb bc, BANK(RadioGFX), $09
	call Request2bpp
	ld de, VerticalPipeGFX
	ld hl, vChars0
	lb bc, BANK(VerticalPipeGFX), $01
	call Request2bpp
	coord hl, 0, 3
	ld bc, $00b4
	ld a, $0e
	call ByteFill
	coord hl, 1, 8
	ld bc, $0412
	call Function8ef9
	coord hl, 4, 3
	ld bc, $060e
	call Function8ef9
	ld a, $05
	coord hl, 0, 11
	ld [hl], a
	coord hl, 19, 11
	ld [hl], a
	coord hl, 2, 5
	ld a, $60
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, $0014
	add hl, bc
	ld [hli], a
	inc a
	ld [hld], a
	coord hl, 2, 4
	ld a, $64
	ld [hli], a
	inc a
	ld [hl], a
	coord hl, 5, 5
	ld bc, $000c
	ld a, $66
	call ByteFill
	coord hl, 5, 6
	ld bc, $000c
	ld a, $67
	call ByteFill
	ld hl, Text91c2
	call PrintText
	call WaitBGMap
	depixel 9, 4, 4, 3
	ld a, SPRITE_ANIM_INDEX_44
	call InitSpriteAnimStruct
	ld hl, $0002
	add hl, bc
	ld [hl], $00
	ld hl, $0003
	add hl, bc
	ld [hl], $7c
	depixel 8, 6
	ld a, SPRITE_ANIM_INDEX_4B
	call InitSpriteAnimStruct
	ld hl, $0003
	add hl, bc
	ld [hl], $00
	xor a
	ld [wcb61], a
	ret

Function8d62:
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

Function8d6e:
	ld hl, wcb61
	ld e, [hl]
	ld d, $00
	ld hl, Table8d7d
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Table8d7d:
	dw Function8d85
	dw Function8d91
	dw Function8d85
	dw Function8db9

Function8d85:
	ld hl, hJoyDown
	ld a, [hl]
	and $01
	ret z
	ld hl, wcb61
	inc [hl]
	ret

Function8d91:
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .sub_8da6
	call TrainerGear_GetRadioEvents
	jr c, .sub_8db1
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_8dab
.sub_8da6
	ld hl, hFFC0
	jr Function8de3
.sub_8dab
	ld a, $03
	ld [wcb61], a
	ret
.sub_8db1
	call .sub_8da6
	xor a
	ld [wcb61], a
	ret

Function8db9:
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .sub_8dcf
	call TrainerGear_GetRadioEvents
	jr c, .sub_8dda
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	cp $60
	jr z, .sub_8dd4
.sub_8dcf
	ld hl, $0040
	jr Function8de3
.sub_8dd4
	ld a, $01
	ld [wcb61], a
	ret
.sub_8dda
	call .sub_8dcf
	ld a, $02
	ld [wcb61], a
	ret

Function8de3:
	push hl
	ld hl, $0006
	add hl, bc
	ld d, [hl]
	ld hl, $000c
	add hl, bc
	ld e, [hl]
	pop hl
	add hl, de
	ld e, l
	ld d, h
	ld hl, $000c
	add hl, bc
	ld [hl], e
	ld hl, $0006
	add hl, bc
	ld [hl], d
	ret

TrainerGear_GetRadioEvents:
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	push bc
	ld c, [hl]
	ld a, [wMapGroup]
	ld e, a
	ld d, 0
	ld hl, TrainerGear_RadioAreas
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
.find_matches
; Finds an event corresponding to the radio cursor's X offset
	ld a, [hl]
	and a
	jr z, .no_match
	cp c
	jr z, .found
	ld de, 6
	add hl, de
	jr .find_matches

.no_match
; No associated event found, quit the routine
	pop bc
	and a
	ret

.found
; Execute associated event with a parameter stored in e
	ld de, .AfterEvent
	push de
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.AfterEvent:
	pop bc
	scf
	ret

TrainerGear_RadioAreas:
; one set of radio stations per map group
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music
	dw TrainerGear_RadioStations_Music

TrainerGear_RadioStations_Music:
; list of radio stations associated with the map group
	db $10           ; cursor's X position
	db MUSIC_ROUTE_1 ; parameter at e
	dw .PlayMusic    ; routine to jump to
	dw .PlayMusic    ; unused

	db $20, MUSIC_TRAINER_BATTLE
	dw .PlayMusic
	dw .PlayMusic

	db $40, MUSIC_VIRIDIAN_CITY
	dw .PlayMusic
	dw .PlayMusic

	db $48, MUSIC_BICYCLE
	dw .PlayMusic
	dw .PlayMusic

	db 0 ; list terminator

.PlayMusic:
	ld d, 0
	call PlayMusic
	ret

TrainerGear_Phone:
	call TrainerGear_Next
	call TrainerGear_ClearView
	call WaitForAutoBgMapTransfer
	ld b, $13
	call GetSGBLayout
	call LoadFontExtra
	ld de, Text8e90
	coord hl, 7, 7
	call PlaceString
	ld hl, Text8e95
	call PrintText
	call WaitBGMap
	ret

Text8e90:
	db "けんがい@"

Text8e95:
	text "ちぇっ⋯⋯⋯⋯"
	done

Function8e9e:
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

TrainerGear_ClearView:
	ld hl, InitEffectObject
	ld a, BANK(InitEffectObject)
	call FarCall_hl
	call ClearSprites
	call WaitForAutoBgMapTransfer
	coord hl, 0, 3
	ld bc, SCREEN_WIDTH * 15
	ld a, "　"
	call ByteFill
	call WaitBGMap
	call WaitBGMap
	ret

Function8eca:
	ld hl, wFlyDestination
	ld de, hJoySum
	ld a, [de]
	and $20
	jr nz, .sub_8edc
	ld a, [de]
	and $10
	jr nz, .sub_8ee2
	jr .sub_8ee7
.sub_8edc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	jr .sub_8ee7
.sub_8ee2
	ld a, [hl]
	cp $02
	ret nc
	inc [hl]
.sub_8ee7
	ld e, [hl]
	ld d, $00
	ld hl, Data8ef5
	add hl, de
	ld a, [hl]
	ld hl, $0006
	add hl, bc
	ld [hl], a
	ret

Data8ef5:
	db $00, $18, $30, $00

Function8ef9:
	dec c
	dec c
	dec b
	dec b
	ld de, $0014
	push bc
	push hl
	ld a, $01
	ld [hli], a
	ld a, $05
.sub_8f07
	ld [hli], a
	dec c
	jr nz, .sub_8f07
	ld a, $02
	ld [hl], a
	pop hl
	pop bc
	add hl, de
.sub_8f11
	push bc
	push hl
	ld a, $08
	ld [hli], a
	ld a, $7f
.sub_8f18
	ld [hli], a
	dec c
	jr nz, .sub_8f18
	ld a, $07
	ld [hli], a
	pop hl
	add hl, de
	pop bc
	dec b
	jr nz, .sub_8f11
	ld a, $03
	ld [hli], a
	ld a, $06
.sub_8f2a
	ld [hli], a
	dec c
	jr nz, .sub_8f2a
	ld a, $04
	ld [hli], a
	ret
