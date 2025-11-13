INCLUDE "constants.asm"

SECTION "home/menu_window.asm", ROM0

SetMenuAttributes::
	push hl
	push bc
	ld hl, wMoreMenuData
	ld b, w2DMenuDataEnd - wMoreMenuData
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop

	ld a, 1
	ld [hli], a ; wMenuCursorY
	ld [hli], a ; wMenuCursorX
	xor a
	ld [hli], a ; wCursorOffCharacter
	ld [hli], a ; wCursorCurrentTile
	ld [hli], a
	pop bc
	pop hl
	ret

StaticMenuJoypad::
	call Place2DMenuCursor
ScrollingMenuJoypad::
	ld hl, w2DMenuFlags2
	res _2DMENU_DISABLE_JOYPAD_FILTER_F, [hl]

.menu_joypad_loop
	call Move2DMenuCursor
	call WaitBGMap

.loopRTC
	call UpdateTime
	call UpdateTimeOfDayPalettes
	call Menu_WasButtonPressed
	jr c, .pressed
	ld a, [w2DMenuFlags1]
	bit _2DMENU_DISABLE_JOYPAD_FILTER_F, a
	jp nz, .done
	jr .loopRTC

.pressed
	call _2DMenuInterpretJoypad
	jp c, .done
	ld a, [w2DMenuFlags1]
	bit _2DMENU_DISABLE_JOYPAD_FILTER_F, a
	jr nz, .done
	ldh a, [hJoySum]
	ld b, a
	ld a, [wMenuJoypadFilter]
	and b
	jp z, .menu_joypad_loop

.done
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr z, .a_b_not_pressed
	push de
	ld de, SE_SELECT
	call PlaySFX
	pop de
.a_b_not_pressed
	ldh a, [hJoySum]
	ret

Menu_WasButtonPressed::
	ld a, [w2DMenuFlags1]
	bit _2DMENU_ENABLE_SPRITE_ANIMS_F, a
	jr z, .skip_to_joypad
	farcall PlaySpriteAnimationsAndDelayFrame

.skip_to_joypad
	call GetJoypadDebounced
	ldh a, [hJoySum]
	and a
	ret z
	scf
	ret

_2DMenuInterpretJoypad::
	ldh a, [hJoySum]
	bit A_BUTTON_F, a
	jp nz, .a_b_start_select
	bit B_BUTTON_F, a
	jp nz, .a_b_start_select
	bit SELECT_F, a
	jp nz, .a_b_start_select
	bit START_F, a
	jp nz, .a_b_start_select
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit D_LEFT_F, a
	jr nz, .d_left
	bit D_UP_F, a
	jr nz, .d_up
	bit D_DOWN_F, a
	jr nz, .d_down
	and a
	ret

.set_bit_7
	ld hl, w2DMenuFlags2
	set _2DMENU_EXITING_F, [hl]
	scf
	ret

.d_down
	ld hl, wMenuCursorY
	ld a, [w2DMenuNumRows]
	cp [hl]
	jr z, .check_wrap_around_down
	inc [hl]
	xor a
	ret

.check_wrap_around_down
	ld a, [w2DMenuFlags1]
	bit _2DMENU_WRAP_UP_DOWN_F, a
	jr nz, .wrap_around_down
	bit _2DMENU_EXIT_DOWN_F, a
	jp nz, .set_bit_7
	xor a
	ret

.wrap_around_down
	ld [hl], $1
	xor a
	ret

.d_up
	ld hl, wMenuCursorY
	ld a, [hl]
	dec a
	jr z, .check_wrap_around_up
	ld [hl], a
	xor a
	ret

.check_wrap_around_up
	ld a, [w2DMenuFlags1]
	bit _2DMENU_WRAP_UP_DOWN_F, a
	jr nz, .wrap_around_up
	bit _2DMENU_EXIT_UP_F, a
	jp nz, .set_bit_7
	xor a
	ret

.wrap_around_up
	ld a, [w2DMenuNumRows]
	ld [hl], a
	xor a
	ret

.d_left
	ld hl, wMenuCursorX
	ld a, [hl]
	dec a
	jr z, .check_wrap_around_left
	ld [hl], a
	xor a
	ret

.check_wrap_around_left
	ld a, [w2DMenuFlags1]
	bit _2DMENU_WRAP_LEFT_RIGHT_F, a
	jr nz, .wrap_around_left
	bit _2DMENU_EXIT_LEFT_F, a
	jp nz, .set_bit_7
	xor a
	ret

.wrap_around_left
	ld a, [w2DMenuNumCols]
	ld [hl], a
	xor a
	ret

.d_right
	ld hl, wMenuCursorX
	ld a, [w2DMenuNumCols]
	cp [hl]
	jr z, .check_wrap_around_right
	inc [hl]
	xor a
	ret

.check_wrap_around_right
	ld a, [w2DMenuFlags1]
	bit _2DMENU_WRAP_LEFT_RIGHT_F, a
	jr nz, .wrap_around_right
	bit _2DMENU_EXIT_RIGHT_F, a
	jp nz, .set_bit_7
	xor a
	ret

.wrap_around_right
	ld [hl], $1
	xor a
	ret

.a_b_start_select
	xor a
	ret

