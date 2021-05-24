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
	const FIELDDEBUG_RETURN_REOPEN     ; 0
	const FIELDDEBUG_RETURN_WAIT_INPUT ; 1
	const FIELDDEBUG_RETURN_CLOSE      ; 2
	const FIELDDEBUG_RETURN_CLEANUP    ; 3
	const FIELDDEBUG_RETURN_EXIT       ; 4

FIELDDEBUG_NUM_PAGES equ 3

; .DoSpriteViewer.Jumptable constants
	const_def
	const SPRITEVIEWER_INIT_MENU             ; 0
	const SPRITEVIEWER_UPDATE_MENU           ; 1
	const SPRITEVIEWER_SHOW_SPRITES          ; 2
	const SPRITEVIEWER_SETUP_STATIC_SPRITE   ; 3
	const SPRITEVIEWER_SETUP_ANIMATED_SPRITE ; 4
	const SPRITEVIEWER_FOLLOW_PROMPT         ; 5
	const SPRITEVIEWER_EXIT                  ; 6
	const SPRITEVIEWER_SET_FOLLOWING         ; 7

; DebugMapViewer.Jumptable constants
	const_def
	const DEBUGMAPVIEWER_EMPTY                 ; 0
	const DEBUGMAPVIEWER_INIT                  ; 1
	const DEBUGMAPVIEWER_CONTROL_CURSOR        ; 2
	const DEBUGMAPVIEWER_MOVE_CURSOR_TO_PLAYER ; 3
	const DEBUGMAPVIEWER_WAIT_FINISHED_MOVING  ; 4
	const DEBUGMAPVIEWER_CLEANUP               ; 5

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
	dw FieldDebug_OpenMapViewer
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

.Page2:
	db 7
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_POKEMART_MENU
	db FIELDDEBUG_HEAL_POKEMON
	db FIELDDEBUG_TRAINER_GEAR
	db FIELDDEBUG_MINIGAMES
	db FIELDDEBUG_MAP_VIEWER
	db FIELDDEBUG_CLOSE_MENU
	db -1

.Page3:
	db 7
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_CLEAR_EVENT_FLAGS
	db FIELDDEBUG_VRAM_VIEWER
	db FIELDDEBUG_TELEPORT
	db FIELDDEBUG_FOLLOW_NPC_TEST
	db FIELDDEBUG_TOWN_MAP
	db FIELDDEBUG_CLOSE_MENU
	db -1

FieldDebugMenu::
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
	jr c, .WaitInput
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
	dw .WaitInput
	dw .Close
	dw .Cleanup
	dw .Exit

.WaitInput:
	call GetJoypad
	ldh a, [hJoyDown]
	bit A_BUTTON_F, a
	jr nz, .WaitInput
	call LoadFontExtra

.Close:
	call CloseWindow

.Cleanup:
	push af
	call Function1fea
	pop af
	ret

.Exit:
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
; This will only scroll between the first two pages
; instead of the available three.
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
	ld hl, .ChangeTransportationMenuHeader
	call LoadMenuHeader
	ld a, [wPlayerState]
	call GetActiveTransportation
	ld [wMenuCursorBuffer], a
	dec a
	call CopyNameFromMenu
	call VerticalMenu
	jp c, .exit
	ld a, [wMenuCursorY]
	call SetTransportation
	ld hl, wPlayerState
	cp [hl]
	jr z, .exit
	cp PLAYER_SURF
	jr z, .check_surf
	ld [wPlayerState], a
	and a
	jr z, .walking
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	call CloseWindow
	ld hl, .PlayerTransportationString2
	call MenuTextBox
	jr .update_sprite

.walking
	ld a, -1
	ld [wSkatingDirection], a
	call CloseWindow
	call CloseWindow
	call PlayMapMusic
	ld hl, .PlayerTransportationString1
	call MenuTextBox

.update_sprite
	callab GetPlayerSprite
	ld a, BUTTONS
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ld a, FIELDDEBUG_RETURN_CLEANUP
	ret

.check_surf
	call FieldDebug_CheckFacingSurfable
	jr c, .cannot_surf
	ld [wPlayerState], a
	call FieldDebug_SetSurfDirection
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	call CloseWindow
	ld hl, .PlayerTransportationString2
	call MenuTextBox
	jr .update_sprite

.cannot_surf
	ld hl, .CannotSurfString
	call MenuTextBox
	ld a, BUTTONS
	call FieldDebug_WaitJoypadInput
	call CloseWindow

.exit
	call CloseWindow
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.ChangeTransportationMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 3, 3, 12, 13
	dw .ChangeTransportationMenuData
	db 1

.ChangeTransportationMenuData:
	db STATICMENU_WRAP | STATICMENU_CURSOR
	db 4
	db "あるき@"
	db "じてんしゃ@"
	db "スケボー@"
	db "ラプラス@"

.PlayerTransportationString1:
	text "<PLAYER>は@"
	text_low
	text_from_ram wStringBuffer2
	text "から　おりた"
	prompt

