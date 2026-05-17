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
	ld a, BATTLE_SHIFT | TEXT_DELAY_FAST
	ld [wOptions], a
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
	jp NewGame

DebugMenuOptionFight::
	ld hl, wDebugFlags
	set DEBUG_BATTLE_F, [hl]
	predef FightDebugMenu
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

OpenDebugMenu::
	jp DebugMenu

DebugMenuOptionName::
	callfar OpenTrainerGear
	ld a, %11100100
	ldh [rBGP], a
	jp DebugMenu

SetDemoEventFlags:
	ld hl, wd41a
	set 5, [hl]
	ld hl, wd41a
	set 7, [hl] ; talked to blue
	ld hl, wd41a
	set 0, [hl] ; read email
	ld hl, wd41a
	set 3, [hl]
	ld hl, wd41a
	set 6, [hl]
	ld hl, wd41a
	set 6, [hl]
	ld hl, wd41e
	set 5, [hl]
	ld hl, wd41b
	set 1, [hl] ; followed oak to back room
	ld hl, wd41c
	set 4, [hl] ; received pokedexes
	ld hl, wd41d
	set 2, [hl] ; beat rival in lab
	ld hl, wd41b
	set 2, [hl] ; chose a starter
	ld a, 1
	ld [wPlayerHouse2FCurScript], a
	ld a, 1
	ld [wPlayerHouse1FCurScript], a
	ld a, 6
	ld [wSilentHillCurScript], a
	ld a, 18
	ld [wSilentHillLabFrontCurScript], a
	ld a, 6
	ld [wSilentHillLabBackCurScript], a
	ld a, 2
	ld [wSilentHillHouseCurScript], a
	ret
