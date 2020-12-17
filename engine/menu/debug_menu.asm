INCLUDE "constants.asm"

SECTION "engine/menu/debug_menu.asm", ROMX

DebugMenu::
	call ClearTileMap
	call ClearWindowData
	call LoadFont
	call LoadFontsBattleExtra
	call ClearSprites
	call GetMemSGBLayout
	xor a
	ld [wWhichIndexSet], a
	ld hl, DebugMenuHeader
	call LoadMenuHeader
	call OpenMenu
	call CloseWindow
	jp c, TitleSequenceStart
	ld a, $41
	ld [wce5f], a
	ld a, [wMenuSelection]
	ld hl, DebugJumpTable
	jp CallJumptable

DebugJumpTable::
	dw DebugMenuOptionFight
	dw DebugMenuOptionField
	dw DebugMenuSoundTest	; to home bank
	dw DebugMenuOptionSubGames
	dw DebugMenuOptionMonsterTest
	dw DebugMenuOptionName

DebugMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 05, 02, SCREEN_WIDTH - 7, SCREEN_HEIGHT - 1
	dw .MenuData
	db 01 ; default option

.MenuData:
	db $A0
	db 0 ; items
	dw DebugMenuItems
	db $8A, $1F
	dw .Strings

.Strings
	db "ファイト@"
	db "フィールド@"
	db "サウンド@"
	db "サブゲーム@"
	db "モンスター@"
	db "なまえ@"

DebugMenuItems:
	db 06
	db 00
	db 01
	db 02
	db 03
	db 04
	db 05
	db -1

DebugMenuOptionField::
	ld hl, wDebugFlags
	set DEBUG_FIELD_F, [hl] ; set debug mode
	jp StartNewGame

DebugMenuOptionFight::
	ld hl, wDebugFlags
	set DEBUG_BATTLE_F, [hl]
	ld a, $54
	call Predef
	ld hl, wDebugFlags
	res DEBUG_BATTLE_F, [hl]
	ret

DebugMenuOptionSubGames::
	callab CallSubGameMenu
	jp DebugMenu

DebugMenuOptionMonsterTest::
	ld hl, wPokedexOwned
	ld de, wPokedexSeen
	ld b, 31
	ld a, -1
.loop
	ld [hl+], a
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ld a, 3
	ld [hl], a
	ld [de], a
	callab MonsterTest
	ld a, %11100100
	ldh [rBGP], a

Function40eb::
	jp DebugMenu

DebugMenuOptionName::
	callab OpenTrainerGear
	ld a, %11100100
	ldh [rBGP], a
	jp DebugMenu

SECTION "engine/menu/debug_menu.asm@Sound Test", ROMX

_DebugMenuSoundTest::
	call ClearTileMap
	call LoadFontExtra
	call ClearSprites
	call GetMemSGBLayout
	xor a
	ldh [hDebugMenuSoundMenuIndex], a
	call .DetermineDescriptionPointer

.RefreshScreenAndLoop:
	call WaitBGMap

.Loop:
	call ClearJoypad
	call GetJoypad
	ldh a, [hJoyDown]
	and a
	jr z, .Loop

	bit A_BUTTON_F, a
	jr nz, .a_pressed

	bit B_BUTTON_F, a
	jr nz, .b_pressed

	bit START_F, a
	jr nz, .start_pressed

	bit D_UP_F, a
	jr nz, .up_pressed

	bit D_DOWN_F, a
	jr nz, .down_pressed

	ret

.a_pressed
	ldh a, [hDebugMenuSoundBank]
	ld c, a
	ldh a, [hDebugMenuSoundID]
	jr .RefreshScreenAndLoop

.up_pressed
	ldh a, [hDebugMenuSoundMenuIndex]
	inc a
	cp 55
	jr nz, .SetIndex

	xor a

.SetIndex:
	ldh [hDebugMenuSoundMenuIndex], a
	call .DetermineDescriptionPointer
	jr .RefreshScreenAndLoop

.down_pressed
	ldh a, [hDebugMenuSoundMenuIndex]
	dec a
	cp -1
	jr nz, .SetIndex2

	ld a, 54

.SetIndex2:
	ldh [hDebugMenuSoundMenuIndex], a
	call .DetermineDescriptionPointer
	jr .RefreshScreenAndLoop

.start_pressed
	ldh a, [hDebugMenuSoundBank]
	ld c, a
	ld a, -1
	jr .RefreshScreenAndLoop

.b_pressed
	ldh a, [hDebugMenuSoundBank]
	ld c, a
	ld a, 10
	ld [wcdb5], a
	ld [wcdb6], a
	ld a, -1
	ld [wcdb4], a
	jr .RefreshScreenAndLoop

.DetermineDescriptionPointer:
	ld hl, SoundTestTextPointers
	ldh a, [hDebugMenuSoundMenuIndex]
	add a
	add a	; a * 8
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ldh [hDebugMenuSoundID], a
	ld a, [hli]
	ldh [hDebugMenuSoundBank], a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call CopyStringToStringBuffer2
	call .DisplayText
	ret

.DisplayText:
	ld hl, hDebugMenuSoundMenuIndex
	inc [hl]
	ld hl, .String
	call PrintText
	ld hl, hDebugMenuSoundMenuIndex
	dec [hl]
	ld c, 3
	call DelayFrames
	ret

.String:
	deciram hDebugMenuSoundMenuIndex, 1, 1
	text "<LINE>@"
	text_from_ram wStartDay
	text "　"
	done

INCLUDE "data/sound_test_text_pointers.inc"