.PlayerTransportationString2:
	text "<PLAYER>は@"
	text_low
	text_from_ram wStringBuffer2
	text "に　のった"
	prompt

.CannotSurfString:
	text "ここでは　のることが"
	next "できません"
	prompt

SetTransportation:
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
	db PLAYER_NORMAL
	db PLAYER_BIKE
	db PLAYER_SKATE
	db PLAYER_SURF

FieldDebug_CheckFacingSurfable:
	push af
	call GetFacingTileCoord
	and COLLISION_TYPE_MASK
	cp OLD_COLLISION_TYPE_WATER ; happens to match COLLISION_TYPE_WATER
	jr z, .surfable
	cp OLD_COLLISION_TYPE_WATER2
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
	db SLOW_STEP_DOWN
	db SLOW_STEP_UP
	db SLOW_STEP_LEFT
	db SLOW_STEP_RIGHT

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
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 8, 10
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 3
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
	call .Init
	call .DoSpriteViewer
	push af
	ld hl, wVramState
	set 0, [hl]
	call ClearPalettes
	call Function360b
	call CloseWindow
	call UpdateTimePals
	pop af
	ret

.Init:
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
	jr c, .skip
	sub d
	ld [wSpriteViewerSavedMenuPointerY], a
	ld a, [wMovementBufferObject]
	sub 5
	ld [wSpriteViewerMenuStartingItem], a
	ret

.skip
	ld a, 1
	ld [wSpriteViewerSavedMenuPointerY], a
	ld a, [hl]
	ld [wSpriteViewerMenuStartingItem], a
	ret

.SetMenuAttributes:
	ld de, .MenuAttributes
	call SetMenuAttributes
	ld a, [wMovementBufferObject]
	cp 5
	jr c, .apply
	ld a, 5
.apply
	ld [w2DMenuNumRows], a
	ld a, [wSpriteViewerSavedMenuPointerY]
	ld [wMenuCursorY], a
	ret

.MenuAttributes:
	db 3, 1
	db 0, 1
	db $F, 0
	db $30, 3

.DoSpriteViewer:
	ld a, 0
	ld [wSpriteViewerJumptableIndex], a

.loop
	ld a, [wSpriteViewerJumptableIndex]
	ld hl, .Jumptable
	call CallJumptable
	jr nc, .loop
	ret

.Jumptable:
	dw .InitMenu
	dw .UpdateMenu
	dw .ShowSprites
	dw .SetupStaticSprite
	dw .SetupAnimatedSprite
	dw .FollowPrompt
	dw .Exit
	dw .SetFollowing

.Exit:
	ld a, -1
	ld [wSpriteViewerJumptableIndex], a
	scf
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.SetFollowing:
	ld hl, Function8031
	ld a, BANK(Function8031)
	call QueueScript

; Exits immediately after setting sprite to follow the player
	ld a, -1
	ld [wSpriteViewerJumptableIndex], a
	scf
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

.InitMenu:
	xor a
	ldh [hBGMapMode], a
	call HideSprites
	call ClearPalettes
	call ClearTileMap
	call .SetMenuAttributes
	call .DisplayMenu
	call SetPalettes
	call WaitBGMap
	ld a, SPRITEVIEWER_UPDATE_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.DisplayMenu:
	ld c, 5
	ld a, [wMovementBufferObject]
	cp c
	jr nc, .setup
	ld c, a
.setup
	hlcoord 5, 4
	ld a, [wSpriteViewerMenuStartingItem]
	inc a
	ld [wStringBuffer1], a
.display_loop
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

.UpdateMenu:
	call .SetMenuAttributes
.loop2
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
	jr .loop2

.a_button
	ld a, SPRITEVIEWER_SHOW_SPRITES
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.b_button
	ld a, SPRITEVIEWER_EXIT
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
	ld a, SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.ShowSprites:
	call ClearTileMap
	call .SetStartingPoint
	call LoadUnderDevelopmentString
	hlcoord 1, 2
	call PlaceString
	call .SetStartingPoint
	ld c, a
	callab Function14144
	ld hl, vSprites + $c0
	ld de, vFont
	ld bc, 12
	call Get2bpp
	call LoadFont
	call .SetStartingPoint
	call IsAnimatedSprite
	jr c, .animated_sprite
; static sprite
	ld a, SPRITEVIEWER_SETUP_STATIC_SPRITE
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.animated_sprite
	ld a, SPRITEVIEWER_SETUP_ANIMATED_SPRITE
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.SetupAnimatedSprite:
	ld a, $10
	ld [wMovementBuffer], a
	ld a, $20
	ld [wMovementBuffer + 1], a
	ld hl, Datafc6de
	ld de, wVirtualOAM
	call Functionfc6bb
	ld a, A_BUTTON | B_BUTTON
	call FieldDebug_WaitJoypadInput
	ld a, SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.SetupStaticSprite:
	xor a
	ld [wMovementBuffer + 2], a

