INCLUDE "constants.asm"

SECTION "engine/trainer_gear.asm@OpenTrainerGear", ROMX

DEF TRAINERGEAR_GFX_VERTICAL_PIPE      EQU $00
DEF TRAINERGEAR_GFX_POINTER            EQU $7c

DEF TRAINERGEAR_GFX_BORDER_TOPLEFT     EQU $01
DEF TRAINERGEAR_GFX_BORDER_TOPRIGHT    EQU $02
DEF TRAINERGEAR_GFX_BORDER_BOTTOMLEFT  EQU $03
DEF TRAINERGEAR_GFX_BORDER_BOTTOMRIGHT EQU $04
DEF TRAINERGEAR_GFX_BORDER_TOP         EQU $05
DEF TRAINERGEAR_GFX_BORDER_BOTTOM      EQU $06
DEF TRAINERGEAR_GFX_BORDER_RIGHT       EQU $07
DEF TRAINERGEAR_GFX_BORDER_LEFT        EQU $08

DEF TRAINERGEAR_GFX_GRAYTILE           EQU $0e
DEF TRAINERGEAR_GFX_BLANKTILE          EQU $7f

DEF TRAINERGEAR_GFX_MAP_ICON           EQU $10
DEF TRAINERGEAR_GFX_RADIO_ICON         EQU $14
DEF TRAINERGEAR_GFX_PHONE_ICON         EQU $18

DEF TRAINERGEAR_GFX_TUNE_BUTTON        EQU $60
DEF TRAINERGEAR_GFX_TUNE_TEXT          EQU $64
DEF TRAINERGEAR_GFX_RADIO_TOPHALF      EQU $66
DEF TRAINERGEAR_GFX_RADIO_BOTTOMHALF   EQU $67

; Trainer Gear cards
	const_def
	const TRAINERGEARCARD_MAP
	const TRAINERGEARCARD_RADIO
	const TRAINERGEARCARD_PHONE
DEF NUM_TRAINERGEAR_CARDS EQU const_value

; TrainerGear_Jumptable.Jumptable indices
	const_def
	const TRAINERGEARSTATE_INIT
	const TRAINERGEARSTATE_JOYPAD
	const TRAINERGEARSTATE_MAPINIT
	const TRAINERGEARSTATE_MAPJOYPAD
	const TRAINERGEARSTATE_RADIOINIT
	const TRAINERGEARSTATE_RADIOJOYPAD
	const TRAINERGEARSTATE_PHONEINIT
	const TRAINERGEARSTATE_PHONEJOYPAD
DEF TRAINERGEAR_END_LOOP_F EQU 7

; TrainerGear_RadioJumptable.Jumptable indices
	const_def
	const TRAINERGEAR_RADIOSTATE_WAITINPUT_1
	const TRAINERGEAR_RADIOSTATE_ADVANCEDIAL
	const TRAINERGEAR_RADIOSTATE_WAITINPUT_2
	const TRAINERGEAR_RADIOSTATE_TURNBACKDIAL

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
	ld b, SGB_TRAINERGEAR
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
	ld [wTrainerGearPointerPosition], a
	ld a, $ff
	ld [wTrainerGearCard], a
	ld a, 7
	ldh [hWX], a
	ld a, 8
	call UpdateSoundNTimes

	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	call WaitBGMap
	call SetPalettes
	ld a, %11100000
	ldh [rOBP1], a
	ret

TrainerGear_InitTilemap:
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, TRAINERGEAR_GFX_BLANKTILE
	call ByteFill
	ld de, wTileMap
	ld hl, TrainerGearTilemap
	ld bc, TrainerGearTilemap.End - TrainerGearTilemap
	call CopyBytes
	ret

TrainerGearTilemap:
INCBIN "gfx/trainer_gear/trainer_gear.tilemap"
.End:

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
	call TrainerGear_Jumptable
	farcall PlaySpriteAnimations
	call TrainerGear_UpdateTime
	call DelayFrame
	and a
	ret
.done
	callfar ClearSpriteAnims
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

TrainerGear_UpdateTime:
	coord hl, 11, 1
	ld a, TRAINERGEAR_GFX_BLANKTILE
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

TrainerGear_Jumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw TrainerGear_InitPointerSprite
	dw TrainerGear_Joypad
	dw TrainerGear_Map
	dw TrainerGear_MapJoypad
	dw TrainerGear_Radio
	dw TrainerGear_RadioJoypad
	dw TrainerGear_Phone
	dw TrainerGear_PhoneJoypad

TrainerGear_Next:
	ld hl, wJumptableIndex
	inc [hl]
	ret

TrainerGear_InitPointerSprite:
	callfar ClearSpriteAnims
	ld de, PointerGFX
	ld hl, vChars0 tile TRAINERGEAR_GFX_POINTER
	lb bc, BANK(PointerGFX), 4
	call Request2bpp
	ld a, SPRITE_ANIM_DICT_ARROW_CURSOR
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], TRAINERGEAR_GFX_POINTER
	depixel 4, 3, 4, 4
	ld a, SPRITE_ANIM_OBJ_TRAINERGEAR_POINTER
	call InitSpriteAnimStruct
	call TrainerGear_Next
	ret

