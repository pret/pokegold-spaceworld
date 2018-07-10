include "constants.asm"

SECTION "Field Debug Menu", ROMX[$4000], BANK[$3F]

FieldDebugMenuHeader:: ; 3F:4000
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, SCREEN_WIDTH - 13, SCREEN_HEIGHT - 1
	dw .FieldDebugMenuData
	db 01 ; default option

.FieldDebugMenuData: ; 3F:4008
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_ENABLE_START | STATICMENU_ENABLE_LEFT_RIGHT ; flags
	db 0 ; items
	dw FieldDebugMenuPages
	dw PlaceMenuStrings
	dw .FieldDebugStrings

.FieldDebugStrings: ; 3F:4010
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
	dw FieldDebug_ResetPrompt
	dw FieldDebug_CloseFieldDebugMenu
	dw FieldDebug_ChangeWindowBorder
	dw FieldDebug_InitGameSelect
	dw FieldDebug_ChangeTransportation
	dw FieldDebug_ChangeFieldTileset
	dw FieldDebug_ShowTownMap
	dw FieldDebug_CharacterViewer
	dw FieldDebug_NameEntry
	dw FieldDebug_InitToolGear
	dw FieldDebug_ClearSetEventFlags
	dw FieldDebug_RecoverPokemon
	dw FieldDebug_InitCableClub
	dw FieldDebug_NextFieldDebugMenuPage
	dw FieldDebug_NPCMovementTest
	dw FieldDebug_TogglePokemonFollowing
	dw FieldDebug_PlayerFollowNPCTest
	dw FieldDebug_Warp
	dw FieldDebug_FieldCutTest
	dw FieldDebug_CheckTile
	dw FieldDebug_MoveToEntrance
	dw FieldDebug_ToggleNPCMovement
	dw FieldDebug_InitMapViewer
	dw FieldDebug_ItemTest
	dw FieldDebug_AccessPC
	dw FieldDebug_AccessPokeMart
	dw FieldDebug_SetTeleportLocation
	dw FieldDebug_InitVRAMViewer
	dw FieldDebug_OpenPokeGear

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

FieldDebug_CloseFieldDebugMenu: ; 3F:415A
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

FieldDebug_NextFieldDebugMenuPage: ; 3F:4181
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

CloseFieldDebugMenuTextBoxLoop: ; 3F:41A1
	push bc
	ld b, a
.loop
	call GetJoypad
	ld a, [hJoyDown]
	and b
	jr z, .loop
	pop bc
	ret

ShowTextBoxAndExitFieldDebugMenu: ; 3F:41AD
	call MenuTextBox
	ld a, $03
	call CloseFieldDebugMenuTextBox
	call CloseWindow
	ret

FieldDebug_ChangeWindowBorder: ; 3F:41B9
	call ChangeWindowBorderMenu
	ld a, $00
	ret

FieldDebug_ResetPrompt: ; 3F:41BF
	call ResetPromptMenu
	ld a, $00
	ret

Unreferenced_ShowTrainerCard ; 3F:41C5
	ld hl, $5F25 ; 04:5F25 = Trainer Card display subroutine
	ld a, $04
	call FarCall_hl
	ld a, $00
	ret

FieldDebug_ChangeTransportation: ; 3F:41D0
	ld hl, ChangeTransportationMenuHeader
	call LoadMenuHeader
	ld a, [wPlayerState]
	call GetCurrentTransportation
	ld [wMenuCursorBuffer], a
	dec a
	call CopyNameFromMenu
	call VerticalMenu
	jp c, .exit
	ld a, [w2DMenuDataEnd]
	call SetCurrentTransportation
	ld hl, wPlayerState
	cp [hl]
	jr z, .exit
	cp $04
	jr z, .check_surf
	ld [wPlayerState], a
	and a
	jr z, .walking
.biking
.skateboard
	ld a, [w2DMenuDataEnd]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	call CloseWindow
	ld hl, TransportationPlayerString2
	call MenuTextBox
	jr .update_sprite
.walking
	ld a, $ff
	ld [wcc9a], a
	call CloseWindow
	call CloseWindow
	call PlayMapMusic
	ld hl, TransportationPlayerString1
	call MenuTextBox