.SpriteLoop:
	ld a, $10
	ld [wMovementBuffer], a
	ld a, $20
	ld [wMovementBuffer + 1], a
	call Functionfc689
	call .animate_walking
	bit B_BUTTON_F, a
	jr nz, .return_to_menu
	bit A_BUTTON_F, a
	jr nz, .show_follow_prompt
	ld a, [wMovementBuffer + 2]
	inc a
	and 3
	ld [wMovementBuffer + 2], a
	ldh a, [hJoyState]
	and D_UP | D_DOWN | D_LEFT | D_RIGHT
	jr nz, .SpriteLoop
	xor a
	ld [wMovementBuffer + 2], a
	jr .SpriteLoop
.return_to_menu
	ld a, SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a ; FIELDDEBUG_RETURN_REOPEN
	ret
.show_follow_prompt
	ld a, SPRITEVIEWER_FOLLOW_PROMPT
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

.FollowPrompt:
	ld hl, .FollowPromptString
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr nc, .set_following
; return to menu
	ld a, SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret
.set_following
	call .SetStartingPoint
	ld [wd646], a
	ld a, SPRITEVIEWER_SET_FOLLOWING
	ld [wSpriteViewerJumptableIndex], a
	ret

.FollowPromptString:
	text "これを　せんたくしますか？"
	done

.SetStartingPoint:
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
	db 0, 0, 0, 0, 0, 8, 1, 0
	db 8, 0, 2, 2, 8, 8, 3, 3

Datafc70e:
	db 0, 0, $c, 0, 0, 8, $d, 0
	db 8, 0, $e, 2, 8, 8, $f, 3

Datafc71e:
	db 0, 8, $c, $20, 0, 0, $d, $20
	db 8, 8, $e, $22, 8, 0, $f, $23

Datafc72e:
	db 0, 0, 4, 0, 0, 8, 5, 0
	db 8, 0, 6, 2, 8, 8, 7, 3

Datafc73e:
	db 0, 0, $10, 0, 0, 8, $11, 0
	db 8, 0, $12, 2, 8, 8, $13, 3

Datafc74e:
	db 0, 8, $10, $20, 0, 0, $11, $20
	db 8, 8, $12, $22, 8, 0, $13, $23

Datafc75e:
	db 0, 0, 8, 0, 0, 8, 9, 0
	db 8, 0, $a, 2, 8, 8, $b, 3

Datafc76e:
	db 0, 8, 8, $20, 0, 0, 9, $20
	db 8, 8, $a, $22, 8, 0, $b, $23

Datafc77e:
	db 0, 0, $14, 0, 0, 8, $15, 0
	db 8, 0, $16, 2, 8, 8, $17, 3

Datafc78e:
	db 0, 8, $14, $20, 0, 0, $15, $20
	db 8, 8, $16, $22, 8, 0, $17, $23

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
	call OpenToolgearMenu
	jr c, .cancelled
	ld a, [wMenuCursorY]
	dec a
	ld hl, .Jumptable
	jp CallJumptable

.Jumptable:
	dw .EnableToolgearClock
	dw .DisplayCoords
	dw .ChangeRTC
	dw .DayNight60SecondCycle
	dw .ResetDayNightCycle
	dw .DisableToolgearClock

.cancelled
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DayNight60SecondCycle:
	ld hl, wd153
	set OVERWORLD_MINUTE_TIME_F, [hl]
	jr .UpdateDayNightCycle

.ResetDayNightCycle:
	ld hl, wd153
	res OVERWORLD_MINUTE_TIME_F, [hl]
	jr .UpdateDayNightCycle

.ChangeRTC:
	callab SetTime

.UpdateDayNightCycle:
	callab Function8c325
	call UpdateTimePals
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.EnableToolgearClock:
	call EnableToolgear
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.DisableToolgearClock:
	call DisableToolgear
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.DisplayCoords:
	call EnableToolgearCoords
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

EnableToolgearCoords:
	call EnableToolgear
	ld hl, wd153
	set TOOLGEAR_COORDS_F, [hl]
	ret

OpenToolgearMenu:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call .AfterToolgearOpen
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	call CloseWindow
	ret

.AfterToolgearOpen:
	ld a, [wToolgearFlags]
	bit TOOLGEAR_COORDS_F, a
	ld a, FIELDDEBUG_RETURN_CLEANUP
	ret nz
	ld hl, wd153
	bit TOOLGEAR_COORDS_F, [hl]
	ld a, FIELDDEBUG_RETURN_WAIT_INPUT
	ret nz
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 7, 14
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 6
	db "とけい@"
	db "ざひょう@"
	db "アジャスト@"
	db "６０びょう@"
	db "２４じかん@"
	db "けす@"

FieldDebug_HealPokemon:
	predef HealParty
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
	call .NPCMovementTest
	jr c, .exit
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
.exit
	ld a, FIELDDEBUG_RETURN_WAIT_INPUT
	ret

.NPCMovementTest:
	ld a, [wMapGroup]
	cp GROUP_SILENT_HILL_HOUSE
	jr nz, .not_here
	ld a, [wMapId]
	cp MAP_SILENT_HILL_HOUSE
	jr nz, .not_here
	ld a, 2
	ld hl, .MovementData
	call LoadMovementDataPointer
	ld de, SFX_22
	call PlaySFX
	scf
	ret