Move2DMenuCursor::
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	cp '▶'
	jr nz, Place2DMenuCursor
	ld a, [wCursorOffCharacter]
	ld [hl], a
Place2DMenuCursor::
	ld a, [w2DMenuCursorInitY]
	ld b, a
	ld a, [w2DMenuCursorInitX]
	ld c, a
	call Coord2Tile
	ld a, [w2DMenuCursorOffsets]
	swap a
	and $f
	ld c, a
	ld a, [wMenuCursorY]
	ld b, a
	xor a
	dec b
	jr z, .got_row
.row_loop
	add c
	dec b
	jr nz, .row_loop

.got_row
	ld c, SCREEN_WIDTH
	call AddNTimes
	ld a, [w2DMenuCursorOffsets]
	and $f
	ld c, a
	ld a, [wMenuCursorX]
	ld b, a
	xor a
	dec b
	jr z, .got_col
.col_loop
	add c
	dec b
	jr nz, .col_loop

.got_col
	ld c, a
	add hl, bc
	ld a, [hl]
	cp '▶'
	jr z, .cursor_on
	ld [wCursorOffCharacter], a
	ld [hl], '▶'

.cursor_on
	ld a, l
	ld [wCursorCurrentTile], a
	ld a, h
	ld [wCursorCurrentTile + 1], a
	ret

PlaceHollowCursor::
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], '▷'
	ret

HideCursor::
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], '　'
	ret

PushWindow::
	jpfar _PushWindow

ExitMenu::
	push af
	callfar _ExitMenu
	call .ResetBGMap
	pop af
	ret

.ResetBGMap:
	ld a, [wStateFlags]
	bit SPRITE_UPDATES_DISABLED_F, a
	ret z

	xor a ; BANK(sScratch)
	call OpenSRAM
	hlcoord 0, 0
	ld de, sScratch
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	call CloseSRAM

	call LoadMapPart

	xor a
	call OpenSRAM
	ld hl, sScratch
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.copy_loop
	ld a, [hl]
	cp '▲'
	jr c, .skip
	ld [de], a
.skip
	inc hl
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .copy_loop
	call CloseSRAM
	ret

InitVerticalMenuCursor::
	jpfar _InitVerticalMenuCursor

CloseWindow::
	push af
	call ExitMenu
	call WaitBGMap
	call UpdateSprites
	pop af
	ret

; Unreferenced.
ExitAllMenus::
	jpfar _ExitAllMenus

RestoreTileBackup::
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	inc b
	inc c
.row
	push bc
	push hl
.col
	ld a, [de]
	ld [hli], a
	dec de
	dec c
	jr nz, .col

	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

PopWindow::
	ld b, wMenuDataHeaderEnd - wMenuDataHeader
	ld de, wMenuDataHeader
.loop
	ld a, [hld]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret

GetMenuBoxDims::
	push hl
	ld hl, wMenuBorderTopCoord
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	sub b
	ld b, a
	ld a, [hli]
	sub c
	ld c, a
	pop hl
	ret

CopyMenuData::
	push hl
	push de
	push bc
	push af
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wMenuDataFlags
	ld bc, wMenuDataHeaderEnd - wMenuDataHeader
	call CopyBytes
	pop af
	pop bc
	pop de
	pop hl
	ret

GetWindowStackTop::
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

PlaceVerticalMenuItems::
	call CopyMenuData
	ld hl, wMenuDataPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	call GetMenuTextStartCoord
	call Coord2Tile ; hl now contains the tilemap address where we will start printing text.
	inc de
	ld a, [de]
	inc de
	ld b, a
.loop
	push bc
	call PlaceString
	inc de
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop

	ld a, [wMenuDataFlags]
	bit STATICMENU_PLACE_TITLE_F, a
	ret z

	call MenuBoxCoord2Tile
	ld a, [de]
	ld c, a
	inc de
	ld b, 0
	add hl, bc
	jp PlaceString

MenuBox::
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	dec b
	dec c
	jp DrawTextBox

GetMenuTextStartCoord::
	ld a, [wMenuBorderTopCoord]
	ld b, a
	inc b
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	inc c
; if not set, leave extra room on top
	ld a, [wMenuDataFlags]
	bit STATICMENU_NO_TOP_SPACING_F, a
	jr nz, .no_top_spacing
	inc b

.no_top_spacing
; if set, leave extra room on the left
	ld a, [wMenuDataFlags]
	bit STATICMENU_CURSOR_F, a
	jr z, .no_cursor
	inc c

.no_cursor
	ret

ClearMenuBoxInterior::
	call MenuBoxCoord2Tile
	ld bc, SCREEN_WIDTH + 1
	add hl, bc
	call GetMenuBoxDims
	dec b
	dec c
	call ClearBox
	ret

ClearWholeMenuBox::
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	inc c
	inc b
	call ClearBox
	ret

MenuBoxCoord2Tile::
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	ld a, [wMenuBorderTopCoord]
	ld b, a
Coord2Tile::
	xor a
	ld h, a
	ld l, b
	ld a, c
	ld b, h
	ld c, l
	add hl, hl
	add hl, hl
	add hl, bc
	add hl, hl
	add hl, hl
	ld c, a
	xor a
	ld b, a
	add hl, bc
	bccoord 0, 0
	add hl, bc
	ret
