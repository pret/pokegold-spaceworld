INCLUDE "constants.asm"

SECTION "Title Debug Menu", ROMX[$4031], BANK[$01]

TitleDebugMenu:: ; $4031
	call ClearTileMap
	call ClearWindowData
	call LoadFont
	call LoadFontsBattleExtra
	call ClearSprites
	call GetMemSGBLayout
	xor a
	ld [wWhichIndexSet], a
	ld hl, TitleDebugMenuHeader
	call LoadMenuHeader
	call OpenMenu
	call CloseWindow
	jp c, TitleSequenceStart
	ld a, $41
	ld [wce5f], a
	ld a, [wMenuSelection]
	ld hl, TitleDebugJumpTable
	jp CallJumptable

TitleDebugJumpTable:: ; 4064
	dw TitleDebugMenuOptionFight
	dw TitleDebugMenuOptionField
	dw Function094c ; sound test
	dw TitleDebugMenuOptionSubGames
	dw TitleDebugMenuOptionMonsterTest
	dw TitleDebugMenuOptionName
	
TitleDebugMenuHeader: ; 4070
	db MENU_BACKUP_TILES ; flags
	menu_coords 05, 02, SCREEN_WIDTH - 7, SCREEN_HEIGHT - 1
	dw .MenuData
	db 01 ; default option

.MenuData: ; 4078
	db $A0 
	db 0 ; items
	dw TitleDebugMenuItems
	db $8A, $1F 
	dw .Strings
	
.Strings
	db "ファイト@"
	db "フィールド@"
	db "サウンド@"
	db "サブゲーム@"
	db "モンスター@"
	db "なまえ@"
	
TitleDebugMenuItems:
	db 06 
	db 00 
	db 01 
	db 02 
	db 03 
	db 04 
	db 05 
	db -1

TitleDebugMenuOptionField:: ; 40A8
	ld hl, wDebugFlags
	set DEBUG_FIELD_F, [hl] ; set debug mode
	jp StartNewGame
	
TitleDebugMenuOptionFight:: ; 40B0
	ld hl, wDebugFlags
	set DEBUG_BATTLE_F, [hl]
	ld a, $54
	call Predef
	ld hl, wDebugFlags
	res DEBUG_BATTLE_F, [hl]
	ret

TitleDebugMenuOptionSubGames:: ; 40C0
	callab CallSubGameMenu
	jp TitleDebugMenu

TitleDebugMenuOptionMonsterTest:: ; 40CB
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
	jp TitleDebugMenu

TitleDebugMenuOptionName:: ; 40EE
	callab OpenPokegear
	ld a, $e4
	ldh [rBGP], a
	jp TitleDebugMenu
	
; 40FD