.MovementData:
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

.not_here
	ld de, SFX_1E
	call PlaySFX
	ld hl, .NotHereText
	call FieldDebug_ShowTextboxAndExit
	xor a
	ret

.NotHereText:
	text "ここではだめです！"
	done

FieldDebug_PokemonFollowing:
	call .DoPokemonFollowing
	jr c, .exit
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
.exit
	ld a, FIELDDEBUG_RETURN_CLEANUP
	ret

.DoPokemonFollowing:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	jr c, .done
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .remove
	ld a, [wPlayerStructEnd]
	and a
	jr nz, .ShowUnableText
	callab Function8031
	ld de, SFX_24
	call PlaySFX
	call CloseWindow
	call UpdateSprites
	scf
	ret

.remove
	callab Function806c
	ld de, SFX_25
	call PlaySFX
	jr .done

.ShowUnableText:
	ld hl, .UnableText
	call FieldDebug_ShowTextboxAndExit

.done
	call CloseWindow
	call UpdateSprites
	xor a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 3, 3, 9, 9
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 2
	db "つける@"
	db "はずす@"

.UnableText:
	text "だめです！！"
	done

FieldDebug_FollowNPCTest:
	call .DoFollowNPC
	jr c, .exit
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
.exit
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.DoFollowNPC:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	jr c, .close
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .end
	ld a, [wObjectFollow_Follower]
	and a
	jr nz, .cannot_use
	call .asm_fc9a5
	call CloseWindow
	scf
	ret

.end
	call .asm_fc9c2
	jr .close
.cannot_use
	ld hl, .CannotUseWithPokemonText
	call MenuTextBox
	call CloseWindow
.close
	call CloseWindow
	and a
	ret

.asm_fc9a5:
	callab Function8047
	ld a, 1
	call Function15ed
	ld a, 1
	ld hl, .MovementData
	call LoadMovementDataPointer
	ld b, 1
	ld c, 0
	call StartFollow
	ret

.asm_fc9c2:
	call Function18cc
	ld a, 1
	call Function169f
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 3, 3, 9, 9
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 2
	db "はじめる@"
	db "おわる@"

.CannotUseWithPokemonText:
	text "ポケモンを　つれているときは"
	next "だめです"
	prompt

.MovementData:
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

MenuHeaderfca01:	; unreferenced?
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 11, 10
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_WRAP | STATICMENU_CURSOR
	db 4
	db "ポケモンつれあるき@"
	db "つれあるかれデモ@"
	db "ライバルおねえさん@"
	db "さくせいちゅう@"

FieldDebug_Warp:
	call DebugMenu_DisplayWarpSubmenu
	jr nc, .do_warp
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.do_warp
	ld a, [wMenuSelection]
	ld [wDefaultSpawnPoint], a
	ld hl, wVramState
	set 6, [hl]
	ldh a, [hROMBank]
	ld hl, FieldDebug_ShowWarpToText
	call QueueScript
	ld de, SFX_22
	call PlaySFX
	call DelayFrame
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

SECTION "engine/menu/field_debug_menu.asm@FieldDebug_ShowWarpToText", ROMX

FieldDebug_ShowWarpToText:
	call .ShowText
	call Functionfcc24
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	scf
	ret

.ShowText:
	call RefreshScreen
	ld a, [wDefaultSpawnPoint]
	call GetLandmarkName
	call CopyStringToStringBuffer2
	ld hl, .WarpToText
	call FieldDebug_ShowTextboxAndExit
	call Function1fea
	ret

.WarpToText:
	text_from_ram wStringBuffer2
	text "に"
	line "ワープします！"
	done

Functionfcc24:
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, .MovementDatafcc49
	call LoadMovementDataPointer
	ld hl, wVramState
	set 7, [hl]

.asm_fcc36
	call Function2c4a
	ld a, [wVramState]
	bit 7, a
	jr nz, .asm_fcc36
	ld a, 0
	ld hl, .MovementDatafcc4b
	call Function16fb
	ret

.MovementDatafcc49:
	db $36
	db $32

.MovementDatafcc4b:
	db $37
	db $32


FieldDebug_ToggleNPCMovement:
	call .ToggleNPCMovement
	jr nc, .close
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
.close
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.ToggleNPCMovement:
	ld hl, .MenuHeader
	call GetMenu2
	ret c
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .move
; stop NPCs
	ld a, 0
	call Function17f9
	jr .done

.move
	call Function1848
.done
	and a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 7, 6
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 2
	db "とめる@"
	db "うごかす@"

FieldDebug_FieldCut:
	call .DetermineEnvironment
	jr c, .close_menu
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.close_menu
	ld a, FIELDDEBUG_RETURN_CLEANUP
	ret

.DetermineEnvironment:
	call GetMapEnvironment
	cp ROUTE
	jr z, .outdoors
; Exit if indoors
	cp TOWN
	jr nz, .exit

.outdoors
	call .CheckGrassMetatile
	jr z, .in_grass
	call .IsCollision
	jr nz, .exit
	call .IsCuttableTile
	jr nc, .exit
	ld [hl], a
	jr .do_cut
