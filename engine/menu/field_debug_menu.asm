INCLUDE "constants.asm"

; FieldDebug_Jumptable constants
	const_def
	const FIELDDEBUG_RESET                   ; 0
	const FIELDDEBUG_CLOSE_MENU              ; 1
	const FIELDDEBUG_FRAME_TYPE              ; 2
	const FIELDDEBUG_MINIGAMES               ; 3
	const FIELDDEBUG_CHANGE_TRANSPORTATION   ; 4
	const FIELDDEBUG_CHANGE_TILESET          ; 5
	const FIELDDEBUG_TOWN_MAP                ; 6
	const FIELDDEBUG_SPRITE_VIEWER           ; 7
	const FIELDDEBUG_NAME_PLAYER             ; 8
	const FIELDDEBUG_TOOLGEAR                ; 9
	const FIELDDEBUG_CLEAR_EVENT_FLAGS       ; $a
	const FIELDDEBUG_HEAL_POKEMON            ; $b
	const FIELDDEBUG_CABLE_CLUB              ; $c
	const FIELDDEBUG_GO_TO_NEXT_PAGE         ; $d
	const FIELDDEBUG_NPC_MOVEMENT_TEST       ; $e
	const FIELDDEBUG_POKEMON_FOLLOWING       ; $f
	const FIELDDEBUG_FOLLOW_NPC_TEST         ; $10
	const FIELDDEBUG_WARP                    ; $11
	const FIELDDEBUG_FIELD_CUT               ; $12
	const FIELDDEBUG_CHECK_TILE              ; $13
	const FIELDDEBUG_MOVE_TO_ENTRANCE        ; $14
	const FIELDDEBUG_TOGGLE_NPC_MOVEMENT     ; $15
	const FIELDDEBUG_MAP_VIEWER              ; $16
	const FIELDDEBUG_ITEM_TEST               ; $17
	const FIELDDEBUG_PC_MENU                 ; $18
	const FIELDDEBUG_POKEMART_MENU           ; $19
	const FIELDDEBUG_TELEPORT                ; $1a
	const FIELDDEBUG_VRAM_VIEWER             ; $1b
	const FIELDDEBUG_TRAINER_GEAR            ; $1c

; FieldDebugMenu.ReturnJumptable constants
	const_def
	const FIELDDEBUG_RETURN_REOPEN  ; 0
	const FIELDDEBUG_RETURN_EXIT    ; 1
	const FIELDDEBUG_RETURN_CLOSE   ; 2
	const FIELDDEBUG_RETURN_CLEANUP ; 3
	const FIELDDEBUG_RETURN_RETURN  ; 4 XXX awkward name

FIELDDEBUG_NUM_PAGES equ 3

; GetActiveTransportation.TransportationList constants
; XXX move this to general transport constants
	const_def
	const       TRANSPORT_WALK       ; 0
	const_def 0
	shift_const TRANSPORT_BICYCLE    ; 1
	shift_const TRANSPORT_SKATEBOARD ; 2
	shift_const TRANSPORT_SURFING    ; 4

; FieldDebug_DoSpriteViewer.Jumptable constants
	const_def
	const FIELDDEBUG_SPRITEVIEWER_INIT_MENU             ; 0
	const FIELDDEBUG_SPRITEVIEWER_UPDATE_MENU           ; 1
	const FIELDDEBUG_SPRITEVIEWER_SHOW_SPRITES          ; 2
	const FIELDDEBUG_SPRITEVIEWER_SETUP_STATIC_SPRITE   ; 3
	const FIELDDEBUG_SPRITEVIEWER_SETUP_ANIMATED_SPRITE ; 4
	const FIELDDEBUG_SPRITEVIEWER_FOLLOW_PROMPT         ; 5
	const FIELDDEBUG_SPRITEVIEWER_EXIT                  ; 6
	const FIELDDEBUG_SPRITEVIEWER_SET_FOLLOWING         ; 7

SECTION "engine/menu/field_debug_menu.asm@FieldDebugMenuHeader", ROMX

FieldDebugMenuHeader:
	db $40
	db $0
	db $0
	db $11
	db $7
	dw .MenuData
	db $1

.MenuData:
	db $ac
	db $0
	dw FieldDebug_Pages
	dw PlaceMenuStrings
	dw .Strings

.Strings:
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
	db "イべント@"
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

