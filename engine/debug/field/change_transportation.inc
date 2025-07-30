FieldDebug_ChangeTransportation:
	ld hl, .ChangeTransportationMenuHeader
	call LoadMenuHeader
	ld a, [wPlayerState]
	call GetActiveTransportation
	ld [wMenuCursorPosition], a
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
	callfar GetPlayerSprite
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
	cp OLD_HI_NYBBLE_WATER ; happens to match HI_NYBBLE_WATER
	jr z, .surfable
	cp OLD_HI_NYBBLE_WATER_ALT
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
	ld a, [wPlayerDirection]
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
	slow_step DOWN
	slow_step UP
	slow_step LEFT
	slow_step RIGHT

