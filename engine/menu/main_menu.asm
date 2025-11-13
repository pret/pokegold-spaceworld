INCLUDE "constants.asm"

	const_def
	const M_NEW_GAME
	const M_CONTINUE
	const M_PLAY_GAME
	const M_SET_TIME

	const_def
	const CONTINUE
	const NEW_GAME
	const OPTION
	const PLAY_POKEMON
	const SET_TIME

SECTION "engine/menu/main_menu.asm", ROMX

InitializeNewGameWRAM:
	ld a, [wSGB]
	push af

	; Clear a lot of in-game WRAM.

	ld hl, wShadowOAM
	ld bc, (wcd3f) - wShadowOAM
	xor a
	call ByteFill

	ld hl, wPlayerName
	ld bc, wBoxMonNicknamesEnd - wPlayerName
	xor a
	call ByteFill

	; Lots of other setup.

	pop af
	ld [wSGB], a

	ldh a, [rLY]
	ldh [hRTCRandom], a
	call DelayFrame

	ldh a, [hRandomSub]
	ld [wPlayerID], a
	ldh a, [rLY]
	ldh [hRTCRandom], a
	call DelayFrame

	ldh a, [hRandomAdd]
	ld [wPlayerID + 1], a

	ld hl, wPartyCount
	call .InitList
	ld hl, wBoxCount
	call .InitList
	ld hl, wNumBagItems
	call .InitList
	ld hl, wNumKeyItems
	call .InitList
	ld hl, wUnknownListLengthd1ea
	call .InitList

	xor a
	ld [wMonType], a
	ld [wJohtoBadges], a
	ld [wKantoBadges], a
	ld [wCoins], a
	ld [wCoins + 1], a

if START_MONEY >= $10000
	ld a, HIGH(START_MONEY >> 8)
endc
	ld [wMoney], a
	ld a, HIGH(START_MONEY)
	ld [wMoney + 1], a
	ld a, LOW(START_MONEY)
	ld [wMoney + 2], a

	ld hl, wUnknownListLengthd1ea
	ld a, ITEM_REPEL
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantity], a
	call ReceiveItem

	ld a, MAP_SILENT_HILL
	ld [wMapId], a
	ld a, GROUP_SILENT_HILL
	ld [wMapGroup], a

	ret

; Loads 0 in the count and -1 in the first item or mon slot.
.InitList:
	xor a
	ld [hli], a
	dec a
	ld [hl], a
	ret

CheckIfSaveFileExists:
	ld a, BANK(sOptions)
	call OpenSRAM
	ld a, [sOptions]
	ld [wSaveFileExists], a
	call CloseSRAM
	ret

LoadOptions:
	ld a, BANK(sOptions)
	call OpenSRAM
	ld hl, sOptions
	ld a, [hli]
	ld [wOptions], a
	inc hl
	ld a, [hli]
	ld [wActiveFrame], a
	ld a, [hl]
	ld [wTextboxFlags], a
	call CloseSRAM
	ret

; Copies the contents of wDebugFlags - wce66 to... themselves.
; Presumably, the debug flags were originally saved to the save file (evidenced by SRAM being opened and closed),
; but the source address was dummied out.
Dummy_LoadDebugFlags:
	ld a, BANK(s0_a600)
	call OpenSRAM
	ld hl, wDebugFlags
	ld a, [hli]
	ld [wDebugFlags], a
	ld a, [hli]
	ld [wce64], a
	ld a, [hli]
	ld [wce65], a
	ld a, [hl]
	ld [wce66], a
	call CloseSRAM
	ret

MainMenu::
	ld hl, wd4a9
	res 0, [hl]
	call ClearTileMap
	call GetMemSGBLayout
	call LoadFontExtra
	call LoadFont
	call ClearWindowData
	call CheckIfSaveFileExists
	ld hl, wSaveFileExists
	bit 0, [hl]
	jr nz, .setMenuContinue
	xor a
	jr .skip
.setMenuContinue
	ld a, M_CONTINUE
.skip
	ldh a, [hJoyState]
	and D_DOWN | B_BUTTON | A_BUTTON
	cp D_DOWN | B_BUTTON | A_BUTTON
	jr nz, .setMenuPlay
	ld a, M_SET_TIME
	jr .triggerMenu
.setMenuPlay
	ld a, M_PLAY_GAME