FieldDebug_Jumptable:
	dw FieldDebug_Reset
	dw FieldDebug_CloseMenu
	dw FieldDebug_FrameType
	dw FieldDebug_Minigames
	dw FieldDebug_ChangeTransportation
	dw FieldDebug_ChangeTileset
	dw FieldDebug_TownMap
	dw FieldDebug_SpriteViewer
	dw FieldDebug_NamePlayer
	dw FieldDebug_Toolgear
	dw FieldDebug_ClearEventFlags
	dw FieldDebug_HealPokemon
	dw FieldDebug_CableClub
	dw FieldDebug_GoToNextPage
	dw FieldDebug_NPCMovementTest
	dw FieldDebug_PokemonFollowing
	dw FieldDebug_FollowNPCTest
	dw FieldDebug_Warp
	dw FieldDebug_FieldCut
	dw FieldDebug_CheckTile
	dw FieldDebug_MoveToEntrance
	dw FieldDebug_ToggleNPCMovement
	dw FieldDebug_MapViewer
	dw FieldDebug_ItemTest
	dw FieldDebug_PCMenu
	dw FieldDebug_PokemartMenu
	dw FieldDebug_Teleport
	dw FieldDebug_VRAMViewer
	dw FieldDebug_TrainerGear

FieldDebug_Pages:
	db 7    ; number of items
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_WARP
	db FIELDDEBUG_SPRITE_VIEWER
	db FIELDDEBUG_CHANGE_TRANSPORTATION
	db FIELDDEBUG_TOOLGEAR
	db FIELDDEBUG_PC_MENU
	db FIELDDEBUG_CLOSE_MENU
	db -1

FieldDebug_Page2:
	db 7
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_POKEMART_MENU
	db FIELDDEBUG_HEAL_POKEMON
	db FIELDDEBUG_TRAINER_GEAR
	db FIELDDEBUG_MINIGAMES
	db FIELDDEBUG_MAP_VIEWER
	db FIELDDEBUG_CLOSE_MENU
	db -1

FieldDebug_Page3:
	db 7
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_CLEAR_EVENT_FLAGS
	db FIELDDEBUG_VRAM_VIEWER
	db FIELDDEBUG_TELEPORT
	db FIELDDEBUG_FOLLOW_NPC_TEST
	db FIELDDEBUG_TOWN_MAP
	db FIELDDEBUG_CLOSE_MENU
	db -1

FieldDebugMenu:
	call RefreshScreen
	ld de, SFX_MENU
	call PlaySFX
	ld hl, FieldDebugMenuHeader
	call LoadMenuHeader

; load first page
	ld a, 0
	ld [wFieldDebugPage], a

.Reopen:
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
	jr z, .DoJumptable

	call FieldDebug_ChangePage
	jr .DoReturn

.DoJumptable:
	ld a, [wMenuSelection]
	ld hl, FieldDebug_Jumptable
	call CallJumptable

.DoReturn:
	ld hl, .ReturnJumptable
	jp CallJumptable

.ReturnJumptable:
	dw .Reopen
	dw .Exit
	dw .Close
	dw .Cleanup
	dw .Return

.Exit:
	call GetJoypad
	ldh a, [hJoyDown]
	bit A_BUTTON_F, a
	jr nz, .Exit
	call LoadFontExtra

.Close:
	call CloseWindow

.Cleanup:
	push af
	call Function1fea
	pop af
	ret

.Return:
	call ExitMenu
	ld a, -1
	ldh [hStartmenuCloseAndSelectHookEnable], a
	jr .Cleanup

FieldDebug_CloseMenu:
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

FieldDebug_ChangePage:
	ld a, [wMenuJoypad]
	cp D_LEFT
	jr z, .previous
	ld a, [wFieldDebugPage]
	inc a
	cp FIELDDEBUG_NUM_PAGES
	jr nz, .next
	xor a

.next
	ld [wFieldDebugPage], a
	jr FieldDebug_PlayMenuSound

.previous
	ld a, [wFieldDebugPage]
	dec a
	cp -1
	jr nz, .load_previous
	ld a, FIELDDEBUG_NUM_PAGES - 1

.load_previous
	ld [wFieldDebugPage], a
	jr FieldDebug_PlayMenuSound

FieldDebug_GoToNextPage:
	ld a, [wFieldDebugPage]
	and a
	jr z, .page_1
	xor a
	jr .load_page

.page_1
	ld a, 1

.load_page
	ld [wFieldDebugPage], a

FieldDebug_PlayMenuSound:
	ld de, SFX_MENU
	call PlaySFX
.loop
	call GetJoypad
	ldh a, [hJoyDown]
	bit A_BUTTON_F, a
	jr nz, .loop
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_WaitJoypadInput:
	push bc
	ld b, a
