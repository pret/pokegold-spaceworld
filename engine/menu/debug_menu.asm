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
	dw Function094c ; sound test
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
	ld b, $1F
	ld a, $FF
.loop
	ld [hl+], a
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ld a, $03
	ld [hl], a
	ld [de], a
	callab MonsterTest
	ld a, $e4
	ldh [rBGP], a

Function40eb::
	jp DebugMenu

DebugMenuOptionName::
	callab OpenTrainerGear
	ld a, $e4
	ldh [rBGP], a
	jp DebugMenu
