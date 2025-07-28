INCLUDE "constants.asm"

SECTION "engine/dumps/bank09.asm@_PushWindow", ROMX

; START OF: engine/menus/menu.asm

_PushWindow::
	xor a ; BANK(sWindowStack)
	call OpenSRAM

	ld hl, wWindowStackPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	push de

	ld b, wMenuDataHeaderEnd - wMenuDataHeader
	ld hl, wMenuDataHeader
.loop
	ld a, [hli]
	ld [de], a
	dec de
	dec b
	jr nz, .loop

; If bit MENU_BACKUP_TILES_F or MENU_BACKUP_TILES_2_F of the menu flags is set,
; also set bit MENU_RESTORE_TILES_F of the address at 7:[wWindowStackPointer],
; and draw the menu using the coordinates from the header.
; Otherwise, reset bit MENU_RESTORE_TILES_F of 7:[wWindowStackPointer].
	ld a, [wMenuFlags]
	bit MENU_BACKUP_TILES_F, a
	jr nz, .backup_tiles
	bit MENU_BACKUP_TILES_2_F, a
	jr z, .no_backup_tiles

; Don't bother backing up tiles if it doesn't overlap with any other windows.
	push de
	call PushWindow_CheckForOtherWindowOverlap
	pop de
	jr nc, .no_backup_tiles

.backup_tiles
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	set MENU_RESTORE_TILES_F, [hl]
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	inc b
	inc c
	call .CheckForOverflow

.row
	push bc
	push hl
.col
	ld a, [hli]
	ld [de], a
	dec de
	dec c
	jr nz, .col

	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	jr .done

.no_backup_tiles
	pop hl ; last-pushed register was de
	push hl
	ld a, [hld]
	ld l, [hl]
	ld h, a
	res MENU_RESTORE_TILES_F, [hl]

.done
	pop hl ; last-pushed register was de
	call .CheckForOverflow

; Push the previous window address onto the bottom for easy access
	ld a, h
	ld [de], a
	dec de
	ld a, l
	ld [de], a
	dec de

	ld hl, wWindowStackPointer
	ld [hl], e
	inc hl
	ld [hl], d

	call CloseSRAM
	ld hl, wWindowStackSize
	inc [hl]
	ret

; Dummied out in the final game. See _PushWindow.ret in pokegold.
; hl = starting position of search.
; de = ending position of search.
; bc = dimensions of menu box (optional)
.CheckForOverflow:
	push bc
	push de
	push hl
	xor a
	ld l, c
	ld h, 0
	ld c, b
	ld b, 0
	ld a, SCREEN_WIDTH
	call AddNTimes
	ld a, h
	cpl
	ld h, a
	ld a, l
	cpl
	ld l, a
	inc hl
	add hl, de

	ld a, e
	sub LOW(sWindowStackBottom)
	ld a, d
	sbc HIGH(sWindowStackBottom)
	jr c, .window_stack_overflow
	pop hl
	pop de
	pop bc
	ret

.window_stack_overflow:
	ld hl, .WindowSaveAreaOverflowText
	call PrintText
	call WaitBGMap
.indefinite_loop
	nop
	jr .indefinite_loop

.WindowSaveAreaOverflowText:
	text "ウィンドウセーブエりアが"
	next "オーバーしました"
	done

; Returns the carry flag if any of the other windows overlap with the current window.
PushWindow_CheckForOtherWindowOverlap:
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .stack_bottom_reached

	push hl
	dec hl ; top coord
	ld b, [hl]
	dec hl ; left coord
	ld c, [hl]
	dec hl ; bottom coord
	ld d, [hl]
	dec hl ; right coord
	ld e, [hl]
	call .AvoidRedundantTiles
	pop hl
	ret c
	jr .loop

; Check again, but in reverse: if the current window overlaps with any other windows, set the carry flag.
.stack_bottom_reached:
	ld hl, wMenuBorderTopCoord
	ld b, [hl]
	inc hl ; wMenuBorderLeftCoord
	ld c, [hl]
	inc hl ; wMenuBorderBottomCoord
	ld d, [hl]
	inc hl ; wMenuBorderRightCoord
	ld e, [hl]
	inc hl ; not necessary if we're overwriting hl right after
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop2
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ret z

	push hl
	ld a, [hld] ; top coord
	ld l, [hl]  ; left coord
	ld h, a
	call .CheckIfInCoordRange
	pop hl
	ret c
	jr .loop2

.AvoidRedundantTiles:
	ld a, [wMenuBorderTopCoord]
	ld h, a
	ld a, [wMenuBorderLeftCoord]
	ld l, a
	call .CheckIfInCoordRange
	ret c
	ld a, [wMenuBorderBottomCoord]
	ld h, a
	call .CheckIfInCoordRange
	ret c
	ld a, [wMenuBorderRightCoord]
	ld l, a
	call .CheckIfInCoordRange
	ret c
	ld a, [wMenuBorderTopCoord]
	ld h, a
	call .CheckIfInCoordRange
	ret

