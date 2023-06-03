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
	callab SpawnFollower
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

