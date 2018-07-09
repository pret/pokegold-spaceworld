include "constants.asm"

SECTION "Field Debug Menu", ROMX[$4000], BANK[$3F]

FieldDebugMenuHeader:: ; 3F:4000
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, SCREEN_WIDTH - 13, SCREEN_HEIGHT - 1
	dw .MenuData
	db 01 ; default option

.MenuData: ; 3F:4008
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_ENABLE_START | STATICMENU_ENABLE_LEFT_RIGHT ; flags
	db 0 ; items
	dw FieldDebugMenuPages
	dw PlaceMenuStrings
	dw .Strings

.Strings: ; 3F:4010
	db "りセット@"
	db "とじる@"
	db "わくせん@"
	db "ゲーム@"
	db "のりもの@"
	db "セル@"
	db "ちず@"
	db "キャラ@"
	db "なまえ@"
	db "ツールギア@"
	db "イベント@"
	db "かいふく@"
	db "つうしん@"
	db "つぎ▶@"
	db "アニメ@"
	db "つれてく@"
	db "つれてけ@"
	db "ワープ@"
	db "くさかり@"
	db "あしもと@"
	db "じどう@"
	db "うごき@"
	db "マッパー@"
	db "アイテム@"
	db "パソコン@"
	db "ショップ@"
	db "テレポ！@"
	db "テスト@"
	db "じっけん@"

FieldDebugJumpTable:: ; 3F:4094
	dw ResetPrompt
	dw CloseFieldDebugMenu
	dw ChangeWindowBorder
	dw InitGameSelect
	dw ChangeTransportation
	dw ChangeFieldTileset
	dw ShowTownMap
	dw CharacterViewer
	dw NameEntry
	dw InitToolGear
	dw ClearSetEventFlags
	dw RecoverPokemon
	dw InitCableClub
	dw NextFieldDebugMenuPage
	dw NPCMovementTest
	dw TogglePokemonFollowing
	dw PlayerFollowNPCTest
	dw Warp
	dw FieldCutTest
	dw CheckTile
	dw MoveToEntrance
	dw ToggleNPCMovement
	dw InitMapViewer
	dw ItemTest
	dw AccessPC
	dw AccessPokeMart
	dw SetTeleportLocation
	dw InitVRAMViewer
	dw OpenPokeGear

RESET_GAME       EQU 0  ; unused
CLOSE_MENU       EQU 1
CHANGE_BORDER    EQU 2  ; unused
GAME_SELECT      EQU 3
CHANGE_TRANSPORT EQU 4
CHANGE_TILESET   EQU 5  ; unused
SHOW_MAP         EQU 6
CHAR_VIEWER      EQU 7
NAME_ENTRY       EQU 8  ; unused
TOOL_GEAR        EQU 9
EVENT_FLAGS      EQU 10
RECOVER_PKMN     EQU 11
CABLE_CLUB       EQU 12 ; unused
NEXT_PAGE        EQU 13
NPC_MOVE_TEST    EQU 14 ; unused - usable in bottom-left house in Silent Hills
PKMN_FOLLOW      EQU 15 ; unused
FOLLOW_NPC       EQU 16
WARP             EQU 17
CUT_TEST         EQU 18 ; unused
CHECK_TILE       EQU 19 ; unused
MOVE_ENTRANCE    EQU 20 ; unused - usable in Route 1
NPC_MOVE_TOGGLE  EQU 21 ; unused
MAP_VIEWER       EQU 22
ITEM_TEST        EQU 23 ; unused
ACCESS_PC        EQU 24
ACCESS_MART      EQU 25
SET_TELEPORT     EQU 26
VRAM_VIEWER      EQU 27
POKE_GEAR        EQU 28

FieldDebugMenuPages:

FieldDebugMenuPage1: ; 3F:40CE
	db 7
	db NEXT_PAGE
	db WARP
	db CHAR_VIEWER
	db CHANGE_TRANSPORT
	db TOOL_GEAR
	db ACCESS_PC
	db CLOSE
	db -1