.in_grass
	ld [hl], METATILE_LAWN
.do_cut
	call CloseWindow
	ld de, SFX_SHINE
	call PlaySFX
	call LoadMapPart
	call UpdateSprites
	call WaitBGMap
	scf
	ret

.exit
	and a
	ret

.CheckGrassMetatile:
	ld a, [wPlayerNextMapX]
	ld d, a
	ld a, [wPlayerNextMapY]
	ld e, a
	call GetBlockLocation
	ld a, [hl]
	cp METATILE_GRASS
	ret

.IsCollision: ; broken
	call GetFacingTileCoord
	cp OLD_COLLISION_CUT_TREE
	ret

.IsCuttableTile:
	call GetBlockLocation
	ld a, [hl]
	ld b, a
	ld de, .CuttableMetatiles
.find_cuttables
	ld a, [de]
	inc de
	cp b
	jr z, .got_cuttable
	cp -1
	jr z, .not_cuttable
	inc de
	jr .find_cuttables

.got_cuttable
	ld a, [de]
	scf
	ret

.not_cuttable
	and a
	ret

.CuttableMetatiles:
	db METATILE_CUT_SE_TREES_N
	db METATILE_SMALL_TREES_N
	db METATILE_CUT_NW_TREES_E
	db METATILE_SMALL_TREES_E
	db METATILE_CUT_NE_TREE_NW
	db METATILE_SMALL_TREE_NW
	db METATILE_CUT_NE_TREE_SE
	db METATILE_SMALL_TREE_SE
	db -1

FieldDebug_CheckTile:
	call .CheckTile
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.CheckTile:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call MenuBox
	ld a, [wPlayerNextMapX]
	ld d, a
	ld a, [wPlayerNextMapY]
	ld e, a
	call GetBlockLocation
	ld a, [hl]
	push af
	call MenuBoxCoord2Tile
	ld bc, $2a
	add hl, bc
	pop af
	call .ShowTileNumber
	ld a, 10
	call DelayFrames
	ld a, BUTTONS
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ret

.MenuHeader:
	db $40
	menu_coords 0, 0, 5, 4
	dw .MenuData
	db 0

.MenuData: ; empty
	db 0

.ShowTileNumber:
	push af
	swap a
	and $f
	call .ShowHexDigit
	ld [hli], a
	pop af
	and $f
	call .ShowHexDigit
	ld [hli], a
	ret

.ShowHexDigit:
	push de
	push hl
	ld hl, .HexadecimalNumbers
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	pop hl
	pop de
	ret

.HexadecimalNumbers:
	db "０１２３４５６７８９ＡＢＣＤＥＦ"

FieldDebug_MoveToEntrance:
; Check if the player is currently on Route 1
	ld a, [wMapGroup]
	cp GROUP_ROUTE_1_P1
	jr nz, .cannot_use
	ld a, [wMapId]
	cp MAP_ROUTE_1_P1
	jr nz, .cannot_use

	ldh a, [hROMBank]
	ld hl, .DoMove
	call QueueScript
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

.cannot_use
	ld hl, .CantUseText
	call FieldDebug_ShowTextboxAndExit
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.CantUseText:
	text "ここでは　できません"
	para "ロード１でじっこうできます"
	done

.DoMove:
	call RefreshScreen
	ld hl, .MoveText
	call FieldDebug_ShowTextboxAndExit
	ld d, $d
	ld e, $d
	ld b, 0
	ld c, 1
	callab Function833a
	ld a, 0
	ld hl, wMovementBuffer
	call LoadMovementDataPointer
	call Function1fea
	ret

.MoveText:
	text "とくていちてん　まで"
	next "うごかします"
	done

FieldDebug_TrainerGear:
	call .OpenTrainerGear
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.OpenTrainerGear:
	call LoadStandardMenuHeader
	callab OpenTrainerGear
	call ClearPalettes
	callab StartMenuLoadSprites
	call CloseWindow
	ret

FieldDebug_OpenMapViewer:
	call .DoOpen
	jr c, .done
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

.done:
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DoOpen:
	ld hl, .MapViewPrompt
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c

	ldh a, [hROMBank]
	ld hl, .MapViewScript
	call QueueScript
	ret

.MapViewPrompt:
	text "マップビューワーを"
	line "しようしますか？"
	done

.MapViewScript:
	ld a, 9
	call WriteIntod637
	xor a
	ldh [hJoypadSum], a
	ld a, DEBUGMAPVIEWER_INIT
	ldh [hDebugMapViewerJumptable], a
	ret

DebugMapViewer::
	ld a, [wd153]
	ld b, a
	ld a, [wToolgearFlags]
	ld c, a
	push bc
	call EnableToolgearCoords
	call InitToolgearBuffer
.loop
	call GetJoypad
	call .do_jumptable
	jr c, .continue
	call Function2c4a
	jr nc, .loop
	callab Function824c
	jr .loop

.continue
	ld a, 4
	call WriteIntod637
	pop bc
	ld a, b
	ld [wd153], a
	ld a, c
	ld [wToolgearFlags], a
	ret

