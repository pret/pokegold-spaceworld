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
	ld hl, .TextPointers
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

.TextPointers:
;            id?  bank? description
	dbbw $00,  $3A, SoundTest_PalletTownText
 	dbbw $00,  $3A, SoundTest_PokecenterText
 	dbbw $00,  $3A, SoundTest_PokegymText
 	dbbw $07,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $0C,  $3A, SoundTest_PokeEvolutionText
 	dbbw $08,  $3A, SoundTest_HealingText
 	dbbw $02,  $3A, SoundTest_QuestionMarkText
 	dbbw $03,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_QuestionMarkText
 	dbbw $00,  $3A, SoundTest_ReservedText
 	dbbw $00,  $3A, SoundTest_OakText
 	dbbw $00,  $3A, SoundTest_RivalText
 	dbbw $00,  $3A, SoundTest_StAnneText
 	dbbw $66,  $3A, SoundTest_Fanfare3Text
 	dbbw $68,  $3A, SoundTest_Fanfare5Text
 	dbbw $69,  $3A, SoundTest_Fanfare6Text
 	dbbw $63,  $3A, SoundTest_FanfareText
 	dbbw $21,  $3A, SoundTest_FluteText
 	dbbw $04,  $3B, SoundTest_BattleText
 	dbbw $05,  $3B, SoundTest_BattleText
 	dbbw $00,  $3B, SoundTest_BattleText
 	dbbw $00,  $3B, SoundTest_ChampionBattleText
 	dbbw $0B,  $3B, SoundTest_VictoryText
 	dbbw $00,  $3B, SoundTest_VictoryText
 	dbbw $00,  $3B, SoundTest_VictoryText
 	dbbw $67,  $3B, SoundTest_Fanfare4Text
 	dbbw $68,  $3B, SoundTest_Fanfare5Text_2
 	dbbw $6B,  $3B, SoundTest_Fanfare8Text
 	dbbw $00,  $3C, SoundTest_TitleText
 	dbbw $00,  $3C, SoundTest_EndingText
 	dbbw $00,  $3C, SoundTest_HallOfFameText
 	dbbw $00,  $3C, SoundTest_KenkiYujiyoText
 	dbbw $00,  $3C, SoundTest_JigglypuffSongText
 	dbbw $09,  $3C, SoundTest_BikeText
 	dbbw $00,  $3C, SoundTest_SurfText
 	dbbw $00,  $3C, SoundTest_CasinoText
 	dbbw $00,  $3C, SoundTest_IntroBattleText
 	dbbw $00,  $3C, SoundTest_DungeonText
 	dbbw $00,  $3C, SoundTest_DungeonText
 	dbbw $00,  $3C, SoundTest_DungeonText
 	dbbw $00,  $3C, SoundTest_DungeonText
 	dbbw $00,  $3C, SoundTest_TouText
 	dbbw $00,  $3C, SoundTest_TouText
 	dbbw $0A,  $3C, SoundTest_DealerText
 	dbbw $00,  $3C, SoundTest_DealerText
 	dbbw $00,  $3C, SoundTest_DealerText
 	dbbw $66,  $3C, SoundTest_Fanfare3Text_2
 	dbbw $69,  $3C, SoundTest_Fanfare6Text_2
 	dbbw  -1    -1, .TextPointers

SoundTest_PalletTownText:
	db "マサラタウン@"

SoundTest_PokecenterText:
	db "#センター@"

SoundTest_PokegymText:
	db "#ジム@"

SoundTest_PokeEvolutionText:
	db "#しんか@"

SoundTest_HealingText:
	db "あさあさあさ@"

SoundTest_ReservedText:
	db "つれていかれる@"

SoundTest_OakText:
	db "オーキドとともに@"

SoundTest_RivalText:
	db "ライバル@"

SoundTest_StAnneText:
	db "サントアンヌゴウ@"

SoundTest_FluteText:
	db "ふえ@"

SoundTest_BattleText:
	db "せんとう@"

SoundTest_ChampionBattleText:
	db "さいしゆうせんとう@"

SoundTest_VictoryText:
	db "かち@"

SoundTest_FanfareText:
	db "フぁンファーレ@"

SoundTest_Fanfare3Text:
	db "フぁンファーレ３@"

SoundTest_Fanfare5Text:
	db "フぁンファーレ５@"

SoundTest_Fanfare6Text:
	db "フぁンファーレ６@"

SoundTest_Fanfare4Text:
	db "フぁンファーレ４@"

SoundTest_Fanfare5Text_2:
	db "フぁンファーレ５@"

SoundTest_Fanfare8Text:
	db "フぁンファーレ８@"

SoundTest_Fanfare3Text_2:
	db "フぁンファーレ３@"

SoundTest_Fanfare6Text_2:
	db "フぁンファーレ６@"

SoundTest_TitleText:
	db "タイトル@"

SoundTest_EndingText:
	db "エンディング@"

SoundTest_HallOfFameText:
	db "でんどういり@"

SoundTest_KenkiYujiyoText:
	db "けんきゆうじよ@"

SoundTest_JigglypuffSongText:
	db "プりンノうた@"

SoundTest_BikeText:
	db "じてんしや@"

SoundTest_SurfText:
	db "うみ@"

SoundTest_CasinoText:
	db "カジノ@"

SoundTest_IntroBattleText:
	db "オープニングデモ@"

SoundTest_DungeonText:
	db "どうくつ@"

SoundTest_TouText:
	db "とう@"

SoundTest_DealerText:
	db "ディーラー@"

SoundTest_QuestionMarkText:
	db "？@"