FieldDebugMenuPage2: ; 3F:40D7
	db 7
	db NEXT_PAGE
	db ACCESS_MART
	db RECOVER_PKMN
	db POKE_GEAR
	db GAME_SELECT
	db MAP_VIEWER
	db CLOSE
	db -1

FieldDebugMenuPage3: ; 3F:40E0
	db 7
	db NEXT_PAGE
	db EVENT_FLAGS
	db VRAM_VIEWER
	db SET_TELEPORT
	db FOLLOW_NPC
	db SHOW_MAP
	db CLOSE
	db -1

SFX_MENU EQU 3 ; Menu opening sound

FieldDebugMenu:: ; 3F:40E9
	call RefreshScreen
	ld de, SFX_MENU
	call PlaySFX
	ld hl, FieldDebugMenuHeader
	call LoadMenuHeader
	ld a, $00
	ld [wFieldDebugMenuPage], a

.Reopen: ; 3F:40FD
	call UpdateTimePals
	call UpdateSprites
	ld a, [wFieldDebugMenuCursorBuffer]
	ld [wMenuCursorBuffer], a
	call OpenMenu
	jr c, .Exit
	ld a, [wMenuCursorBuffer]
	ld [wFieldDebugMenuCursorBuffer], a
	call PlaceHollowCursor
	ld a, [wMenuJoypad]
	cp A_BUTTON
	jr z, .RunFunction
	call ChangeFieldDebugMenuPage
	jr .RunReturn

.RunFunction: ; 3F:4123
	ld a, [wMenuSelection]
	ld hl, FieldDebugJumpTable
	call CallJumptable

; Field Debug menu items may have different return functions.
.RunReturn: ; 3F:412C
	ld hl, FieldDebugMenuReturns
	jp CallJumptable

.FieldDebugMenuReturns: ; 3F:4132
	dw .Reopen
	dw .Exit
	dw .Close
	dw .Clean
	dw .Return

.Exit: ; 3F:413C
	call GetJoypad
	ldh a, [hJoyDown]
	bit 0, a
	jr nz, .Exit
	call LoadFontExtra

.Close: ; 3F:4148
	call CloseWindow

.Clean: ; 3F:414B
	push af
	call Function1fea
	pop af
	ret

.Return: ; 3F:4151
	call ExitMenu
	ld a, HMENURETURN_ASM
	ld [hStartmenuCloseAndSelectHookEnable], a
	jr .Clean

CloseFieldDebugMenu: ; 3F:415A
	ld a, $02
	ret

ChangeFieldDebugMenuPage: ; 3F:415D
	ld a, [wMenuJoypad]
	cp D_LEFT
	jr z, .prev_page
.next_page
	ld a, [wFieldDebugMenuPage]
	inc a
	cp $03
	jr nz, .load_next_page
.set_page_0
	xor a
.load_next_page
	ld [wFieldDebugMenuPage], a
	jr PlayMenuOpeningSound
.prev_page
	ld a, [wFieldDebugMenuPage]
	dec a
	cp $ff
	jr nz, .load_prev_page
.set_page_2
	ld a, $02
.load_prev_page
	ld [wFieldDebugMenuPage], a
	jr PlayMenuOpeningSound

NextFieldDebugMenuPage: ; 3F:4181
	ld a, [wFieldDebugMenuPage]
	and a
	jr z, .set_page_1
.set_page_0
	xor a
	jr .load_page
.set_page_1
	ld a, $01
.load_page
	ld [wFieldDebugMenuPage], a

PlayMenuOpeningSound: ; 3F:418F
	ld de, SFX_MENU
	call PlaySFX
.loop
	call GetJoypad
	ldh a, [hJoyDown]
	bit 0, a
	jr nz, .loop
	ld a, $00
	ret

; 3F:41A1