; If b <= h <= d && c <= l <= e, set carry flag.
; b, h, and d are generally used for vertical positioning, and the others for horizontal positioning.
; It doesn't really matter which one has which, though.
.CheckIfInCoordRange:
	ld a, h
	cp b
	jr c, .out_of_range
	cp d
	jr c, .next_range
	jr nz, .out_of_range
.next_range
	ld a, l
	cp c
	jr c, .out_of_range
	cp e
	jr c, .in_range
	jr nz, .out_of_range
.in_range
	scf
	ret

.out_of_range
	and a
	ret

_ExitMenu::
	xor a
	ldh [hBGMapMode], a

	xor a ; BANK(sWindowStack)
	call OpenSRAM

	call GetWindowStackTop
	ld a, l
	or h
	jp z, Error_Cant_ExitMenu

	ld a, l
	ld [wWindowStackPointer], a
	ld a, h
	ld [wWindowStackPointer + 1], a
	call PopWindow
	ld a, [wMenuFlags]
	bit MENU_RESTORE_TILES_F, a
	jr z, .loop
	ld d, h
	ld e, l
	call RestoreTileBackup

.loop
	call GetWindowStackTop
	ld a, h
	or l
	jr z, .done
	call PopWindow

.done
	call CloseSRAM
	ld hl, wWindowStackSize
	dec [hl]
	ret

Error_Cant_ExitMenu:
	ld hl, .WindowPoppingErrorText
	call PrintText
	call WaitBGMap
.infinite_loop
	jr .infinite_loop

.WindowPoppingErrorText:
	text "ポップできる　ウィンドウが"
	next "ありません！"
	done

_ExitAllMenus::
.loop
	xor a ; BANK(sWindowStack)
	call OpenSRAM
	call GetWindowStackTop
	ld a, l
	or h
	jr z, .stack_bottom_reached

	call _ExitMenu
	jr .loop

.stack_bottom_reached
	call CloseSRAM
	ret

_InitVerticalMenuCursor::
	ld a, [wMenuDataHeaderEnd]
	ld b, a
	ld hl, wMoreMenuData
	ld a, [wMenuBorderTopCoord]
	inc a
	bit STATICMENU_NO_TOP_SPACING_F, b
	jr nz, .skip_offset
	inc a
.skip_offset
	ld [hli], a
; w2DMenuCursorInitX
	ld a, [wMenuBorderLeftCoord]
	inc a
	ld [hli], a
; w2DMenuNumRows
	ld a, [wMenuDataItems]
	ld [hli], a
; w2DMenuNumCols
	ld a, 1
	ld [hli], a
; w2DMenuFlags1
	ld [hl], 0
	bit STATICMENU_WRAP_F, b
	jr z, .skip_bit_5
	set _2DMENU_WRAP_UP_DOWN_F, [hl]
.skip_bit_5
	ld a, [wMenuFlags]
	bit MENU_SPRITE_ANIMS_F, a
	jr z, .skip_bit_6
	set _2DMENU_ENABLE_SPRITE_ANIMS_F, [hl]
.skip_bit_6
	inc hl
; w2DMenuFlags2
	xor a
	ld [hli], a
; w2DMenuCursorOffsets
	ln a, 2, 0
	ld [hli], a
; wMenuJoypadFilter
	ld a, A_BUTTON
	bit STATICMENU_DISABLE_B_F, b
	jr nz, .skip_bit_1
	add B_BUTTON
.skip_bit_1
	ld [hli], a
; wMenuCursorY
	ld a, [wMenuCursorPosition]
	and a
	jr z, .load_at_the_top
	ld c, a
	ld a, [wMenuDataItems]
	cp c
	jr nc, .load_position
.load_at_the_top
	ld c, 1
.load_position
	ld [hl], c
	inc hl
; wMenuCursorX
	ld a, 1
	ld [hli], a
; wCursorOffCharacter, wCursorCurrentTile
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret

; END OF: engine/menus/menu.asm

; START OF: engine/items/update_item_description.asm

UpdateItemDescription::
	ld a, [wMenuSelection]
	ld [wSelectedItem], a
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call DrawTextBox
	decoord 1, 14
	callfar ShowItemDescription
	ret

; START OF: engine/events/pokepic.asm

