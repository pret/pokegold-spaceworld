INCLUDE "constants.asm"

SECTION "engine/menu/scrolling_menu.asm", ROMX

_InitScrollingMenu::
	xor a
	ld [wMenuJoypad], a
	ldh [hBGMapMode], a
	inc a
	ldh [hInMenu], a
	ld hl, wOptions
	set NO_TEXT_SCROLL_F, [hl]
	call InitScrollingMenuCursor
	call ScrollingMenu_InitFlags
	ld c, 10
	call DelayFrames
	call ScrollingMenuMain
	ret

_ScrollingMenu::
.loop
	call ScrollingMenuJoyAction
	jp c, .exit
	ld a, 0
	ldh [hJoypadSum], a
	call z, ScrollingMenuMain
	jr .loop
.exit
	ld [wMenuJoypad], a
	ld a, 0
	ldh [hInMenu], a
	ld hl, wOptions
	res NO_TEXT_SCROLL_F, [hl]
	ret

ScrollingMenuMain::
	xor a
	ldh [hBGMapMode], a
	call ScrollingMenu_UpdateDisplay
	call ScrollingMenu_PlaceCursor
	call ScrollingMenu_CheckCallFunction3
	xor a
	ldh [hJoypadSum], a
	call WaitBGMap
	ret

ScrollingMenuJoyAction::
	call ScrollingMenuJoypad
	ldh a, [hJoySum]
	and D_PAD
	ld b, a
	ldh a, [hJoypadSum]
	and BUTTONS
	or b
	bit A_BUTTON_F, a
	jp nz, .a_button
	bit B_BUTTON_F, a
	jp nz, .b_button
	bit SELECT_F, a
	jp nz, .select
	bit START_F, a
	jp nz, .start
	bit D_RIGHT_F, a
	jp nz, .d_right
	bit D_LEFT_F, a
	jp nz, .d_left
	bit D_UP_F, a
	jp nz, .d_up
	bit D_DOWN_F, a
	jp nz, .d_down
	jr ScrollingMenuJoyAction

	; unreferenced
.no_zero_no_carry
	ld a, -1
	and a
	ret

.a_button
	call PlaceHollowCursor
	ld a, [wMenuCursorY]
	dec a
	call ScrollingMenu_GetListItemCoordAndFunctionArgs
	ld a, [wMenuSelection]
	ld [wCurItem], a
	ld a, [wMenuSelectionQuantity]
	ld [wItemQuantityBuffer], a
	call ScrollingMenu_GetCursorPosition
	dec a
	ld [wScrollingMenuCursorPosition], a
	ld [wCurItemQuantity], a
	ld a, [wMenuSelection]
	cp -1
	jr z, .b_button
	ld a, A_BUTTON
	scf
	ret

.b_button
	ld a, B_BUTTON
	scf
	ret

.select
	ld a, [wMenuDataFlags]
	bit SCROLLINGMENU_ENABLE_SELECT_F, a
	jp z, xor_a_dec_a
	ld a, [wMenuCursorY]
	dec a
	call ScrollingMenu_GetListItemCoordAndFunctionArgs
	ld a, [wMenuSelection]
	cp -1
	jp z, xor_a_dec_a
	call ScrollingMenu_GetCursorPosition
	dec a
	ld [wScrollingMenuCursorPosition], a
	ld a, SELECT
	scf
	ret

.start
	ld a, [wMenuDataFlags]
	bit SCROLLINGMENU_ENABLE_START_F, a
	jp z, xor_a_dec_a
	ld a, START
	scf
	ret

.d_left
	ld hl, w2DMenuFlags2
	bit _2DMENU_DISABLE_JOYPAD_FILTER_F, [hl]
	jp z, xor_a_dec_a
	ld a, [wMenuDataHeaderEnd]
	bit SCROLLINGMENU_ENABLE_LEFT_F, a
	jp z, xor_a_dec_a
	ld a, D_LEFT
	scf
	ret

.d_right
	ld hl, w2DMenuFlags2
	bit _2DMENU_DISABLE_JOYPAD_FILTER_F, [hl]
	jp z, xor_a_dec_a
	ld a, [wMenuDataHeaderEnd]
	bit SCROLLINGMENU_ENABLE_RIGHT_F, a
	jp z, xor_a_dec_a
	ld a, D_RIGHT
	scf
	ret

