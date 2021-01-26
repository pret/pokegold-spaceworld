INCLUDE "constants.asm"

SECTION "engine/menu/frame_type_dialog.asm", ROMX

FrameTypeDialog:
	ld hl, .MenuHeader
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

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
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