.do_jumptable
	ld a, [wDebugFlags]
	bit 1, a
	ret z
	ldh a, [hDebugMapViewerJumptable]
	and a
	ret z
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw .Empty
	dw .Init
	dw .ControlCursor
	dw .MoveCursorToPlayer
	dw .WaitFinishedMoving
	dw .Cleanup

.Empty:
	ret

.Init:
	call Function18b4
	call DebugMapViewer_LoadCursorSprite
	call DebugMapViewer_ReplacePlayerObject
	ld a, $2a
	ld [wMovementObject], a
	ld a, DEBUGMAPVIEWER_CONTROL_CURSOR
	ldh [hDebugMapViewerJumptable], a
	and a
	ret

.ControlCursor:
	ldh a, [hJoypadSum]
	ld b, a
	xor a
	ldh [hJoypadSum], a
	ld a, b
	and START
	jr nz, .start_pressed
	ldh a, [hJoyState]
	and A_BUTTON
	jr nz, .a_pressed
	call DebugMapViewer_DoMovement
	jr .apply_movement
.start_pressed
	call DebugMapViewer_ShowViewerPrompt
	ld a, $2a
	jr .apply_movement
.a_pressed
	call DebugMapViewer_ShowSelectedDetails
	ld a, $2a
.apply_movement
	ld [wMovementObject], a
	and a
	ret

.MoveCursorToPlayer:
	ld a, 1
	ld hl, wMovementBuffer
	call LoadMovementDataPointer
	ld d, 2
	ld b, 1
	ld c, 0
	callab Function83a2
	ld a, DEBUGMAPVIEWER_WAIT_FINISHED_MOVING
	ldh [hDebugMapViewerJumptable], a
	and a
	ret

.WaitFinishedMoving:
	ld hl, wVramState
	bit 7, [hl]
	jr nz, .skip
	ld a, DEBUGMAPVIEWER_CLEANUP
	ldh [hDebugMapViewerJumptable], a
.skip
	and a
	ret

.Cleanup:
	ld a, 1
	call Function169f
	call Function18cc
	ld a, 0
	call Function1908
	xor a
	ldh [hDebugMapViewerJumptable], a
	scf
	ret

DebugMapViewer_ShowViewerPrompt:
	call RefreshScreen
	ld hl, .ChangeViewerPrompt
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr c, .no
	ld a, DEBUGMAPVIEWER_MOVE_CURSOR_TO_PLAYER
	ldh [hDebugMapViewerJumptable], a
.no
	call Function1fea
	ret

.ChangeViewerPrompt:
	text "ビューワーモードを"
	line "かいじょ　しますか？"
	done

DebugMapViewer_ShowSelectedDetails:
	ld a, 0
	ldh [hTextBoxCursorBlinkInterval], a
	ld bc, wObjectStructs
	callab Function77a1
	jr nc, .skip
	call RefreshScreen
	call .DisplayActorCastID
	call Function1fea
	ret
.skip
	call DisplayBGEventDetails
	ret

.DisplayActorCastID:
	ld hl, .ActorCastText
	call MenuTextBox

; Display index of selected object from map objects
; (referred to as "actor number")
	ld de, hEventID
	hlcoord 10, 14
	ld bc, $0102
	call PrintNumber

; Display index of selected object from visible objects
; (referred to as "cast number")
	ldh a, [hEventID]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp $10
	jr nc, .invalid_index
	ld d, h
	ld e, l
	hlcoord 10, 16
	ld bc, $0102
	call PrintNumber
	jr .wait

.invalid_index
	hlcoord 10, 16
	ld de, .NoneText
	call PlaceString

.wait
	ld a, BUTTONS
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ret

.ActorCastText:
	text "アクターナンバー　　　　"
	line "キャストナンバー　　　　"
	done

.NoneText:
	db "なし@"

DebugMapViewer_DoMovement:
	ld bc, wObjectStructs
	ldh a, [hJoyState]
	ld d, a
	bit D_DOWN_F, a
	jr nz, .down
	bit D_UP_F, a
	jr nz, .up
	bit D_LEFT_F, a
	jr nz, .left
	bit D_RIGHT_F, a
	jr nz, .right
.done
	ld a, $2a
	ret

.down
	ld a, [wMapHeight]
	add a
	add 4
	ld e, a
	ld hl, $11
	add hl, bc
	ld a, [hl]
	inc a
	cp e
	jr nc, .done
	bit 1, d
	ld a, $c
	ret nz
	ld a, 8
	ret

.up
	ld hl, $11
	add hl, bc
	ld a, [hl]
	dec a
	cp 4
	jr c, .done
	bit 1, d
	ld a, $d
	ret nz
	ld a, 9
	ret

.left
	ld hl, $10
	add hl, bc
	ld a, [hl]
	dec a
	cp 4
	jr c, .done
	bit 1, d
	ld a, $e
	ret nz
	ld a, $a
	ret

