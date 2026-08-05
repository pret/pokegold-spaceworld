; FieldDebug_SpriteViewer.DoSpriteViewer.Jumptable constants
	const_def
	const SPRITEVIEWER_INIT_MENU             ; 0
	const SPRITEVIEWER_UPDATE_MENU           ; 1
	const SPRITEVIEWER_SHOW_SPRITES          ; 2
	const SPRITEVIEWER_SETUP_STATIC_SPRITE   ; 3
	const SPRITEVIEWER_SETUP_ANIMATED_SPRITE ; 4
	const SPRITEVIEWER_FOLLOW_PROMPT         ; 5
	const SPRITEVIEWER_EXIT                  ; 6
	const SPRITEVIEWER_SET_FOLLOWING         ; 7
	
DEF SPRITEVIEWER_NUM_ROWS EQU 5

FieldDebug_SpriteViewer:
	call LoadStandardMenuHeader
	call ClearTileMap
	call HideSprites

	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]

	call .Init
	call .DoSpriteViewer
	push af

	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]

	call ClearPalettes
	call RestoreScreenAndReloadTiles
	call CloseWindow
	call UpdateTimePals

	pop af
	ret

.Init:
	ld a, NUM_OVERWORLD_SPRITES
	ld [wMovementBufferObject], a
	ld a, 1
	ld [wSpriteViewerSavedMenuPointerY], a
	ld a, 0
	ld [wSpriteViewerMenuStartingItem], a
	ld a, 1

	ldh [hTextBoxCursorBlinkInterval], a
	callfar IsObjectFacingSomeoneElse
	ret nc

	ldh a, [hEventID]
	call GetObjectStruct
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [wMovementBufferObject]
	ld d, a
	ld a, SPRITEVIEWER_NUM_ROWS
	add [hl]
	cp d
	jr c, .skip

	sub d
	ld [wSpriteViewerSavedMenuPointerY], a
	ld a, [wMovementBufferObject]
	sub SPRITEVIEWER_NUM_ROWS
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
	cp SPRITEVIEWER_NUM_ROWS
	jr c, .apply
	ld a, SPRITEVIEWER_NUM_ROWS
.apply
	ld [w2DMenuNumRows], a
	ld a, [wSpriteViewerSavedMenuPointerY]
	ld [wMenuCursorY], a
	ret

.MenuAttributes:
	db 3, 1 ; cursor start y, x
	db 0, 1 ; rows, columns
	db _2DMENU_EXIT_RIGHT | _2DMENU_EXIT_LEFT | _2DMENU_EXIT_UP | _2DMENU_EXIT_DOWN ; flags 1
	db 0 ; flags 2
	dn 3, 0 ; cursor offset
	db PAD_A | PAD_B ; accepted buttons

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
	ld hl, SpawnFollower
	ld a, BANK(SpawnFollower)
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
	call SetDefaultBGPAndOBP
	call WaitBGMap

	ld a, SPRITEVIEWER_UPDATE_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.DisplayMenu:
	ld c, SPRITEVIEWER_NUM_ROWS
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

	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	ld de, wStringBuffer1
	call PrintNumber

	ld a, [wStringBuffer1]
	call .LoadUnderDevelopmentString
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
	call StaticMenuJoypad
	ld a, [wMenuCursorY]
	ld [wSpriteViewerSavedMenuPointerY], a

	ldh a, [hJoySum]
	bit B_PAD_A, a
	jp nz, .a_button
	bit B_PAD_B, a
	jp nz, .b_button
	bit B_PAD_DOWN, a
	jr nz, .down
	bit B_PAD_UP, a
	jr nz, .up
	bit B_PAD_LEFT, a
	jr nz, .left
	bit B_PAD_RIGHT, a
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
	cp SPRITEVIEWER_NUM_ROWS
	jr c, .reload_menu
	sub SPRITEVIEWER_NUM_ROWS
	ld b, a
	ld a, [wSpriteViewerMenuStartingItem]
	cp b
	jr z, .reload_menu
	inc a
	ld [wSpriteViewerMenuStartingItem], a
	jr .reload_menu

.right
	ld a, [wMovementBufferObject]
	cp SPRITEVIEWER_NUM_ROWS
	jr c, .reload_menu
	sub SPRITEVIEWER_NUM_ROWS - 1
	ld b, a
	ld a, [wSpriteViewerMenuStartingItem]
	add SPRITEVIEWER_NUM_ROWS
	ld [wSpriteViewerMenuStartingItem], a
	cp b
	jr c, .reload_menu
	dec b
	ld a, b
	ld [wSpriteViewerMenuStartingItem], a
	jr .reload_menu

.left
	ld a, [wSpriteViewerMenuStartingItem]
	sub SPRITEVIEWER_NUM_ROWS
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
	call .LoadUnderDevelopmentString
	hlcoord 1, 2
	call PlaceString

	call .SetStartingPoint
	ld c, a
	callfar LoadOverworldSprite_PlayerSlot

	ld hl, vSprites tile $0c
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
	ld a, TILE_WIDTH * 2
	ld [wMovementXBuffer], a
	ld a, TILE_WIDTH * 4
	ld [wMovementYBuffer], a
	ld hl, SpriteViewerSpriteTilemap
	ld de, wShadowOAM
	call SetupSpriteViewerSpriteTilemap

	ld a, PAD_A | PAD_B
	call FieldDebug_WaitJoypadInput

	ld a, SPRITEVIEWER_INIT_MENU
	ld [wSpriteViewerJumptableIndex], a
	xor a
	ret

.SetupStaticSprite:
	xor a
	ld [wMovementSpriteViewerDirection], a

.SpriteLoop:
	ld a, TILE_WIDTH * 2
	ld [wMovementXBuffer], a
	ld a, TILE_WIDTH * 4
	ld [wMovementYBuffer], a
	call SetupSpriteViewerSpriteWalkingTilemap

	call .animate_walking
	bit B_PAD_B, a
	jr nz, .return_to_menu
	bit B_PAD_A, a
	jr nz, .show_follow_prompt

	ld a, [wMovementSpriteViewerDirection]
	inc a
	and RIGHT
	ld [wMovementSpriteViewerDirection], a

	ldh a, [hJoyState]
	and PAD_UP | PAD_DOWN | PAD_LEFT | PAD_RIGHT
	jr nz, .SpriteLoop
	xor a
	ld [wMovementSpriteViewerDirection], a
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
	and PAD_A | PAD_B
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
	ld [wUsedFollowerSprites], a
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

.LoadUnderDevelopmentString:
	ld de, .String
	ret

.String:
	db "かいはつちゅう@"

SetupSpriteViewerSpriteWalkingTilemap:
	ld de, wShadowOAM
	ld hl, SpriteViewerSpriteTilemap
	ld a, [wMovementSpriteViewerDirection]
	and %00000011
	ld bc, 2
	call AddNTimes
	ld c, 4
.loop
	push bc
	push hl
	push de
	call SetupSpriteViewerSpriteTilemap
	ld a, [wMovementXBuffer]
	add $20
	ld [wMovementXBuffer], a
	pop hl
	ld bc, 4 * 4
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, 8
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

SetupSpriteViewerSpriteTilemap:
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, [wMovementYBuffer]
	add $10
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, [wMovementXBuffer]
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
	jr z, .loop
	ret

INCLUDE "data/debug/sprite_viewer_facings.asm"
