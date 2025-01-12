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
	callfar Function77ad
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
	callfar Function14144
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
	ld de, wShadowOAM
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
	ld de, wShadowOAM
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