Pokepic:
	ld a, 1
	ldh [hBGMapMode], a
	ld hl, .PokepicMenuHeader
	call LoadMenuHeader
	call MenuBox
	call UpdateSprites
	ld b, SGB_POKEPIC
	call GetSGBLayout
	xor a
	ldh [hBGMapMode], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld de, vChars1
	call LoadMonFrontSprite
	ld a, [wMenuBorderTopCoord]
	inc a
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	inc a
	ld c, a
	call Coord2Tile
	ld a, $80
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	ld a, 1
	ldh [hBGMapMode], a
	call TextboxWaitPressAorB_BlinkCursor
	call ClearMenuBoxInterior
	call WaitBGMap
	call GetMemSGBLayout
	call CloseWindow
	call LoadFont
	ret

.PokepicMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 6, 4, 14, 13
	dw 0
	db 1

; START OF: engine/menus/scrolling_menu.asm

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
	ld [hl], "　"
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
	ld [hl], "▲"

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
	ld [hl], "▼"
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
	ld [hl], "▷"

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

; END

; START OF: engine/items/switch_items.asm

SwitchItemsInBag::
	ld a, [wSelectedSwapPosition]
	and a
	jr z, .init
	ld b, a
	ld a, [wScrollingMenuCursorPosition]
	inc a
	cp b
	jr z, .trivial
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [hl]
	cp -1
	ret z
	ld a, [wSelectedSwapPosition]
	dec a
	ld [wSelectedSwapPosition], a
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	ld a, [hl]
	pop hl
	cp [hl]
	jr z, .combine_stacks
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld a, [wSelectedSwapPosition]
	cp c
	jr c, .above
	jr .below

.init:
	ld a, [wScrollingMenuCursorPosition]
	inc a
	ld [wSelectedSwapPosition], a
	ret

.trivial:
	xor a
	ld [wSelectedSwapPosition], a
	ret

.below:
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_CopyItemToBuffer
	ld a, [wScrollingMenuCursorPosition]
	ld d, a
	ld a, [wSelectedSwapPosition]
	ld e, a
	call ItemSwitch_GetItemOffset
	push bc
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	dec hl
	push hl
	call ItemSwitch_GetItemFormatSize
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	call ItemSwitch_BackwardsCopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_CopyBufferToItem
	xor a
	ld [wSelectedSwapPosition], a
	ret

.above:
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_CopyItemToBuffer
	ld a, [wScrollingMenuCursorPosition]
	ld d, a
	ld a, [wSelectedSwapPosition]
	ld e, a
	call ItemSwitch_GetItemOffset
	push bc
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	call ItemSwitch_GetItemFormatSize
	add hl, bc
	pop bc
	call CopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_CopyBufferToItem
	xor a
	ld [wSelectedSwapPosition], a
	ret

.combine_stacks:
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	inc hl
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld a, [hl]
	pop hl
	add [hl]
	cp MAX_ITEM_STACK + 1
	jr c, .merge_stacks
	sub MAX_ITEM_STACK
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	ld [hl], MAX_ITEM_STACK
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	xor a
	ld [wSelectedSwapPosition], a
	ret

.merge_stacks:
	push af
	ld a, [wScrollingMenuCursorPosition]
	call ItemSwitch_GetNthItem
	inc hl
	pop af
	ld [hl], a
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSelectedSwapPosition]
	cp [hl]
	jr nz, .not_combining_last_item
	dec [hl]
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	ld [hl], -1 ; end
	xor a
	ld [wSelectedSwapPosition], a
	ret

.not_combining_last_item:
	dec [hl]
	call ItemSwitch_GetItemFormatSize
	push bc
	ld a, [wSelectedSwapPosition]
	call ItemSwitch_GetNthItem
	pop bc
	push hl
	add hl, bc
	pop de
.copy_loop
	ld a, [hli]
	ld [de], a
	inc de
	cp -1 ; end?
	jr nz, .copy_loop
	xor a
	ld [wSelectedSwapPosition], a
	ret

ItemSwitch_CopyItemToBuffer:
	call ItemSwitch_GetNthItem
	ld de, wSwitchItemBuffer
	call ItemSwitch_GetItemFormatSize
	call CopyBytes
	ret

ItemSwitch_CopyBufferToItem:
	call ItemSwitch_GetNthItem
	ld d, h
	ld e, l
	ld hl, wSwitchItemBuffer
	call ItemSwitch_GetItemFormatSize
	call CopyBytes
	ret

ItemSwitch_GetNthItem:
	push af
	call ItemSwitch_GetItemFormatSize
	ld hl, wMenuDataDisplayFunctionPointer + 1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	pop af
	call AddNTimes
	ret

ItemSwitch_GetItemOffset:
	push hl
	call ItemSwitch_GetItemFormatSize
	ld a, d
	sub e
	jr nc, .dont_negate
	dec a
	cpl