.loop
	call GetJoypad
	ldh a, [hJoyDown]
	and b
	jr z, .loop
	pop bc
	ret

FieldDebug_ShowTextboxAndExit:
	call MenuTextBox
	ld a, A_BUTTON | B_BUTTON
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ret

FieldDebug_FrameType:
	call FrameTypeDialog
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_Reset:
	call DisplayResetDialog
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_ShowTrainerCard: ; unreferenced?
	callab _TrainerCard
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_ChangeTransportation:
	ld hl, ChangeTransportationMenuHeader
	call LoadMenuHeader
	ld a, [wPlayerState]
	call GetActiveTransportation
	ld [wMenuCursorBuffer], a
	dec a
	call CopyNameFromMenu
	call VerticalMenu
	jp c, .exit
	ld a, [wMenuCursorY]
	call FieldDebug_SetTransportation
	ld hl, wPlayerState
	cp [hl]
	jr z, .exit
	cp 4
	jr z, .check_surf
	ld [wPlayerState], a
	and a
	jr z, .walking
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	call CloseWindow
	ld hl, PlayerTransportationString2
	call MenuTextBox
	jr .update_sprite

.walking:
	ld a, $ff
	ld [wSkatingDirection], a
	call CloseWindow
	call CloseWindow
	call PlayMapMusic
	ld hl, PlayerTransportationString1
	call MenuTextBox

.update_sprite:
	ld hl, GetPlayerSprite
	ld a, 5
	call FarCall_hl
	ld a, $f
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ld a, 3
	ret

.check_surf:
	call FieldDebug_CheckFacingSurfable
	jr c, .cannot_surf
	ld [wPlayerState], a
	call FieldDebug_SetSurfDirection
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	call CloseWindow
	ld hl, PlayerTransportationString2
	call MenuTextBox
	jr .update_sprite

.cannot_surf:
	ld hl, CannotSurfString
	call MenuTextBox
	ld a, $f
	call FieldDebug_WaitJoypadInput
	call CloseWindow

.exit:
	call CloseWindow
	ld a, 0
	ret

ChangeTransportationMenuHeader:
	db $40
	db $3
	db $3
	db $d
	db $c
	dw Datafc277
	db $1

Datafc277:
	db $a0
	db $4
	db $b1
	db $d9
	db $b7
	db $50
	db $2c
	db $c3
	db $de
	db $bc
	db $e0
	db $50
	db $8c
	db $88
	db $1c
	db $e3
	db $50
	db $a5
	db $42
	db $a5
	db $8c
	db $50

PlayerTransportationString1:
	db $0
	db $52
	db $ca
	db $50
	db $5
	db $1
	db $31
	db $cd
	db $0
	db $b6
	db $d7
	db $7f
	db $b5
	db $d8
	db $c0
	db $58

PlayerTransportationString2:
	db $0
	db $52
	db $ca
	db $50
	db $5
	db $1
	db $31
	db $cd
	db $0
	db $c6
	db $7f
	db $c9
	db $df
	db $c0
	db $58

CannotSurfString:
	db $0
	db $ba
	db $ba
	db $33
	db $ca
	db $7f
	db $c9
	db $d9
	db $ba
	db $c4
	db $26
	db $4e
	db $33
	db $b7
	db $cf
	db $be
	db $de
	db $58

FieldDebug_SetTransportation:
	ld hl, TransportationList
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ret

GetActiveTransportation:
	ld hl, TransportationList
	ld b, 1
.loop
	cp [hl]
	jr z, .got_transportation
	inc hl
	inc b
	jr .loop
.got_transportation
	ld a, b
	ret

TransportationList:
	db TRANSPORT_WALK
	db TRANSPORT_BICYCLE
	db TRANSPORT_SKATEBOARD
	db TRANSPORT_SURFING

FieldDebug_CheckFacingSurfable:
	push af
	call GetFacingTileCoord
	and $f0

	cp $20
	jr z, .surfable

	cp $40
	jr z, .surfable

; not surfable
	pop af
	scf
	ret

.surfable
	pop af
	and a
	ret

FieldDebug_SetSurfDirection:
	ld a, [wPlayerWalking]
	srl a
	srl a
	ld e, a
	ld d, 0
	ld hl, .Directions
	add hl, de
	ld a, [hl]
	ld [wPlayerMovement], a
	ret

.Directions:
	db $04 ; XXX SLOW_STEP_DOWN?
	db $05 ; XXX SLOW_STEP_UP?
	db $06 ; XXX SLOW_STEP_LEFT?
	db $07 ; XXX SLOW_STEP_RIGHT?