.right
	ld a, [wMapWidth]
	add a
	add 4
	ld e, a
	ld hl, $10
	add hl, bc
	ld a, [hl]
	inc a
	cp e
	jr nc, .done
	bit 1, d
	ld a, $f
	ret nz
	ld a, $b
	ret

DebugMapViewer_ReplacePlayerObject:
	callab Function807b
	ld a, 1
	call Function15ed
	ld a, 1
	call Function1908
	ld bc, wObjectStructs
	ld hl, OBJECT_FLAGS
	add hl, bc
	set 3, [hl]
	set 2, [hl]
	set 1, [hl]
	ret

Datafd044:
	db $1
	db $0
	db $0
	db $17
	db $ee
	db $0
	db $0
	db $0
	db $0
	db $0
	db $0
	db $0
	db $0
	db $0
	db $0

DebugMapViewer_LoadCursorSprite:
	ldh a, [hBGMapMode]
	push af
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hBGMapMode], a
	ld de, TownMapCursorGFX
	ld hl, $80c0
	ld bc, $3f04
	call Get2bpp
	pop af
	ldh [hMapAnims], a
	pop af
	ldh [hBGMapMode], a
	ret

SECTION "engine/menu/field_debug_menu.asm@DisplayBGEventDetails", ROMX

DisplayBGEventDetails:
	call SUB_2f21
	ret nc
	call .Functionfd0cc
	call RefreshScreen
	ld hl, .TableText
	call MenuTextBox
	call .PrintTableDetails
	call .WaitInput
	call CloseWindow
	call Function1fea
	ret

.Functionfd0cc:
	ld a, [hld]
	ld [wFieldMoveScriptID], a
	ld a, [hl]
	ld [wcdc8], a
	ld a, d
	ld [wMapBlocksAddress], a
	ld a, e
	ld [wHPBarOldHP], a
	ld a, b
	ld [wReplacementBlock], a
	ld a, [wCurrMapSignCount]
	sub c
	inc a
	ld [wHPBarNewHP], a
	ret

.TableText:
	text "テーブル"
	done

.PrintTableDetails:
	hlcoord 8, 14
	ld de, wMapBlocksAddress
	call PrintHexByte

	hlcoord 11, 14
	ld de, wHPBarOldHP
	call PrintHexByte

	hlcoord 14, 14
	ld de, wcdc8
	call PrintHexByte

	hlcoord 17, 14
	ld de, wFieldMoveScriptID
	ld bc, $8102
	call PrintNumber

	hlcoord 14, 16
	ld de, wReplacementBlock
	call PrintHexByte

	hlcoord 17, 16
	ld de, wHPBarNewHP
	ld bc, $8102
	call PrintNumber

	ret

.WaitInput:
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON | SELECT
	jr z, .WaitInput
	ret

ItemTest_BagMenu:
	dw .MenuHeader
	dw wRegularItemsCursor
	dw wRegularItemsScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 4, 1, 19, 10
	dw .MenuData
	db 1

.MenuData:
	db SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY
	dbw 0, wItems
; Incorrectly configured, will cause the game to crash
	db BANK(PlaceMenuItemName), $cd
	dw PlaceMenuItemName
	db BANK(PlaceMenuItemQuantity), $cd
	dw PlaceMenuItemQuantity
	db BANK(UpdateItemDescription)
	dw UpdateItemDescription

ItemTest_PCMenu:
	dw .MenuHeader
	dw wBackpackAndKeyItemsCursor
	dw wBackpackAndKeyItemsScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 4, 1, 19, 10
	dw .MenuData
	db 1

.MenuData:
	db SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY
	dbw 0, wNumKeyItems
; Incorrectly configured, will cause the game to crash
	db BANK(PlaceMenuItemName), $cd
	dw PlaceMenuItemName
	db BANK(PlaceMenuItemQuantity), $cd
	dw PlaceMenuItemQuantity
	db BANK(UpdateItemDescription)
	dw UpdateItemDescription

FieldDebug_ItemTest:
	call ClearSprites
	ld hl, wVramState
	res 0, [hl]
	call LoadStandardMenuHeader
	call ClearTileMap
	call UpdateSprites
	call .DoItemTest
	ld hl, wVramState
	set 0, [hl]
	call CloseWindow
	ret
; unused
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.ClearTilemap:
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $f1
	call ByteFill
	ret

.DoItemTest:
	call .ClearTilemap
.bag_menu
	ld hl, ItemTest_BagMenu
	call Function3810
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit_menu
	cp D_LEFT
	jr z, .pc_menu
	cp D_RIGHT
	jr z, .pc_menu
	jr .DecideAction

.pc_menu
	ld hl, ItemTest_PCMenu
	call Function3810
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit_menu
	cp D_LEFT
	jr z, .bag_menu
	cp D_RIGHT
	jr z, .bag_menu
	ld hl, .CannotUsePCToolsText
	call MenuTextBox
	call CloseWindow
	jr .pc_menu

.CannotUsePCToolsText:
	text "パソコンの　どうぐ　は"
	next "つかえません"
	prompt

.restart
	jp .DoItemTest