.update_sprite
	ld hl, GetPlayerSprite
	ld a, $05
	call FarCall_hl
	ld a, $0f
	call CloseFieldDebugMenuTextBoxLoop
	call CloseWindow
	ld a, $03
	ret
.check_surf
	call CheckIfFacingSurfableTile
	jr c, .cannot_surf
	ld [wPlayerState], a
	call Function_fc2ee
	ld a, [w2DMenuDataEnd]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	call CloseWindow
	ld hl, TransportationPlayerString2
	call MenuTextBox
	jr .update_sprite
.cannot_surf
	ld hl, TransportationCannotSurfString
	call MenuTextBox
	ld a, $0f
	call CloseFieldDebugMenuTextBoxLoop
	call CloseWindow
.exit
	call CloseWindow
	ld a, $00
	ret

ChangeTransportationMenuHeader:: ; 3F:426F
	db MENU_BACKUP_TILES ; flags
	menu_coords 03, 03, SCREEN_WIDTH - 8, SCREEN_HEIGHT - 5
	dw .TransportationMenuData
	db 01 ; default option

.TransportationMenuData: ; 3F:4277
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 04 ; items
	db "あるき@"
	db "じてんしゃ@"
	db "スケボー@"
	db "ラプラス@"

TransportationPlayerString1: ; 3F:428D
	text "<PLAYER>は@"

TransportationPlayerString2: ; 3F:429D
	text "<PLAYER>は@"

TransportationCannotSurfString: ; 3F:42AC
	text "ここでは　のることが"
	next "できません"
	prompt

SetCurrentTransportation: ; 3F:42BE
	ld hl, TransportationOptions
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	ret

GetCurrentTransportation: ; 3F:42C8
	ld hl, TransportationOptions
	ld b, $01
.loop
	cp [hl]
	jr z, .return
	inc hl
	inc b
	jr .loop
.return
	ld a, b
	ret

WALKING    EQU 0
BICYCLE    EQU 1
SKATEBOARD EQU 2
SURFING    EQU 4

TransportationOptions: ; 3F:42D6
	db WALKING
	db BICYCLE
	db SKATEBOARD
	db SURFING

CheckIfFacingSurfableTile: ; 3F:42DA
	push af
	call GetFacingTileCoord
	and $f0
	cp $20
	jr z, .surfable
	cp $40
	jr z, .surfable
.not_surfable
	pop af
	scf
	ret
.surfable
	pop af
	and a
	ret

SetSurfDirection: ; 3F:42EE
	ld a, [wPlayerWalking]
	srl a
	srl a
	ld e, a
	ld d, $00
	ld hl, SurfDirectionOptions
	add hl, de
	ld a, [hl]
	ld [wcb77], a
	ret

DOWN  EQU 04
UP    EQU 05
LEFT  EQU 06
RIGHT EQU 07

SurfDirectionOptions: ; 3F:4301
	db DOWN
	db UP
	db LEFT
	db RIGHT

ChangeWindowBorderMenu: ; 3F:4305
	ld hl, ChangeWindowBorderMenuHeader
	call LoadMenuHeader
	ld a, [wActiveFrame]
	inc a
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	jr c, .close
	ld a, [wMenuCursorY]
	dec a
	ld [wActiveFrame], a
	push de
	ld de, SFX_MENU
	call PlaySFX
	pop de
	call LoadFontExtra
	call WaitBGMap
.close
	call CloseWindow
	ret

ChangeWindowBorderMenuHeader:: ; 3F:4330
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, SCREEN_WIDTH - 10, SCREEN_HEIGHT - 1
	dw .ChangeBorderMenuData
	db 01 ; default option

.ChangeBorderMenuData: ; 3F:4338
	db STATICMENU_CURSOR ; flags
	db 8 ; items
	db "１ばんめ@"
	db "２ばんめ@"
	db "３ばんめ@"
	db "４ばんめ@"
	db "５ばんめ@"
	db "６ばんめ@"
	db "７ばんめ@"
	db "８ばんめ@"

ResetPromptMenu: ; 3F:4362
	ld hl, .ResetPromptString
	call MenuTextBox
	call YesNoBox
	jp nc, Reset
	call CloseWindow
	ret

.ResetPromptString: ; 3F:4372
	text "ほんとにりセットしますか？"
	done

; 3F:4381