SECTION "engine/menu/field_debug_menu.asm@FieldDebug_ChangeTileset", ROMX

FieldDebug_ChangeTileset:
	ld hl, .MenuHeader
	call LoadMenuHeader
	ld a, [wMapTileset]
	inc a
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	call CloseWindow
	jr c, .reopen
	ld a, [wMapTileset]
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	cp b
	jr z, .reopen
	ld [wMapTileset], a
	call LoadTileset
	call LoadTilesetGFX
	jr FieldDebug_ChangeTileset

.reopen:
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.MenuHeader:
	db $40
	db $0
	db $0
	db $a
	db $8
	dw Datafc3b7
	db $1

Datafc3b7:
	db $80
	db $3
	db "セル１@"
	db "セル２@"
	db "セル３@"

FieldDebug_TownMap:
	call LoadStandardMenuHeader
	call ClearSprites
	callab FlyMap
	call ClearPalettes
	call Function3657
	call LoadFontExtra
	call CloseWindow
	call GetMemSGBLayout
	call SetPalettes
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_SpriteViewer:
	call LoadStandardMenuHeader
	call ClearTileMap
	call HideSprites
	ld hl, wVramState
	res 0, [hl]
	call Functionfc410
	call FieldDebug_DoSpriteViewer
	push af
	ld hl, wVramState
	set 0, [hl]
	call ClearPalettes
	call Function360b
	call CloseWindow
	call UpdateTimePals
	pop af
	ret

Functionfc410:
	ld a, $5b
	ld [wMovementBufferObject], a
	ld a, 1
	ld [wSpriteViewerSavedMenuPointerY], a
	ld a, 0
	ld [wSpriteViewerMenuStartingItem], a
	ld a, 1
	ldh [hTextBoxCursorBlinkInterval], a
	callab Function77ad
	ret nc
	ldh a, [hEventID]
	call GetObjectStruct
	ld hl, 0
	add hl, bc
	ld a, [wMovementBufferObject]
	ld d, a
	ld a, 5
	add [hl]
	cp d
	jr c, Functionfc44c
	sub d
	ld [wSpriteViewerSavedMenuPointerY], a
	ld a, [wMovementBufferObject]
	sub 5
	ld [wSpriteViewerMenuStartingItem], a
	ret

Functionfc44c:
	ld a, 1
	ld [wSpriteViewerSavedMenuPointerY], a
	ld a, [hl]
	ld [wSpriteViewerMenuStartingItem], a
	ret

Functionfc456:
	ld de, Datafc46f
	call SetMenuAttributes
	ld a, [wMovementBufferObject]
	cp 5
	jr c, Functionfc465
	ld a, 5

Functionfc465:
	ld [w2DMenuNumRows], a
	ld a, [wSpriteViewerSavedMenuPointerY]
	ld [wMenuCursorY], a
	ret

Datafc46f:
	db $03
	db $01
	db $00
	db $01
	db $0f
	db $00
	db $30
	db $03

FieldDebug_DoSpriteViewer:
	ld a, 0
	ld [wSpriteViewerJumptableIndex], a

.loop
	ld a, [wSpriteViewerJumptableIndex]
	ld hl, .Jumptable
	call CallJumptable
	jr nc, .loop
	ret

.Jumptable:
	dw FieldDebug_DoSpriteViewer_InitMenu
	dw FieldDebug_DoSpriteViewer_UpdateMenu
	dw FieldDebug_DoSpriteViewer_ShowSprites
	dw FieldDebug_DoSpriteViewer_SetupStaticSprite
	dw FieldDebug_DoSpriteViewer_SetupAnimatedSprite
	dw FieldDebug_DoSpriteViewer_FollowPrompt
	dw FieldDebug_DoSpriteViewer_Exit
	dw FieldDebug_DoSpriteViewer_SetFollowing

FieldDebug_DoSpriteViewer_Exit:
	ld a, -1
	ld [wSpriteViewerJumptableIndex], a
	scf
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_DoSpriteViewer_SetFollowing:
	ld hl, Function8031
	ld a, BANK(Function8031)
	call QueueScript

; Exits immediately after setting sprite to follow the player
	ld a, -1
	ld [wSpriteViewerJumptableIndex], a
	scf
	ld a, FIELDDEBUG_RETURN_RETURN
	ret

