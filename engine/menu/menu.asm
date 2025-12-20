INCLUDE "constants.asm"

SECTION "engine/menu/menu.asm", ROMX

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
	text "ウィンドウセーブエリアが"
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