.dont_negate
	ld hl, 0
	call AddNTimes
	ld b, h
	ld c, l
	pop hl
	ret

ItemSwitch_GetItemFormatSize:
	push hl
	ld a, [wMenuData_ScrollingMenuItemFormat]
	ld c, a
	ld b, 0
	ld hl, .item_format_sizes
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	ret

.item_format_sizes:
; entries correspond to SCROLLINGMENU_ITEMS_* constants
	dw 0 ; unused
	dw 1 ; SCROLLINGMENU_ITEMS_NORMAL
	dw 2 ; SCROLLINGMENU_ITEMS_QUANTITY

ItemSwitch_BackwardsCopyBytes:
.loop
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

; END OF: engine/items/switch_items.asm

; START OF: engine/menus/menu_2.asm

PlacePackItems::
	ld a, [wMenuSelection]
	cp -1
	jr z, .cancel
	push de
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld e, a
	ld d, 0
	ld hl, .attribute_icons
	add hl, de
	ld a, [hl]
	pop de
	ld [de], a
	inc de
	jr PlaceMenuItemName

.attribute_icons:
	db "　"
	db $62  ; TM Holder icon
	db $64  ; Ball Holder icon
	db $63  ; Key Items icon
	db "　"
	db "　"
	db "　"

.cancel
	ld h, d
	ld l, e
	ld de, .CancelString
	call PlaceString
	ret

.CancelString:
	db "　ーーやめるーー@"

PlaceMenuItemName::
	push de
	ld a, [wMenuSelection]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	pop hl
	call PlaceString
	ret

PlaceMenuItemQuantity::
	push de
	ld a, [wMenuSelection]
	ld [wCurItem], a
	callfar _CheckTossableItem
	ld a, [wItemAttributeValue]
	pop hl
	and a
	jr nz, .done
	ld [hl], "×"
	inc hl
	ld de, wMenuSelectionQuantity
	lb bc, 1, 2
	call PrintNumber
.done
	ret

PlacePartyMonNicknames::
	ld hl, wPartyMonNicknames
	jr PlaceMonNicknames

PlaceBoxMonNicknames::
	ld hl, wBoxMonNicknames
PlaceMonNicknames:
	push de
	ld a, [wScrollingMenuCursorPosition]
	call GetNick
	pop hl
	call PlaceString
	ret

PlacePartyMonLevels::
	ld a, PARTYMON
	ld [wMonType], a
	jr PlaceMonLevels

PlaceBoxMonLevels::
	ld a, BOXMON
	ld [wMonType], a
PlaceMonLevels:
	push de
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	predef CopyMonToTempMon
	pop hl
	call PrintLevel
	ret

; Unreferenced.
	ret

; Prints the names, nicknames, levels, and genders of Pokémon.
PlaceDetailedBoxMonView::
	push de
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld b, 0
	ld hl, wBoxSpecies
	add hl, bc

	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	pop hl
	call PlaceString
	ld de, MON_NAME_LENGTH
	add hl, de
	push hl

	ld a, [wScrollingMenuCursorPosition]
	ld hl, wBoxMonNicknames
	call GetNick
	pop hl
	call PlaceString
	ld de, MON_NAME_LENGTH
	add hl, de
	push hl

	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, BOXMON
	ld [wMonType], a
	predef CopyMonToTempMon
	pop hl
	push hl
	call PrintLevel
	pop hl
	ld de, 3
	add hl, de
	push hl

	callfar GetGender
	ld a, "♂"
	jr c, .male
	ld a, "♀"
.male
	pop hl
	ld [hl], a
	ret

Unreferenced_PlaceMoneyTextbox_Old::
	ld hl, .MenuHeader
	call CopyMenuHeader
	call MenuBox
	call PlaceVerticalMenuItems
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld de, wMoney
	lb bc, PRINTNUM_RIGHTALIGN | 3, 6
	call PrintNumber
	ret

.MenuHeader:
	db 0
	menu_coords 11, 0, SCREEN_WIDTH - 1, 2
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_NO_TOP_SPACING
	db 1
	db "　　　　　　円@"

PlaceMoneyTopRight::
	ld hl, MoneyTopRightMenuHeader
	call CopyMenuHeader
	jr PlaceMoneyTextbox

; Unreferenced.
PlaceMoneyAtTopLeftOfTextbox::
	ld hl, MoneyTopRightMenuHeader
	ld d, 11
	ld e, 0
	call OffsetMenuHeader

PlaceMoneyTextbox:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld de, wMoney
	lb bc, PRINTNUM_RIGHTALIGN | 3, 6
	call PrintNumber
	ld [hl], "円"
	ret

MoneyTopRightMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 11, 0, SCREEN_WIDTH - 1, 2
	dw NULL
	db 1