FieldDebug_DoSpriteViewer_InitMenu:
	xor a
	ldh [hBGMapMode], a
	call HideSprites
	call ClearPalettes
	call ClearTileMap
	call Functionfc456
	call FieldDebug_DoSpriteViewer_DisplayMenu
	call SetPalettes
	call WaitBGMap
	ld a, FIELDDEBUG_SPRITEVIEWER_UPDATE_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

FieldDebug_DoSpriteViewer_DisplayMenu:
	ld c, 5
	ld a, [wMovementBufferObject]
	cp c
	jr nc, .setup
	ld c, a

.setup:
	hlcoord 5, 4
	ld a, [wSpriteViewerMenuStartingItem]
	inc a
	ld [wStringBuffer1], a

.display_loop:
	push bc
	push hl
	ld bc, $8103
	ld de, wStringBuffer1
	call PrintNumber
	ld a, [wStringBuffer1]
	call LoadUnderDevelopmentString
	call PlaceString
	ld hl, wStringBuffer1
	inc [hl]
	pop hl
	ld de, SCREEN_WIDTH * 3
	add hl, de
	pop bc
	dec c
	jr nz, .display_loop
	ret

FieldDebug_DoSpriteViewer_UpdateMenu:
	call Functionfc456

.loop
	call Get2DMenuJoypad
	ld a, [wMenuCursorY]
	ld [wSpriteViewerSavedMenuPointerY], a
	ldh a, [hJoySum]
	bit A_BUTTON_F, a
	jp nz, .a_button
	bit B_BUTTON_F, a
	jp nz, .b_button
	bit D_DOWN_F, a
	jr nz, .down
	bit D_UP_F, a
	jr nz, .up
	bit D_LEFT_F, a
	jr nz, .left
	bit D_RIGHT_F, a
	jr nz, .right
	jr .loop

.a_button
	ld a, FIELDDEBUG_SPRITEVIEWER_SHOW_SPRITES
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.b_button
	ld a, FIELDDEBUG_SPRITEVIEWER_EXIT
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.up
	ld a, [wSpriteViewerMenuStartingItem]
	and a
	jr z, .reload_menu
	dec a
	ld [wSpriteViewerMenuStartingItem], a
	jr .reload_menu

.down
	ld a, [wMovementBufferObject]
	cp 5
	jr c, .reload_menu
	sub 5
	ld b, a
	ld a, [wSpriteViewerMenuStartingItem]
	cp b
	jr z, .reload_menu
	inc a
	ld [wSpriteViewerMenuStartingItem], a
	jr .reload_menu

.right
	ld a, [wMovementBufferObject]
	cp 5
	jr c, .reload_menu
	sub 4
	ld b, a
	ld a, [wSpriteViewerMenuStartingItem]
	add 5
	ld [wSpriteViewerMenuStartingItem], a
	cp b
	jr c, .reload_menu
	dec b
	ld a, b
	ld [wSpriteViewerMenuStartingItem], a
	jr .reload_menu

.left
	ld a, [wSpriteViewerMenuStartingItem]
	sub 5
	ld [wSpriteViewerMenuStartingItem], a
	jr nc, .reload_menu
	xor a
	ld [wSpriteViewerMenuStartingItem], a
	jr .reload_menu

.reload_menu
	ld a, FIELDDEBUG_SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

FieldDebug_DoSpriteViewer_ShowSprites:
	call ClearTileMap
	call FieldDebug_DoSpriteViewer_SetStartingPoint
	call LoadUnderDevelopmentString
	hlcoord 1, 2
	call PlaceString
	call FieldDebug_DoSpriteViewer_SetStartingPoint
	ld c, a
	callab Function14144
	ld hl, $80c0
	ld de, $8800
	ld bc, $c
	call Get2bpp
	call LoadFont
	call FieldDebug_DoSpriteViewer_SetStartingPoint
	call IsAnimatedSprite
	jr c, .animated_sprite

; static sprite
	ld a, FIELDDEBUG_SPRITEVIEWER_SETUP_STATIC_SPRITE
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.animated_sprite
	ld a, FIELDDEBUG_SPRITEVIEWER_SETUP_ANIMATED_SPRITE
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

FieldDebug_DoSpriteViewer_SetupAnimatedSprite:
	ld a, $10
	ld [wMovementBuffer], a
	ld a, $20
	ld [wMovementBuffer + 1], a
	ld hl, Datafc6de
	ld de, wVirtualOAM
	call Functionfc6bb
	ld a, A_BUTTON | B_BUTTON
	call FieldDebug_WaitJoypadInput
	ld a, FIELDDEBUG_SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

FieldDebug_DoSpriteViewer_SetupStaticSprite:
	xor a
	ld [wMovementBuffer + 2], a