.d_up
	ld hl, w2DMenuFlags2
	bit _2DMENU_DISABLE_JOYPAD_FILTER_F, [hl]
	jp z, xor_a
	ld hl, wMenuScrollPosition
	ld a, [hl]
	and a
	jp z, xor_a ; xor_a_dec_a in final game
	dec [hl]
	jp xor_a

.d_down
	ld hl, w2DMenuFlags2
	bit _2DMENU_DISABLE_JOYPAD_FILTER_F, [hl]
	jp z, xor_a
	ld hl, wMenuScrollPosition
	ld a, [wMenuData_ScrollingMenuHeight]
	add [hl]
	ld b, a
	ld a, [wScrollingMenuListSize]
	cp b
	jp c, xor_a ; xor_a_dec_a in final game
	inc [hl]
	jp xor_a

ScrollingMenu_GetCursorPosition:
	ld a, [wMenuScrollPosition]
	ld c, a
	ld a, [wMenuCursorY]
	add c
	ld c, a
	ret

ScrollingMenu_ClearLeftColumn::
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH
	add hl, de
	ld de, 2 * SCREEN_WIDTH
	ld a, [wMenuData_ScrollingMenuHeight]
.loop
	ld [hl], '　'
	add hl, de
	dec a
	jr nz, .loop
	ret

InitScrollingMenuCursor::
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMenuData_ItemsPointerBank]
	call GetFarByte
	ld [wScrollingMenuListSize], a
	ld a, [wMenuScrollPosition]
	ld c, a
	ld a, [wMenuCursorPosition]
	add c
	ld b, a
	ld a, [wScrollingMenuListSize]
	inc a
	cp b
	jr c, .wrap

	ld a, [wMenuScrollPosition]
	ld c, a
	ld a, [wMenuData_ScrollingMenuHeight]
	add c
	ld b, a
	ld a, [wScrollingMenuListSize]
	inc a
	cp b
	jr nc, .done

.wrap
	xor a
	ld [wMenuScrollPosition], a
	ld a, 1
	ld [wMenuCursorPosition], a
.done
	ret

ScrollingMenu_InitFlags::
	ld a, [wMenuDataFlags]
	ld c, a
	ld a, [wScrollingMenuListSize]
	ld b, a
	ld a, [wMenuBorderTopCoord]
	add 1
	ld [w2DMenuCursorInitY], a
	ld a, [wMenuBorderLeftCoord]
	add 0
	ld [w2DMenuCursorInitX], a
	ld a, [wMenuData_ScrollingMenuHeight]
	cp b
	jr c, .no_extra_row
	jr z, .no_extra_row
	ld a, b
	inc a
.no_extra_row
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, _2DMENU_EXIT_UP | _2DMENU_EXIT_DOWN | _2DMENU_DISABLE_JOYPAD_FILTER
	bit SCROLLINGMENU_ENABLE_RIGHT_F, c
	jr z, .skip_set_0
	set _2DMENU_EXIT_RIGHT_F, a

.skip_set_0
	bit SCROLLINGMENU_ENABLE_LEFT_F, c
	jr z, .skip_set_1
	set _2DMENU_EXIT_LEFT_F, a

.skip_set_1
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, A_BUTTON | B_BUTTON | D_UP | D_DOWN
	bit SCROLLINGMENU_ENABLE_SELECT_F, c
	jr z, .disallow_select
	add SELECT
.disallow_select
	bit SCROLLINGMENU_ENABLE_START_F, c
	jr z, .disallow_start
	add START

.disallow_start
	ld [wMenuJoypadFilter], a
	ld a, [w2DMenuNumRows]
	ld b, a
	ld a, [wMenuCursorPosition]
	and a
	jr z, .reset_cursor
	cp b
	jr z, .cursor_okay
	jr c, .cursor_okay

.reset_cursor
	ld a, 1
.cursor_okay
	ld [wMenuCursorY], a
	ld a, 1
	ld [wMenuCursorX], a
	xor a
	ld [wCursorCurrentTile], a
	ld [wCursorCurrentTile + 1], a
	ld [wCursorOffCharacter], a
	ret

ScrollingMenu_UpdateDisplay::
	call ClearWholeMenuBox
	ld a, [wMenuScrollPosition]
	and a
	jr z, .okay
	ld a, [wMenuBorderTopCoord]
	ld b, a
	ld a, [wMenuBorderRightCoord]
	ld c, a
	call Coord2Tile
	ld [hl], '▲'

.okay
	call MenuBoxCoord2Tile
	ld bc, SCREEN_WIDTH + 1
	add hl, bc
	ld a, [wMenuDataItems]
	ld b, a
	ld c, 0