; An unreferenced, nonfunctional menu that resembles the field debug menu.
Unreferenced_FieldMoveMenu:
	ld hl, .MenuData
	call LoadMenuHeader
	call VerticalMenu
	ret

.MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 6, 10
	dw .MenuText
	db 1

.MenuText:
	db (STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING)
	db 3 ; amount of options
	db "うる@"      ; Switch
	db "かう@"      ; Buy
	db "やめる@"    ; Cancel
	db "くさかり@"   ; "Mower"? (replaced by Uproot)
	db "とんでけ@"   ; "Flight"? (replaced by Wind Ride)
	db "どんぶらこ@" ; "Splash"? (replaced by Water Sport)
	db "フルパワー@" ; "Full Power" (replaced by Strong Arm)
	db "ひかりゴケ@" ; Bright Moss
	db "うずしお@"   ; Whirlpool
	db "とびはねる@" ; Bounce
	db "あなをほる@" ; Dig
	db "テレポート@" ; Teleport
	db "タマゴうみ@" ; Softboiled

; START OF: engine/pokemon/mon_submenu.asm

; MonMenuOptionStrings indexes
	const_def 1
	const MONMENUVALUE_STATS  ; 1
	const MONMENUVALUE_SWITCH ; 2
	const MONMENUVALUE_ITEM   ; 3
	const MONMENUVALUE_CANCEL ; 4
	const MONMENUVALUE_MOVE   ; 5
	const MONMENUVALUE_MAIL   ; 6
	const MONMENUVALUE_ERROR  ; 7
DEF NUM_MONMENUVALUES EQU const_value - 1

MonMenuOptionStrings:
	db "つよさをみる@" ; Stats
	db "ならびかえ@"   ; Switch
	db "そうび@"      ; Item
	db "キャンセル@"   ; Cancel
	db "もちわざ@"     ; Moves
	db "メール@"      ; Mail
	db "エラー！@"     ; Error!

Unreferenced_FieldMoveList:
	db MOVE_UPROOT, MONMENUITEM_CUT
	db MOVE_WIND_RIDE, MONMENUITEM_FLY
	db MOVE_WATER_SPORT, MONMENUITEM_SURF
	db MOVE_STRONG_ARM, MONMENUITEM_STRENGTH
	db MOVE_BRIGHT_MOSS, MONMENUITEM_FLASH
	db MOVE_WHIRLPOOL, MONMENUITEM_WHIRLPOOL
	db MOVE_BOUNCE, MONMENUITEM_BOUNCE
	db MOVE_DIG, MONMENUITEM_DIG
	db MOVE_TELEPORT, MONMENUITEM_TELEPORT
	db MOVE_SOFTBOILED, MONMENUITEM_SOFTBOILED
	db -1

MonMenuOptions:
	db MONMENU_FIELD_MOVE, MONMENUITEM_CUT,        MOVE_UPROOT
	db MONMENU_FIELD_MOVE, MONMENUITEM_FLY,        MOVE_WIND_RIDE
	db MONMENU_FIELD_MOVE, MONMENUITEM_SURF,       MOVE_WATER_SPORT
	db MONMENU_FIELD_MOVE, MONMENUITEM_STRENGTH,   MOVE_STRONG_ARM
	db MONMENU_FIELD_MOVE, MONMENUITEM_FLASH,      MOVE_BRIGHT_MOSS
	db MONMENU_FIELD_MOVE, MONMENUITEM_WHIRLPOOL,  MOVE_WHIRLPOOL
	db MONMENU_FIELD_MOVE, MONMENUITEM_BOUNCE,     MOVE_BOUNCE
	db MONMENU_FIELD_MOVE, MONMENUITEM_DIG,        MOVE_DIG
	db MONMENU_FIELD_MOVE, MONMENUITEM_TELEPORT,   MOVE_TELEPORT
	db MONMENU_FIELD_MOVE, MONMENUITEM_SOFTBOILED, MOVE_SOFTBOILED
	db MONMENU_MENUOPTION, MONMENUITEM_STATS,      MONMENUVALUE_STATS
	db MONMENU_MENUOPTION, MONMENUITEM_SWITCH,     MONMENUVALUE_SWITCH
	db MONMENU_MENUOPTION, MONMENUITEM_ITEM,       MONMENUVALUE_ITEM
	db MONMENU_MENUOPTION, MONMENUITEM_CANCEL,     MONMENUVALUE_CANCEL
	db MONMENU_MENUOPTION, MONMENUITEM_MOVE,       MONMENUVALUE_MOVE
	db MONMENU_MENUOPTION, MONMENUITEM_MAIL,       MONMENUVALUE_MAIL
	db MONMENU_MENUOPTION, MONMENUITEM_ERROR,      MONMENUVALUE_ERROR
	db -1