FieldDebug_DoSpriteViewer_SpriteLoop:
	ld a, $10
	ld [wMovementBuffer], a
	ld a, $20
	ld [wMovementBuffer + 1], a
	call Functionfc689
	call .animate_walking
	bit 1, a
	jr nz, .return_to_menu
	bit 0, a
	jr nz, .show_follow_prompt
	ld a, [wMovementBuffer + 2]
	inc a
	and 3
	ld [wMovementBuffer + 2], a
	ldh a, [hJoyState]
	and $f0
	jr nz, FieldDebug_DoSpriteViewer_SpriteLoop
	xor a
	ld [wMovementBuffer + 2], a
	jr FieldDebug_DoSpriteViewer_SpriteLoop

.return_to_menu
	ld a, FIELDDEBUG_SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a ; FIELDDEBUG_RETURN_REOPEN
	ret

.show_follow_prompt
	ld a, FIELDDEBUG_SPRITEVIEWER_FOLLOW_PROMPT
	ld [wSpriteViewerJumptableIndex], a
	xor a ; FIELDDEBUG_RETURN_REOPEN
	ret

.animate_walking
	ld c, 10
.animate_loop
	call DelayFrame
	call GetJoypad
	ldh a, [hJoyDown]
	and 3
	ret nz
	dec c
	jr nz, .animate_loop
	ret

FieldDebug_DoSpriteViewer_FollowPrompt:
	ld hl, .FollowPromptString
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr nc, .set_following

; return to menu
	ld a, FIELDDEBUG_SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.set_following
	call FieldDebug_DoSpriteViewer_SetStartingPoint
	ld [wd646], a
	ld a, FIELDDEBUG_SPRITEVIEWER_SET_FOLLOWING
	ld [wSpriteViewerJumptableIndex], a
	ret

.FollowPromptString:
	text "これを　せんたくしますか？"
	done

FieldDebug_DoSpriteViewer_SetStartingPoint:
	push bc
	ld a, [wSpriteViewerMenuStartingItem]
	ld b, a
	ld a, [wSpriteViewerSavedMenuPointerY]
	add b
	pop bc
	ret

LoadUnderDevelopmentString:
	ld de, .String
	ret

.String:
	db "かいはつちゅう@"

Functionfc689:
	ld de, wVirtualOAM
	ld hl, Datafc6de
	ld a, [wMovementBuffer + 2]
	and 3
	ld bc, 2
	call AddNTimes
	ld c, 4

Functionfc69c:
	push bc
	push hl
	push de
	call Functionfc6bb
	ld a, [wMovementBuffer]
	add $20
	ld [wMovementBuffer], a
	pop hl
	ld bc, $10
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, 8
	add hl, bc
	pop bc
	dec c
	jr nz, Functionfc69c
	ret

Functionfc6bb:
	ld a, [hli]
	ld h, [hl]
	ld l, a

Functionfc6be:
	ld a, [wMovementBuffer + 1]
	add $10
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, [wMovementBuffer]
	add 8
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	and $f0
	ld [de], a
	inc de
	ld a, [hli]
	bit 0, a
	jr z, Functionfc6be
	ret

Datafc6de:
	dw Datafc6fe
	dw Datafc70e
	dw Datafc6fe
	dw Datafc71e
	dw Datafc72e
	dw Datafc73e
	dw Datafc72e
	dw Datafc74e
	dw Datafc75e
	dw Datafc77e
	dw Datafc75e
	dw Datafc77e
	dw Datafc76e
	dw Datafc78e
	dw Datafc76e
	dw Datafc78e

Datafc6fe:
	db $0
	db $0
	db $0
	db $0
	db $0
	db $8
	db $1
	db $0
	db $8
	db $0
	db $2
	db $2
	db $8
	db $8
	db $3
	db $3

Datafc70e:
	db $0
	db $0
	db $c
	db $0
	db $0
	db $8
	db $d
	db $0
	db $8
	db $0
	db $e
	db $2
	db $8
	db $8
	db $f
	db $3

Datafc71e:
	db $0
	db $8
	db $c
	db $20
	db $0
	db $0
	db $d
	db $20
	db $8
	db $8
	db $e
	db $22
	db $8
	db $0
	db $f
	db $23

Datafc72e:
	db $0
	db $0
	db $4
	db $0
	db $0
	db $8
	db $5
	db $0
	db $8
	db $0
	db $6
	db $2
	db $8
	db $8
	db $7
	db $3

