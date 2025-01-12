INCLUDE "constants.asm"

SECTION "engine/menu/debug_menu.asm", ROMX

; DebugJumpTable indices
	const_def
	const DEBUGMENU_FIGHT
	const DEBUGMENU_FIELD
	const DEBUGMENU_SOUNDTEST
	const DEBUGMENU_SUBGAME
	const DEBUGMENU_POKEDEX
	const DEBUGMENU_TRAINERGEAR

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
	menu_coords 5, 2, SCREEN_WIDTH - 7, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP
	db 0
	dw DebugMenuItems
	dw PlaceMenuStrings
	dw .Strings

.Strings
	db "ファイト@"
	db "フィールド@"
	db "サウンド@"
	db "サブゲーム@"
	db "モンスター@"
	db "なまえ@"

DebugMenuItems:
	db 6 ; items
	db DEBUGMENU_FIGHT
	db DEBUGMENU_FIELD
	db DEBUGMENU_SOUNDTEST
	db DEBUGMENU_SUBGAME
	db DEBUGMENU_POKEDEX
	db DEBUGMENU_TRAINERGEAR
	db -1

DebugMenuOptionField::
	ld hl, wDebugFlags
	set DEBUG_FIELD_F, [hl] ; set debug mode
	jp StartNewGame

DebugMenuOptionFight::
	ld hl, wDebugFlags
	set DEBUG_BATTLE_F, [hl]
	predef Functionfdb66
	ld hl, wDebugFlags
	res DEBUG_BATTLE_F, [hl]
	ret

DebugMenuOptionSubGames::
	callfar CallSubGameMenu
	jp DebugMenu

DebugMenuOptionMonsterTest::
	ld hl, wPokedexCaught
	ld de, wPokedexSeen
	ld b, NUM_POKEMON / 8
	ld a, %11111111
.loop
	ld [hli], a
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ld a, (1 << ((NUM_POKEMON - 1) % 8)) - 1 ; discount #251
	ld [hl], a
	ld [de], a
	callfar MonsterTest
	ld a, %11100100
	ldh [rBGP], a

Function40eb::
	jp DebugMenu

DebugMenuOptionName::
	callfar OpenTrainerGear
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
	ld a, $ff
	ld [wcdb4], a
	jr .RefreshScreenAndLoop

.DetermineDescriptionPointer:
	ld hl, SoundTestTextPointers
	ldh a, [hDebugMenuSoundMenuIndex]
	add a
	add a ; a * 4
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

SECTION "engine/menu/debug_menu.asm@Subgame Menu", ROMX

CallSubGameMenu:
	call ClearTileMap
	call LoadFont
	call LoadFontsBattleExtra
	call ClearSprites
	call GetMemSGBLayout
	ld hl, .MenuHeader
	call CopyMenuHeader
	call VerticalMenu
	ret c

	ld a, [wMenuCursorY]
	dec a
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .return
	push de
	jp hl

.return
	jr CallSubGameMenu

.Jumptable:
	dw SubGameMenu_PokerGame
	dw SubGameMenu_PuzzleGame
	dw SubGameMenu_CardFlipGame
	dw SubGameMenu_PicrossGame
	dw SubGameMenu_SlotMachineGame

.MenuHeader:
	db 0 ; flags
	menu_coords 5, 4, SCREEN_WIDTH - 7, SCREEN_HEIGHT - 3
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP
	db 5 ; items
	db "ポーカー@"
	db "１５パズル@"
	db "しんけい@"
	db "ピクロス@"
	db "スロット@"

SubGameMenu_PokerGame:
	callfar PokerMinigame
	ret

SubGameMenu_PuzzleGame:
	callfar FifteenPuzzleMinigame
	ret

SubGameMenu_CardFlipGame:
	callfar MemoryMinigame
	ret

SubGameMenu_PicrossGame:
	callfar PicrossMinigame
	ret

SubGameMenu_SlotMachineGame:
	callfar SlotMachineGame
	ret