.loop
	ld a, [wMenuScrollPosition]
	add c
	ld [wScrollingMenuCursorPosition], a
	ld a, c
	call ScrollingMenu_GetListItemCoordAndFunctionArgs
	ld a, [wMenuSelection]
	cp -1
	jr z, .cancel
	push bc
	push hl
	call ScrollingMenu_CallFunctions1and2
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	inc c
	ld a, c
	cp b
	jr nz, .loop
	ld a, [wMenuBorderBottomCoord]
	ld b, a
	ld a, [wMenuBorderRightCoord]
	ld c, a
	call Coord2Tile
	ld [hl], '▼'
	ret

.cancel
	ld a, [wMenuDataHeaderEnd]
	bit SCROLLINGMENU_CALL_FUNCTION1_CANCEL_F, a
	jr nz, .call_function
	ld de, .CancelString
	call PlaceString
	ret

.CancelString:
	db "やめる@"

.call_function
	ld d, h
	ld e, l
	ld hl, wMenuData_ScrollingMenuFunction1
	jp CallPointerAt

ScrollingMenu_CallFunctions1and2::
	push hl
	ld d, h
	ld e, l
	ld hl, wMenuData_ScrollingMenuFunction1
	call CallPointerAt
	pop hl
	ld a, [wMenuDataIndicesPointer]
	and a
	jr z, .done
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	ld hl, wMenuData_ScrollingMenuFunction2
	call CallPointerAt
.done
	ret

ScrollingMenu_PlaceCursor:
	ld a, [wSelectedSwapPosition]
	and a
	jr z, .done
	ld b, a
	ld a, [wMenuScrollPosition]
	cp b
	jr nc, .done
	ld c, a
	ld a, [wMenuData_ScrollingMenuHeight]
	add c
	cp b
	jr c, .done
	ld a, b
	sub c
	dec a
	add a
	add $1
	ld c, a
	ld a, [wMenuBorderTopCoord]
	add c
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	add $0
	ld c, a
	call Coord2Tile
	ld [hl], '▷'

.done
	ret

; Seems to be more specialized compared to the final game...
; It automatically draws a text box and predefines a decoord.
ScrollingMenu_CheckCallFunction3:
	ld a, [wMenuDataFlags]
	bit SCROLLINGMENU_ENABLE_FUNCTION3_F, a
	ret z
	hlcoord 0, 12
	ld b, 4
	ld c, SCREEN_HEIGHT
	call DrawTextBox
	ld a, [wMenuCursorY]
	dec a
	call ScrollingMenu_GetListItemCoordAndFunctionArgs
	ld a, [wMenuSelection]
	cp -1
	jr z, .done
	decoord 1, 14
	ld hl, wMenuData_ScrollingMenuFunction3
	call CallPointerAt
	ret

.done
	ret

ScrollingMenu_GetListItemCoordAndFunctionArgs::
	push de
	push hl
	ld e, a
	ld a, [wMenuScrollPosition]
	add e
	ld e, a
	ld d, 0
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [wMenuData_ScrollingMenuItemFormat]
	cp SCROLLINGMENU_ITEMS_NORMAL
	jr z, .got_spacing
	cp SCROLLINGMENU_ITEMS_QUANTITY
	jr z, .pointless_jump
	cp SCROLLINGMENU_BALL_POCKET
	jr z, .ball_pocket

.pointless_jump
	add hl, de
.got_spacing
	add hl, de
	ld a, [wMenuData_ItemsPointerBank]
	call GetFarByte
	ld [wMenuSelection], a
	ld [wCurItem], a
	inc hl
	ld a, [wMenuData_ItemsPointerBank]
	call GetFarByte
	ld [wMenuSelectionQuantity], a
	pop hl
	pop de
	ret

.ball_pocket:
	ld a, [wScrollingMenuListSize]
	ld d, a
	ld a, e
	cp d ; if menu scroll position <= menu list size
	jr nc, .failure
	inc e
	ld d, 0
.loop
	inc d
	ld a, [hli]
	and a
	jr z, .loop
	dec e
	jr nz, .loop
	dec hl
	dec d
	push bc
	push hl
	ld c, d
	callfar GetBallByIndex
	ld d, c
	pop hl
	pop bc
	jr .done

.failure
	ld d, -1
.done
	ld a, d
	ld [wMenuSelection], a
	ld [wCurItem], a
	ld a, [hl]
	ld [wMenuSelectionQuantity], a
	pop hl
	pop de
	ret