MonSubmenu::
	xor a
	ldh [hBGMapMode], a
	call GetMonSubmenuItems
	callfar FreezeMonIcons
	ld hl, .MenuHeader
	call LoadMenuHeader
	call .GetTopCoord
	call PopulateMonMenu
	
	ld a, 1
	ldh [hBGMapMode], a
	call MonMenuLoop
	ld [wMenuSelection], a

	call CloseWindow
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 11, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw 0
	db 1 ; default option

.GetTopCoord:
; [wMenuBorderTopCoord] = 1 + [wMenuBorderBottomCoord] - 2 * ([wMonSubmenuCount] + 1)
	ld a, [wMonSubmenuCount]
	inc a
	add a
	ld b, a
	ld a, [wMenuBorderBottomCoord]
	sub b
	inc a
	ld [wMenuBorderTopCoord], a
	call MenuBox
	ret

MonMenuLoop:
.loop
	ld a, MENU_UNUSED | MENU_BACKUP_TILES_2
	ld [wMenuDataFlags], a
	ld a, [wMonSubmenuCount]
	ld [wMenuDataItems], a
	call InitVerticalMenuCursor

	ld hl, w2DMenuFlags1
	set _2DMENU_ENABLE_SPRITE_ANIMS_F, [hl]

	call StaticMenuJoypad
	ldh a, [hJoyDown]
	bit A_BUTTON_F, a
	jr nz, .select
	bit B_BUTTON_F, a
	jr nz, .cancel
	jr .loop

.cancel
	ld a, MONMENUITEM_CANCEL
	ret

.select
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, 0
	ld hl, wMonSubmenuItems
	add hl, bc
	ld a, [hl]
	ret

PopulateMonMenu:
	call MenuBoxCoord2Tile
	ld bc, 2 * SCREEN_WIDTH + 2
	add hl, bc
	ld de, wMonSubmenuItems
.loop
	ld a, [de]
	inc de
	cp -1
	ret z
	push de
	push hl
	call GetMonMenuString
	pop hl
	call PlaceString
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop de
	jr .loop

GetMonMenuString:
	dec a
	ld b, a
	add a
	add b
	ld c, a
	ld b, 0
	ld hl, MonMenuOptions
	add hl, bc
	ld a, [hli]
	and a ; if MONMENU_MENUOPTION
	jr z, .NotMove
	inc hl
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	ret

.NotMove:
	inc hl
	ld a, [hl]
	dec a
	ld hl, MonMenuOptionStrings
	call GetNthString
	ld d, h
	ld e, l
	ret

GetMonSubmenuItems:
	call ResetMonSubmenu
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld hl, wMonSubmenuItems
	ld c, NUM_MOVES

.loop
	push bc
	push de
	ld a, [de]
	and a ; no move in this slot
	jr z, .next

	push hl
	call IsFieldMove

	pop hl
	jr nc, .next
	call AddMonMenuItem

.next
	pop de
	inc de
	pop bc
	dec c
	jr nz, .loop

	ld a, MONMENUITEM_STATS
	call AddMonMenuItem
	ld a, MONMENUITEM_SWITCH
	call AddMonMenuItem
	ld a, MONMENUITEM_MOVE
	call AddMonMenuItem

	push hl
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, [hl]
	pop hl
	cp ITEM_MAIL
	ld a, MONMENUITEM_ITEM
	jr nz, .notmail
	ld a, MONMENUITEM_MAIL

.notmail
	call AddMonMenuItem
	ld a, [wMonSubmenuCount]
	cp NUM_MONMENU_ITEMS
	jr z, .maxitems

	ld a, MONMENUITEM_CANCEL
	call AddMonMenuItem

.maxitems
	call TerminateMonSubmenu
	ret

IsFieldMove:
	ld b, a
	ld hl, MonMenuOptions
.next
	ld a, [hli]
	cp -1
	jr z, .nope
	and a ; MONMENU_MENUOPTION
	jr z, .nope
	ld d, [hl]
	inc hl
	ld a, [hli]
	cp b
	jr nz, .next
	ld a, d
	scf

.nope
	ret

ResetMonSubmenu:
	xor a
	ld [wMonSubmenuCount], a
	ld hl, wMonSubmenuItems
	ld bc, NUM_MONMENU_ITEMS + 1
	call ByteFill
	ret

TerminateMonSubmenu:
	ld a, [wMonSubmenuCount]
	ld e, a
	ld d, 0
	ld hl, wMonSubmenuItems
	add hl, de
	ld [hl], -1
	ret

AddMonMenuItem:
	push hl
	push de
	push af
	ld a, [wMonSubmenuCount]
	ld e, a
	inc a
	ld [wMonSubmenuCount], a
	ld d, 0
	ld hl, wMonSubmenuItems
	add hl, de
	pop af
	ld [hl], a
	pop de
	pop hl
	ret