TrainerGear_Joypad:
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
	set TRAINERGEAR_END_LOOP_F, [hl]
	ret

TrainerGear_DetermineView:
; don't attempt to reload the view if we're already in it
	ld a, [wTrainerGearPointerPosition]
	ld hl, wTrainerGearCard
	cp [hl]
	ret z

; load a new view by jumping to its init routine
	ld [wTrainerGearCard], a
	maskbits NUM_TRAINERGEAR_CARDS
	ld e, a
	ld d, 0
	ld hl, .Views
	add hl, de
	ld a, [hl]
	ld [wJumptableIndex], a
	ret

.Views:
	db TRAINERGEARSTATE_MAPINIT
	db TRAINERGEARSTATE_RADIOINIT
	db TRAINERGEARSTATE_PHONEINIT
	db TRAINERGEARSTATE_MAPINIT  ; unused

TrainerGear_Map:
	call TrainerGear_Next
	call TrainerGear_ClearView
	call WaitForAutoBgMapTransfer
	ld b, SGB_TRAINERGEAR_MAP
	call GetSGBLayout
	ld de, TownMapGFX
	ld hl, vTilesetEnd
	lb bc, BANK(TownMapGFX), ((TownMapGFX.End - TownMapGFX) / LEN_2BPP_TILE - 1)
	call Request2bpp
	coord hl, 0, 3
	call DecompTownMapTilemap
	call WaitBGMap
	call PlaceGoldInMap
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	add 3 * TILE_WIDTH ; shift sprite down past the Trainer Gear UI
	ld [hl], a
	ret

TrainerGear_MapJoypad:
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
	ld b, SGB_TRAINERGEAR_RADIO
	call GetSGBLayout

	ld de, RadioGFX
	ld hl, vChars2 tile TRAINERGEAR_GFX_TUNE_BUTTON
	lb bc, BANK(RadioGFX), 9
	call Request2bpp
	ld de, VerticalPipeGFX
	ld hl, vChars0
	lb bc, BANK(VerticalPipeGFX), 1
	call Request2bpp

	coord hl, 0, 3
	ld bc, SCREEN_WIDTH * 9
	ld a, TRAINERGEAR_GFX_GRAYTILE
	call ByteFill

	coord hl, 1, 8
	lb bc, 4, 18
	call TrainerGear_DrawBox
	coord hl, 4, 3
	lb bc, 6, 14
	call TrainerGear_DrawBox
	ld a, TRAINERGEAR_GFX_BORDER_TOP
	coord hl, 0, 11
	ld [hl], a
	coord hl, 19, 11
	ld [hl], a

	coord hl, 2, 5
	ld a, TRAINERGEAR_GFX_TUNE_BUTTON
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	inc a
	ld [hld], a
	coord hl, 2, 4
	ld a, TRAINERGEAR_GFX_TUNE_TEXT
	ld [hli], a
	inc a
	ld [hl], a

	coord hl, 5, 5
	ld bc, 12
	ld a, TRAINERGEAR_GFX_RADIO_TOPHALF
	call ByteFill
	coord hl, 5, 6
	ld bc, 12
	ld a, TRAINERGEAR_GFX_RADIO_BOTTOMHALF
	call ByteFill

	ld hl, TrainerGear_RadioText
	call PrintText

	call WaitBGMap

	depixel 9, 4, 4, 3
	ld a, SPRITE_ANIM_OBJ_TRAINERGEAR_POINTER
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], 0
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], TRAINERGEAR_GFX_POINTER
	depixel 8, 6
	ld a, SPRITE_ANIM_OBJ_RADIO_FREQUENCY_METER
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], TRAINERGEAR_GFX_VERTICAL_PIPE
	xor a
	ld [wTrainerGearRadioIndex], a
	ret

TrainerGear_RadioJoypad:
	ld hl, hJoyDown
	ld a, [hl]
	and B_BUTTON
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

TrainerGear_RadioJumptable:
	ld hl, wTrainerGearRadioIndex
	ld e, [hl]
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw .WaitInput
	dw .AdvanceDial
	dw .WaitInput
	dw .TurnBackDial

.WaitInput:
	ld hl, hJoyDown
	ld a, [hl]
	and A_BUTTON
	ret z
	ld hl, wTrainerGearRadioIndex
	inc [hl]
	ret

.AdvanceDial:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .advance_save_pos
	call .GetRadioEvents
	jr c, .advance_wait_input
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	and a
	jr z, .reached_end

.advance_save_pos
	ld hl, -$40
	jr .SaveCursorPosition

.reached_end
	ld a, TRAINERGEAR_RADIOSTATE_TURNBACKDIAL
	ld [wTrainerGearRadioIndex], a
	ret

.advance_wait_input
	call .advance_save_pos
	xor a ; TRAINERGEAR_RADIOSTATE_WAITINPUT_1
	ld [wTrainerGearRadioIndex], a
	ret