.exit_menu
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
; unused
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DecideAction:
	ld a, [wScrollingMenuCursorPosition]
	ld [wItemIndex], a
	call .ClearMenu
	call PlaceHollowCursor
	ld hl, .UseOrTosswMenuHeader
	call GetMenu2
	jp c, .restart
	ld a, [wMenuCursorY]
	cp 2
	jr z, .toss_item
	jp .continue
; unused
	ld hl, .ItemPickedText
	call FieldDebug_ShowTextboxAndExit
	jp .restart

.ItemPickedText:
	text "アイテムを　えらんだ！"
	done

.ClearMenu:
	call MenuBoxCoord2Tile
	ld de, $14
	add hl, de
	ld de, $28
	ld a, [wMenuDataItems]
.clear_menu_loop
	ld [hl], "　"
	add hl, de
	dec a
	jr nz, .clear_menu_loop
	ret

.UseOrTosswMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 14, 10, 19, 14
	dw .UseOrTossMenuData
	db 1

.UseOrTossMenuData:
	db $c0
	db 2
	db "つかう@"
	db "すてる@"

.toss_item
	ld hl, wItems
	call .DetermineItemTossable
	jp .DoItemTest

.DetermineItemTossable:
	push hl
	callab _CheckTossableItem
	pop hl
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .not_tossable
	call .tossable
	jr .done

.not_tossable
	ld hl, .CannotTossText
	call MenuTextBox
	call CloseWindow
.done
	ret

.tossable
	push hl
	callab SelectQuantityToToss
	jr c, .cancel_toss
	call .load_item
	ld hl, .TossConfirmText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr c, .cancel_toss
	ld a, [wItemIndex]
	pop hl
	call TossItem
	call .load_item

; Crashes here; .ItemTossedText should be loaded to hl instead
	call .ItemTossedText
	call MenuTextBox

	call ExitMenu
	call CloseWindow
	and a
	ret

.cancel_toss
; Missing pop after push
	call CloseWindow
	scf
	ret

.load_item
	predef_id LoadItemData
	call Predef
	ret

.TossConfirmText:
	text_from_ram wStringBuffer2
	text "を　すてます"
	line "ほんとに　よろしいですか？"
	prompt

.ItemTossedText:
	text_from_ram wStringBuffer1
	text "を"
	line "すてました！"
	prompt

.CannotTossText:
	text "それは　とても　たいせつなモノです"
	line "すてることは　できません！"
	prompt

.continue
	predef_id LoadItemData
	call Predef
	ld a, [wCurItem]
	cp ITEM_TM01
	jr nc, .use_item2
	ld a, [wCurItem]
	call .FindUsableItem2
	jr c, .use_item
	ld a, [wCurItem]
	call .FindUsableItem
	jr c, .use_item2
	call UseItem
	jp .restart

.use_item
	call UseItem
	ld a, [wFieldMoveSucceeded]
	and a
	jp z, .restart
	ld a, FIELDDEBUG_RETURN_WAIT_INPUT
	ret

.use_item2
	call UseItem
	call ClearBGPalettes
	call Function360b
	jp .restart

.FindUsableItem:
	ld hl, .UsableItems
	ld de, 1
	call FindItemInTable
	ret

.UsableItems:
	db ITEM_BURN_HEAL
	db ITEM_ICE_HEAL
	db ITEM_AWAKENING
	db ITEM_PARLYZ_HEAL
	db ITEM_FULL_RESTORE
	db ITEM_MAX_POTION
	db ITEM_HYPER_POTION
	db ITEM_SUPER_POTION
	db ITEM_POTION
	db ITEM_ESCAPE_ROPE
	db ITEM_REPEL
	db ITEM_RARE_CANDY
	db ITEM_X_ACCURACY
	db ITEM_LEAF_STONE
	db ITEM_23
	db ITEM_NUGGET
	db ITEM_POKE_DOLL
	db ITEM_FULL_HEAL
	db ITEM_REVIVE
	db ITEM_MAX_REVIVE
	db ITEM_SODA_POP
	db ITEM_X_SPEED
	db ITEM_X_SPECIAL
	db ITEM_COIN_CASE
	db ITEM_3C
	db ITEM_SUPER_ROD
	db ITEM_PP_UP
	db ITEM_ELIXER
	db ITEM_MYSTIC_PETAL
	db ITEM_WHITE_FEATHER
	db ITEM_CONFUSE_CLAW
	db ITEM_SNAKESKIN
	db ITEM_ELECTRIC_POUCH
	db ITEM_TOXIC_NEEDLE
	db ITEM_KINGS_ROCK
	db ITEM_STRANGE_POWER
	db -1

.FindUsableItem2:
	ld hl, .UsableItems2
	ld de, 1
	call FindItemInTable
	ret

.UsableItems2:
	db ITEM_BICYCLE
	db ITEM_CARBOS
	db ITEM_UP_GRADE
	db ITEM_BIG_LEAF
	db ITEM_SHARP_STONE
	db ITEM_BLACK_FEATHER
	db ITEM_SHARP_FANG
	db -1

FieldDebug_PCMenu:
	callab PokemonCenterPC
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