Datafc73e:
	db $0
	db $0
	db $10
	db $0
	db $0
	db $8
	db $11
	db $0
	db $8
	db $0
	db $12
	db $2
	db $8
	db $8
	db $13
	db $3

Datafc74e:
	db $0
	db $8
	db $10
	db $20
	db $0
	db $0
	db $11
	db $20
	db $8
	db $8
	db $12
	db $22
	db $8
	db $0
	db $13
	db $23

Datafc75e:
	db $0
	db $0
	db $8
	db $0
	db $0
	db $8
	db $9
	db $0
	db $8
	db $0
	db $a
	db $2
	db $8
	db $8
	db $b
	db $3

Datafc76e:
	db $0
	db $8
	db $8
	db $20
	db $0
	db $0
	db $9
	db $20
	db $8
	db $8
	db $a
	db $22
	db $8
	db $0
	db $b
	db $23

Datafc77e:
	db $0
	db $0
	db $14
	db $0
	db $0
	db $8
	db $15
	db $0
	db $8
	db $0
	db $16
	db $2
	db $8
	db $8
	db $17
	db $3

Datafc78e:
	db $0
	db $8
	db $14
	db $20
	db $0
	db $0
	db $15
	db $20
	db $8
	db $8
	db $16
	db $22
	db $8
	db $0
	db $17
	db $23

FieldDebug_NamePlayer:
	call LoadStandardMenuHeader
	ld de, wPlayerName
	ld b, 1
	callab NamingScreen
	call ClearBGPalettes
	call ClearTileMap
	call CloseWindow
	call ClearSprites
	call GetMemSGBLayout
	call SetPalettes
	ld hl, wce5f
	res 4, [hl]
	call LoadFontExtra
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_Toolgear:
	call Functionfc828
	jr c, Functionfc7e6
	ld a, [wMenuCursorY]
	dec a
	ld hl, Datafc7da
	jp CallJumptable


Datafc7da:
	dw Functionfc80d
	dw Functionfc819
	dw Functionfc7f7
	dw Functionfc7e9
	dw Functionfc7f0
	dw Functionfc813

Functionfc7e6:
	ld a, 0
	ret

Functionfc7e9:
	ld hl, wd153
	set 7, [hl]
	jr Functionfc7ff

Functionfc7f0:
	ld hl, wd153
	res 7, [hl]
	jr Functionfc7ff

Functionfc7f7:
	callab SetTime

Functionfc7ff:
	callab Function8c325
	call UpdateTimePals
	ld a, 2
	ret

Functionfc80d:
	call EnableToolgear
	ld a, 2
	ret

Functionfc813:
	call DisableToolgear
	ld a, 2
	ret

Functionfc819:
	call Functionfc81f
	ld a, 2
	ret

Functionfc81f:
	call EnableToolgear
	ld hl, wd153
	set 0, [hl]
	ret

Functionfc828:
	ld hl, Datafc84e
	call LoadMenuHeader
	call Functionfc83b
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	call CloseWindow
	ret

Functionfc83b:
	ld a, [wd14f]
	bit 0, a
	ld a, 3
	ret nz
	ld hl, wd153
	bit 0, [hl]
	ld a, 1
	ret nz
	ld a, 2
	ret

Datafc84e:
	db $40
	db $0
	db $0
	db $e
	db $7
	dw Datafc856
	db $1

Datafc856:
	db $80
	db $6
	db "とけい@"
	db "ざひょう@"
	db "アジャスト@"
	db "６０びょう@"
	db "２４じかん@"
	db "けす@"

FieldDebug_HealPokemon:
	ld a, 6
	call Predef
	ld hl, .HealedText
	call MenuTextBoxBackup
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.HealedText:
	text "#の　たいりょくを"
	line "かいふくしました"
	prompt

FieldDebug_CableClub:
	callab Function29abf
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_NPCMovementTest:
	call Functionfc8ae
	jr c, Functionfc8ab
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

Functionfc8ab:
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

Functionfc8ae:
	ld a, [wMapGroup]
	cp 1
	jr nz, Functionfc8dd
	ld a, [wMapId]
	cp $b
	jr nz, Functionfc8dd
	ld a, 2
	ld hl, Datafc8cc
	call LoadMovementDataPointer
	ld de, SFX_22
	call PlaySFX
	scf
	ret