.triggerMenu
	ld [wWhichIndexSet], a
	ld hl, MainMenuHeader
	call LoadMenuHeader
	call OpenMenu
	call CloseWindow
	jp c, TitleSequenceStart
	ld hl, MainMenuJumptable
	ld a, [wMenuSelection]
	jp CallJumptable

MainMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 13, 7
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $80
	db 0 ; items
	dw MainMenuItems
	db $8a, $1f
	dw .Strings

.Strings:
	db "つづきから　はじめる@"
	db "さいしょから　はじめる@"
	db "せっていを　かえる@"
	db "#を　あそぶ@"
	db "じかんセット@"

MainMenuJumptable:
	dw MainMenuOptionContinue
	dw StartNewGame
	dw MenuCallSettings
	dw StartNewGame
	dw MainMenuOptionSetTime

MainMenuItems:

NewGameMenu:
	db 2
	db NEW_GAME
	db OPTION
	db -1

ContinueMenu:
	db 3
	db CONTINUE
	db NEW_GAME
	db OPTION
	db -1

PlayPokemonMenu:
	db 2
	db PLAY_POKEMON
	db OPTION
	db -1

PlayPokemonSetTimeMenu:
	db 3
	db PLAY_POKEMON
	db OPTION
	db SET_TIME
	db -1

MainMenuOptionSetTime::
	callfar SetTime
	ret

MainMenuOptionContinue::
	callfar Function14624
	call DisplayContinueGameInfo
.loop
	call ClearJoypad
	call GetJoypad
	ldh a, [hJoyState]
	bit A_BUTTON_F, a
	jr nz, .escape
	bit B_BUTTON_F, a
	jp nz, MainMenu
	jr .loop
.escape
	call LoadOptions
	call Dummy_LoadDebugFlags
	ld hl, wDebugFlags
	res DEBUG_FIELD_F, [hl]
	set CONTINUED_F, [hl]
	set 3, [hl]
	ldh a, [hJoyState]
	bit SELECT_F, a
	jr z, .skip
	set 1, [hl]
.skip
	call ClearBGPalettes
	call ClearTileMap
	ld c, $0A
	call DelayFrames
	jp OverworldStart

DisplayContinueGameInfo::
	xor a
	ldh [hBGMapMode], a
	hlcoord 4, 7
	ld b, $08
	ld c, $0D
	call DrawTextBox
	hlcoord 5, 9
	ld de, PlayerInfoText
	call PlaceString
	hlcoord 13, 9
	ld de, wPlayerName
	call PlaceString
	hlcoord 14, 11
	call PrintNumBadges
	hlcoord 13, 13
	call PrintNumOwnedMons
	hlcoord 12, 15
	call PrintPlayTime
	ld a, $01
	ldh [hBGMapMode], a
	ld c, $1E
	call DelayFrames
	ret

PrintNumBadges::
	push hl
	ld hl, wJohtoBadges
	ld b, $01 ; only Johto Badges
	call CountSetBits
	pop hl
	ld de, wNumSetBits
	ld bc, $0102 ; flags and constants for this? 1 byte source, 2 digit display
	jp PrintNumber

PrintNumOwnedMons::
	push hl
	ld hl, wPokedexCaught
	ld b, $20 ; flag_array NUM_POKEMON?
	call CountSetBits
	pop hl
	ld de, wNumSetBits
	ld bc, $0103 ; 1 byte, 3 digit
	jp PrintNumber

PrintPlayTime::
	ld de, hRTCHours
	ld bc, $0103 ; 1 byte, 3 digit
	call PrintNumber
	ld [hl], '：'
	inc hl
	ld de, hRTCMinutes
	ld bc, $8102 ; PRINTNUM_LEADINGZEROS, 1 byte, 2 digit
	jp PrintNumber

PlayerInfoText:
	db   "しゅじんこう"
	next "もっているバッジ　　　　こ"
	next "#ずかん　　　　ひき"
	next "プレイじかん"
	text_end

StartNewGame::
	ld de, MUSIC_NONE
	call PlayMusic
	ld de, MUSIC_OAK_INTRO
	call PlayMusic
	call LoadFontExtra
	xor a
	ldh [hBGMapMode], a
	farcall InitializeNewGameWRAM
	call ClearTileMap
	call ClearWindowData
	xor a
	ldh [hMapAnims], a
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	jp z, DemoStart
	call DebugSetUpPlayer
	jp IntroCleanup
