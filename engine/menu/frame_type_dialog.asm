FrameTypeDialog:
	ld hl, .MenuHeader
	call LoadMenuHeader
	ld a, [wTextboxFrame]
	inc a
	ld [wMenuCursorPosition], a
	call VerticalMenu
	jr c, .close
	ld a, [wMenuCursorY]
	dec a
	ld [wTextboxFrame], a
	push de
	ld de, SFX_MENU
	call PlaySFX
	pop de
	call LoadFontExtra
	call WaitBGMap

.close
	call CloseWindow
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db NUM_FRAMES ; items
for x, 1, NUM_FRAMES + 1
	db "{d:x}ばんめ@"
endr