BattleMonMenu:
	ld hl, .MenuHeader
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call WaitBGMap

	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wMenuData
	ld bc, wMenuDataEnd - wMenuData
	call CopyBytes

	ld a, [wMenuDataFlags]
	bit STATICMENU_CURSOR_F, a
	jr z, .set_carry
	call InitVerticalMenuCursor
	ld hl, w2DMenuFlags1
	set _2DMENU_ENABLE_SPRITE_ANIMS_F, [hl]
	call StaticMenuJoypad
	bit B_BUTTON_F, a
	jr z, .clear_carry
	ret z

.set_carry
	scf
	ret

.clear_carry
	and a
	ret

; Unreferenced.
	ret

.MenuHeader:
	db 0 ; flags
	menu_coords 11, 11, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuText
	db 1 ; default option

.MenuText:
	db (STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING)
	db 3
	db "とりかえる@"   ; Switch
	db "つよさをみる@" ; Stats
	db "キャンセル@"   ; Cancel

; START OF: engine/battle/menu.asm

LoadBattleMenu::
	ld hl, BattleMenuHeader
	jr CommonBattleMenu

; Unreferenced.
SafariBattleMenu::
	ld hl, SafariBattleMenuHeader
	; fallthrough
CommonBattleMenu:
	call LoadMenuHeader
	ld a, [wBattleMenuCursorPosition]
	ld [wMenuCursorPosition], a
	call Battle_2DMenu
	ld a, [wMenuCursorPosition]
	ld [wBattleMenuCursorPosition], a
	call ExitMenu
	ret

BattleMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 9, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	dn 2, 2
	db 5
	db "たたかう@" ; "FIGHT"
	db "どうぐ@"   ; "ITEM"
	db "#@"       ; "<PK><MN>"
	db "にげる@"   ; "RUN"

SafariBattleMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	dn 2, 2
	db 11
	db "サファりボール×　　　@" ; "SAFARI BALL×   @"
	db "エサをなげる@"         ; "THROW BAIT"
	db "いしをなげる@"         ; "THROW ROCK"
	db "にげる@"              ; "RUN"

Battle_2DMenu:
	call CopyMenuData
	call MenuBox
	ld a, [wMenuData_2DMenuDimensions]
	ld b, a
	and $0f
	ld [wBattleMenuRows], a ; rows

	ld a, b
	and $f0
	swap a
	ld [wBattleMenuColumns], a ; columns

	call .PlaceStrings
	call .InitAndHandleCursor
	call StaticMenuJoypad
	ldh a, [hJoySum]
	bit SELECT_F, a
	jr nz, .quit

	ld a, [w2DMenuNumRows]
	ld c, a
	ld a, [wMenuCursorY]
	dec a
	call .GetNewCursorPos
	ld c, a
	ld a, [wMenuCursorX]
	add c
	ld [wMenuCursorPosition], a
	and a
	ret

.quit
	scf
	ret

.GetNewCursorPos:
	and a
	ret z
	push bc
	ld b, a
	xor a
.loop
	add c
	dec b
	jr nz, .loop
	pop bc
	ret

.unreferenced_24baf:
	ld b, 0
.loop2
	inc b
	sub c
	jr nc, .loop2
	dec b
	add c
	ret

.PlaceStrings:
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, 3
	add hl, de
	ld d, h
	ld e, l
	call GetMenuTextStartCoord
	call Coord2Tile
	ld a, [wBattleMenuRows]
	ld b, a
.column_loop
	push bc
	push hl
	ld a, [wBattleMenuColumns]
	ld c, a
.row_loop
	push bc
	call PlaceString
	inc de
	ld a, [wMenuData_2DMenuSpacing]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	dec c
	jr nz, .row_loop
	
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .column_loop
	ret

.InitAndHandleCursor:
	call GetMenuTextStartCoord
	ld a, b
	ld [w2DMenuCursorInitY], a
	dec c
	ld a, c
	ld [w2DMenuCursorInitX], a
	ld a, [wBattleMenuRows]
	ld [w2DMenuNumRows], a
	ld a, [wBattleMenuColumns]
	ld [w2DMenuNumCols], a

	ld a, [wMenuDataFlags]
	ld d, a
	bit STATICMENU_WRAP_F, d
	ld a, 0
	jr z, .no_wrap
	ld a, _2DMENU_WRAP_LEFT_RIGHT | _2DMENU_WRAP_UP_DOWN