Datafc8cc:
	db FACE_UP
	db MOVEMENT_2F
	db SLOW_STEP_UP
	db SLOW_STEP_RIGHT
	db SLOW_JUMP_RIGHT
	db SLOW_STEP_RIGHT
	db STEP_DOWN
	db STEP_DOWN
	db STEP_DOWN
	db STEP_DOWN
	db STEP_LEFT
	db SLOW_JUMP_LEFT
	db STEP_LEFT
	db SLOW_STEP_UP
	db SLOW_STEP_UP
	db SLOW_STEP_UP
	db MOVEMENT_32

Functionfc8dd:
	ld de, SFX_1E
	call PlaySFX
	ld hl, Datafc8eb
	call FieldDebug_ShowTextboxAndExit
	xor a
	ret

Datafc8eb:
	text "ここではだめです！"
	done

FieldDebug_PokemonFollowing:
	call Functionfc901
	jr c, Functionfc8fe
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

Functionfc8fe:
	ld a, FIELDDEBUG_RETURN_CLEANUP
	ret

Functionfc901:
	ld hl, Datafc94d
	call LoadMenuHeader
	call VerticalMenu
	jr c, Functionfc945
	ld a, [wMenuCursorY]
	cp 1
	jr nz, Functionfc92f
	ld a, [wPlayerStructEnd]
	and a
	jr nz, Functionfc93f
	callab Function8031
	ld de, SFX_24
	call PlaySFX
	call CloseWindow
	call UpdateSprites
	scf
	ret

Functionfc92f:
	callab Function806c
	ld de, SFX_25
	call PlaySFX
	jr Functionfc945

Functionfc93f:
	ld hl, Datafc95f
	call FieldDebug_ShowTextboxAndExit

Functionfc945:
	call CloseWindow
	call UpdateSprites
	xor a
	ret

Datafc94d:
	db $40
	db $3
	db $3
	db $9
	db $9
	dw Datafc955
	db $1

Datafc955:
	db $80
	db $2
	db "つける@"
	db "はずす@"

Datafc95f:
	text "だめです！！"
	done

FieldDebug_FollowNPCTest:
	call Functionfc972
	jr c, Functionfc96f
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

Functionfc96f:
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

Functionfc972:
	ld hl, Datafc9cb
	call LoadMenuHeader
	call VerticalMenu
	jr c, Functionfc9a0
	ld a, [wMenuCursorY]
	cp 1
	jr nz, Functionfc992
	ld a, [wObjectFollow_Follower]
	and a
	jr nz, Functionfc997
	call Functionfc9a5
	call CloseWindow
	scf
	ret

Functionfc992:
	call Functionfc9c2
	jr Functionfc9a0

Functionfc997:
	ld hl, Datafc9de
	call MenuTextBox
	call CloseWindow

Functionfc9a0:
	call CloseWindow
	and a
	ret

Functionfc9a5:
	callab Function8047
	ld a, 1
	call Function15ed
	ld a, 1
	ld hl, Datafc9f3
	call LoadMovementDataPointer
	ld b, 1
	ld c, 0
	call StartFollow
	ret

Functionfc9c2:
	call Function18cc
	ld a, 1
	call Function169f
	ret

Datafc9cb:
	db $40
	db $3
	db $3
	db $9
	db $9
	dw Datafc9d3
	db $1

Datafc9d3:
	db $80
	db $2
	db "はじめる@"
	db "おわる@"

Datafc9de:
	text "ポケモンを　つれているときは"
	next "だめです"
	prompt

Datafc9f3:
	db FACE_UP
	db SLOW_STEP_UP
	db STEP_UP
	db STEP_RIGHT
	db FAST_STEP_RIGHT
	db JUMP_DOWN
	db FAST_STEP_DOWN
	db FAST_STEP_DOWN
	db STEP_DOWN
	db STEP_LEFT
	db STEP_LEFT
	db JUMP_UP
	db SLOW_STEP_UP
	db MOVEMENT_33

Datafca01:
	db $40
	db $0
	db $0
	db $a
	db $b
	dw Datafca09
	db $1

Datafca09:
	db $a0
	db $4
	db "ポケモンつれあるき@"
	db "つれあるかれデモ@"
	db "ライバルおねえさん@"
	db "さくせいちゅう@"

FieldDebug_Warp:
	call DebugMenu_DisplayWarpSubmenu
	jr nc, .do_warp
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.do_warp:
	ld a, [wMenuSelection]
	ld [wDefaultSpawnPoint], a
	ld hl, wVramState
	set 6, [hl]
	ldh a, [hROMBank]
	ld hl, Functionfcbf4
	call QueueScript
	ld de, SFX_22
	call PlaySFX
	call DelayFrame
	ld a, FIELDDEBUG_RETURN_RETURN
	ret

