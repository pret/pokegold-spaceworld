INCLUDE "constants.asm"

SECTION "engine/menu/main_menu.asm@Initialize new game WRAM", ROMX
; TODO: Move this to another file when surrounding
; functions have been disassembled.
InitializeNewGameWRAM:
	ld a, [wSGB]
	push af

	; Clear a lot of in-game WRAM.

	ld hl, wVirtualOAM
	ld bc, (wcd3f + 1) - wVirtualOAM
	xor a
	call ByteFill

	ld hl, wPlayerName
	ld bc, $1164
	xor a
	call ByteFill
	
	; Lots of other setup.

	pop af
	ld [wSGB], a

	ldh a, [rLY]
	ldh [hRTCRandom], a
	call DelayFrame

	ldh a, [hRandomSub]
	ld [wce73], a
	ldh a, [rLY]
	ldh [hRTCRandom], a
	call DelayFrame

	ldh a, [hRandomAdd]
	ld [wce74], a

	ld hl, wPartyCount
	call InitializeByteList
	ld hl, wUnknownListLengthda83
	call InitializeByteList
	ld hl, wNumBagItems
	call InitializeByteList
	ld hl, wNumKeyItems
	call InitializeByteList
	ld hl, wUnknownListLengthd1ea
	call InitializeByteList

	xor a
	ld [wMonType], a
	ld [wd163], a
	ld [wd164], a
	ld [wd15b], a
	ld [wd15c], a
	ld [wd15d], a

	ld a, $0B
	ld [wd15e], a

	ld a, $B8
	ld [wd15f], a
	
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

; Initializes a 0xFF-terminated list preceded by a length to
; length 0, with an immediate terminator.
InitializeByteList:
	xor a
	ld [hli], a
	dec a
	ld [hl], a
	ret

SECTION "engine/menu/main_menu.asm@MainMenu", ROMX

MainMenu:: ; 01:53CC
	ld hl, wd4a9 
	res 0, [hl]
	call ClearTileMap
	call GetMemSGBLayout
	call LoadFontExtra
	call LoadFont
	call ClearWindowData
	call Function5388
	ld hl, wce60
	bit 0, [hl]
	jr nz, .skip1
	xor a ; new game
	jr .next1
.skip1
	ld a, M_CONTINUE
	ld a, M_NEW_GAME ; the check above is wrong somehow: bit 0 of $ce60
	                 ; is set even when there's no saved game.
.next1
	ld [wWhichIndexSet],a
	ld hl, MainMenuHeader
	call LoadMenuHeader
	call OpenMenu
	call CloseWindow
	jp c, TitleSequenceStart
	ld hl, MainMenuJumptable
	ld a, [wMenuSelection]
	jp CallJumptable

MainMenuHeader: ; 01:5418
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 14, 7
	dw .MenuData
	db 1 ; default option

.MenuData: ; 01:5420
	db $80
	db 0 ; items
	dw MainMenuItems
	db $8a, $1f
	dw .Strings

.Strings: ; 01:5428
	db "CONTINUE@"
	db "NEW GAME@"
	db "OPTIONS@"
	db "PLAY POKéMON@"
	db "TIME@"
	db "@@@" 

MainMenuJumptable: ; 01:5457
	dw MainMenuOptionContinue
	dw StartNewGame
	dw MenuCallSettings
	dw StartNewGame
	dw MainMenuOptionSetTime

MainMenuItems:

NewGameMenu:
	db 4
	db NEW_GAME
	db PLAY_POKEMON
	db OPTION
	db SET_TIME
	db -1

ContinueMenu:
	db 5
	db CONTINUE
	db NEW_GAME
	db PLAY_POKEMON
	db OPTION
	db SET_TIME
	db -1

MainMenuOptionSetTime:: ; 5473
	callab SetTime
	ret

MainMenuOptionContinue:: ;547C
	callab Function14624
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
	call Function5397
	call Function53b0
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

DisplayContinueGameInfo:: ; 54BF
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

PrintNumBadges:: ;54FA
	push hl
	ld hl, wd163 ; badges?
	ld b, $01
	call CountSetBits
	pop hl
	ld de, wCountSetBitsResult
	ld bc, $0102 ; flags and constants for this? 1 byte source, 2 digit display
	jp PrintNumber

PrintNumOwnedMons:: ; 550D
	push hl
	ld hl, wPokedexOwned
	ld b, $20 ; flag_array NUM_POKEMON?
	call CountSetBits
	pop hl
	ld de, wCountSetBitsResult
	ld bc, $0103 ; 1 byte, 3 digit
	jp PrintNumber

PrintPlayTime:: ; 5520
	ld de, hRTCHours
	ld bc, $0103 ; 1 byte, 3 digit
	call PrintNumber
	ld [hl], "："
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
	
StartNewGame:: ; 555C
	ld de, MUSIC_NONE
	call PlayMusic
	ld de, MUSIC_OAK_INTRO
	call PlayMusic
	call LoadFontExtra
	xor a
	ldh [hBGMapMode], a
	callba InitializeNewGameWRAM
	call ClearTileMap
	call ClearWindowData
	xor a
	ldh [hMapAnims], a
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	jp z, DemoStart
	call DebugSetUpPlayer
	jp IntroCleanup
	
; 558D