.no_wrap
	ld [w2DMenuFlags1], a
	ld a, [wMenuData_2DMenuSpacing]
	or $20
	ld [w2DMenuCursorOffsets], a
	ld a, A_BUTTON | SELECT
	ld [wMenuJoypadFilter], a
	ld a, [w2DMenuNumCols]
	ld e, a
	ld a, [wMenuCursorPosition]
	ld b, a
	xor a
	ld d, 0

.loop3
	inc d
	add e
	cp b
	jr c, .loop3

	sub e
	ld c, a
	ld a, b
	sub c
	and a
	jr z, .left_wrap
	cp e
	jr z, .right_wrap
	jr c, .right_wrap

.left_wrap
	ld a, 1
.right_wrap
	ld [wMenuCursorX], a
	ld a, [w2DMenuNumRows]
	ld e, a
	ld a, d
	and a
	jr z, .up_wrap
	cp e
	jr z, .down_wrap
	jr c, .down_wrap

.up_wrap
	ld a, 1
.down_wrap
	ld [wMenuCursorY], a
	xor a
	ld [wCursorOffCharacter], a
	ld [wCursorCurrentTile], a
	ld [wCursorCurrentTile + 1], a
	ret

; START OF: engine/items/buy_sell_toss.asm

SelectQuantityToToss::
	ld hl, TossItem_MenuHeader
	call LoadMenuHeader
	call Toss_Sell_Loop
	ret

SelectQuantityToBuy::
	callfar GetItemPrice
	ld a, d
	ld [wBuySellItemPrice], a
	ld a, e
	ld [wBuySellItemPrice + 1], a
	ld hl, BuyItem_MenuHeader
	call LoadMenuHeader
	call Toss_Sell_Loop
	ret

Toss_Sell_Loop:
	ld a, 1
	ld [wItemQuantity], a
.preloop
; It won't progress if you're holding the A Button...
	call GetJoypad
	ldh a, [hJoyState]
	bit A_BUTTON_F, a
	jr nz, .preloop

.loop
	call BuySellToss_UpdateQuantityDisplayAndPrice
	call BuySellToss_InterpretJoypad
	jr nc, .loop
	cp -1
	jr nz, .nope ; pressed B
	scf
	ret

.nope
	and a
	ret

BuySellToss_InterpretJoypad:
.loop
	call DelayFrame
	ldh a, [hInMenu]
	push af
	ld a, 1
	ldh [hInMenu], a
	call GetJoypadDebounced
	pop af
	ldh [hInMenu], a

	ldh a, [hJoyDown]
	bit B_BUTTON_F, a
	jr nz, .b
	bit A_BUTTON_F, a
	jr nz, .a

	ldh a, [hJoySum]
	bit D_DOWN_F, a
	jr nz, .down
	bit D_UP_F, a
	jr nz, .up
	bit D_LEFT_F, a
	jr nz, .left
	bit D_RIGHT_F, a
	jr nz, .right
	jr .loop
.b
	ld a, -1
	scf
	ret

.a
	scf
	ret

.down
	ld hl, wItemQuantity
	dec [hl]
	jr nz, .finish_down
	ld a, [wItemQuantityBuffer]
	ld [hl], a

.finish_down
	and a
	ret

.up
	ld hl, wItemQuantity
	inc [hl]
	ld a, [wItemQuantityBuffer]
	cp [hl]
	jr nc, .finish_up
	ld [hl], 1

.finish_up
	and a
	ret

.left
	ld a, [wItemQuantity]
	sub 10
	jr c, .load_1
	jr z, .load_1
	jr .finish_left

.load_1
	ld a, 1

.finish_left
	ld [wItemQuantity], a
	and a
	ret

.right
	ld a, [wItemQuantity]
	add 10
	ld b, a
	ld a, [wItemQuantityBuffer]
	cp b
	jr nc, .finish_right
	ld b, a

.finish_right
	ld a, b
	ld [wItemQuantity], a
	and a
	ret

BuySellToss_UpdateQuantityDisplayAndPrice:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld [hl], "×"
	inc hl
	ld de, wItemQuantity
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	ld a, [wMenuDataPointer]
	cp -1
	ret nz

	xor a
	ldh [hMultiplicand], a
	ld a, [wBuySellItemPrice]
	ldh [hMultiplicand + 1], a
	ld a, [wBuySellItemPrice + 1]
	ldh [hMultiplicand + 2], a
	ld a, [wItemQuantity]
	ldh [hMultiplier], a
	push hl
	call Multiply

	ld hl, hMoneyTemp
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl
	inc hl
	ld de, hMoneyTemp
	lb bc, 4, 6
	call PrintNumber
	ld [hl], "円"
	call WaitBGMap
	ret

TossItem_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 15, 9, $13, 11
	dw NULL
	db 0

BuyItem_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 7, 15, $13, $11
	dw $ff
	db $ff