.TurnBackDial:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .turnback_save_pos
	call .GetRadioEvents
	jr c, .turnback_wait_input
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cp $60
	jr z, .reached_beginning
.turnback_save_pos
	ld hl, $40
	jr .SaveCursorPosition
.reached_beginning
	ld a, TRAINERGEAR_RADIOSTATE_ADVANCEDIAL
	ld [wTrainerGearRadioIndex], a
	ret
.turnback_wait_input
	call .turnback_save_pos
	ld a, TRAINERGEAR_RADIOSTATE_WAITINPUT_2
	ld [wTrainerGearRadioIndex], a
	ret

.SaveCursorPosition:
	push hl
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld d, [hl]
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	pop hl
	add hl, de
	ld e, l
	ld d, h
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], d
	ret

.GetRadioEvents:
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
; Returns carry upon exiting event
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

MACRO radio_station
	; \1 = "frequency" (tuning knob's X position)
	; \2 = parameter (loaded onto E)
	; \3 = subroutine to call
	; \4 = unused
	db \1, \2
	dw \3, \4
ENDM

TrainerGear_RadioStations_Music:
; list of radio stations associated with the map group
	radio_station $10, MUSIC_ROUTE_1,        .PlayMusic, .PlayMusic
	radio_station $20, MUSIC_TRAINER_BATTLE, .PlayMusic, .PlayMusic
	radio_station $40, MUSIC_VIRIDIAN_CITY,  .PlayMusic, .PlayMusic
	radio_station $48, MUSIC_BICYCLE,        .PlayMusic, .PlayMusic
	db 0 ; list terminator

.PlayMusic:
	ld d, 0
	call PlayMusic
	ret

TrainerGear_Phone:
	call TrainerGear_Next
	call TrainerGear_ClearView
	call WaitForAutoBgMapTransfer
	ld b, SGB_TRAINERGEAR
	call GetSGBLayout
	call LoadFontExtra
	ld de, .OutOfRangeText
	coord hl, 7, 7
	call PlaceString
	ld hl, .DarnText
	call PrintText
	call WaitBGMap
	ret

.OutOfRangeText:
	db "けんがい@"

.DarnText:
	text "ちぇっ⋯⋯⋯⋯"
	done

TrainerGear_PhoneJoypad:
	ld hl, hJoyDown
	ld a, [hl]
	and B_BUTTON
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

TrainerGear_ClearView:
	callfar ClearSpriteAnims
	call ClearSprites
	call WaitForAutoBgMapTransfer
	coord hl, 0, 3
	ld bc, SCREEN_WIDTH * 15
	ld a, TRAINERGEAR_GFX_BLANKTILE
	call ByteFill
	call WaitBGMap
	call WaitBGMap
	ret

; called from sprite animation routine

AnimateTrainerGearModeIndicatorPointer::
	ld hl, wTrainerGearPointerPosition
	ld de, hJoySum
	ld a, [de]
	and D_LEFT
	jr nz, .move_left
	ld a, [de]
	and D_RIGHT
	jr nz, .move_right
	jr .update_position
.move_left
	ld a, [hl]
	and a
	ret z
	dec [hl]
	jr .update_position
.move_right
	ld a, [hl]
	cp NUM_TRAINERGEAR_CARDS - 1
	ret nc
	inc [hl]
.update_position
	ld e, [hl]
	ld d, 0
	ld hl, .CursorPositions
	add hl, de
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.CursorPositions:
	db $00, $18, $30, $00

TrainerGear_DrawBox:
	dec c
	dec c
	dec b
	dec b
	ld de, SCREEN_WIDTH
	push bc
	push hl
	ld a, TRAINERGEAR_GFX_BORDER_TOPLEFT
	ld [hli], a
	ld a, TRAINERGEAR_GFX_BORDER_TOP
.draw_separator
	ld [hli], a
	dec c
	jr nz, .draw_separator
	ld a, TRAINERGEAR_GFX_BORDER_TOPRIGHT
	ld [hl], a
	pop hl
	pop bc
	add hl, de
.draw_row
	push bc
	push hl
	ld a, TRAINERGEAR_GFX_BORDER_LEFT
	ld [hli], a
	ld a, TRAINERGEAR_GFX_BLANKTILE
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ld a, TRAINERGEAR_GFX_BORDER_RIGHT
	ld [hli], a
	pop hl
	add hl, de
	pop bc
	dec b
	jr nz, .draw_row
	ld a, TRAINERGEAR_GFX_BORDER_BOTTOMLEFT
	ld [hli], a
	ld a, TRAINERGEAR_GFX_BORDER_BOTTOM
.draw_bottom
	ld [hli], a
	dec c
	jr nz, .draw_bottom
	ld a, TRAINERGEAR_GFX_BORDER_BOTTOMRIGHT
	ld [hli], a
	ret

SECTION "engine/trainer_gear.asm@TrainerGear_RadioText", ROMX

TrainerGear_RadioText:
	text "エーボタンで　チューニング！"
	done
