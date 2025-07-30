INCLUDE "constants.asm"

SECTION "home/menu.asm", ROM0

LoadMenuHeader::
	call CopyMenuHeader
	call PushWindow
	ret

CopyMenuHeader::
	ld de, wMenuDataHeader
	ld bc, wMenuDataHeaderEnd - wMenuDataHeader
	jp CopyBytes

MenuTextBox::
	push hl
	ld hl, .Data
	call LoadMenuHeader
	pop hl
	jp PrintText

; unused
	ret

.Data:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw VRAM_Begin
	db 0 ; default option

MenuTextBoxBackup::
	call MenuTextBox
	call CloseWindow
	ret

LoadStandardMenuHeader::
	ld hl, .Data
	call LoadMenuHeader
	ret

.Data:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw NULL
	db 1 ; default option

Call_ExitMenu::
	call ExitMenu
	ret

VerticalMenu::
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call WaitBGMap
	call CopyMenuData
	ld a, [wMenuData]
	bit STATICMENU_CURSOR_F, a
	jr z, .cancel
	call InitVerticalMenuCursor
	call StaticMenuJoypad
	bit B_BUTTON_F, a
	jr z, .okay
.cancel
	scf
	ret

.okay
	and a
	ret

GetMenu2::
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	ret

CopyNameFromMenu::
	push hl
	push bc
	push af
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	pop af
	call GetNthString
	ld d, h
	ld e, l
	call CopyStringToStringBuffer2
	pop bc
	pop hl
	ret

YesNoBox::
	lb bc, SCREEN_WIDTH - 6, 7
PlaceYesNoBox::
	jr _YesNoBox

; Unreferenced?
PlaceGenericTwoOptionBox::
	call LoadMenuHeader
	jr InterpretTwoOptionMenu

; Return nc (yes) or c (no).
_YesNoBox::
	push bc
	ld hl, YesNoMenuHeader
	call CopyMenuHeader
	pop bc

	ld a, b
	ld [wMenuBorderLeftCoord], a
	add 5
	ld [wMenuBorderRightCoord], a
	ld a, c
	ld [wMenuBorderTopCoord], a
	add 4
	ld [wMenuBorderBottomCoord], a
	call PushWindow

InterpretTwoOptionMenu::
	call VerticalMenu
	push af
	ld c, 15
	call DelayFrames
	
	call CloseWindow
	pop af
	jr c, .no
	ld a, [wMenuCursorY]
	cp 2 ; no
	jr z, .no
	and a
	ret

.no
	ld a, 2
	ld [wMenuCursorY], a
	scf
	ret

YesNoMenuHeader::
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 5, 15, 9
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 2
	db "はい@"
	db "いいえ@"

OffsetMenuHeader::
	call _OffsetMenuHeader
	call PushWindow
	ret

_OffsetMenuHeader::
	push de
	call CopyMenuHeader
	pop de
	ld a, [wMenuBorderLeftCoord]
	ld h, a
	ld a, [wMenuBorderRightCoord]
	sub h
	ld h, a
	ld a, d
	ld [wMenuBorderLeftCoord], a
	add h
	ld [wMenuBorderRightCoord], a
	ld a, [wMenuBorderTopCoord]
	ld l, a
	ld a, [wMenuBorderBottomCoord]
	sub l
	ld l, a
	ld a, e
	ld [wMenuBorderTopCoord], a
	add l
	ld [wMenuBorderBottomCoord], a
	ret

OpenMenu::
	call CopyMenuData
	call GetMenuIndexSet
	push de
	ld a, [wMenuCursorPosition]
	push af
	call .ExitMenu_NoPoppingError
	pop af
	ld [wMenuCursorPosition], a
	call AutomaticGetMenuBottomCoord
	call PushWindow
	call MenuBox
	pop de
	call GetMenuIndexSet
	push de
	call RunMenuItemPrintingFunction
	ld a, 1
	ldh [hBGMapMode], a
	call UpdateSprites
	call GetMenuIndexSet
	pop de
	call GetStaticMenuJoypad
	ret

; Unlike _ExitMenu, there is no error for trying to pop a window when none are available.
.ExitMenu_NoPoppingError:
	xor a
	ldh [hBGMapMode], a

	xor a
	call OpenSRAM
	call GetWindowStackTop
	ld a, l
	ld [wWindowStackPointer], a
	ld a, h
	ld [wWindowStackPointer + 1], a
	call PopWindow
	ld d, h
	ld e, l
	call RestoreTileBackup
	call CloseSRAM
	ld hl, wWindowStackSize
	dec [hl]
	ret

AutomaticGetMenuBottomCoord::
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	ld a, [wMenuBorderRightCoord]
	sub c
	ld c, a
	ld a, [wMenuDataItems]
	add a
	inc a
	ld b, a
	ld a, [wMenuBorderTopCoord]
	add b
	ld [wMenuBorderBottomCoord], a
	ret

GetMenuIndexSet::
	ld hl, wMenuDataIndicesPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wWhichIndexSet]
	and a
	jr z, .skip
	ld b, a
	ld c, -1
.loop
	ld a, [hli]
	cp c
	jr nz, .loop
	dec b
	jr nz, .loop

.skip
	ld d, h
	ld e, l
	inc hl
	ld c, -1
.not_terminator
	inc c
	ld a, [hli]
	cp -1
	jr nz, .not_terminator
	ld a, c
	ld [wMenuDataItems], a
	ret

; Unreferenced?
Function1ee9::
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	ld a, [wMenuDataItems]
	add a
	cp b
	jr nc, .asm_1ef9
	ld b, a
	dec c
	ret

.asm_1ef9:
	ld a, b
	srl a
	dec a
	ld [wMenuDataItems], a
	dec c
	ret

RunMenuItemPrintingFunction::
	call MenuBoxCoord2Tile
	ld bc, 2 * SCREEN_WIDTH + 2
	add hl, bc
.loop
	inc de
	ld a, [de]
	cp -1
	ret z
	ld [wMenuSelection], a
	push de
	push hl
	ld d, h
	ld e, l
	ld hl, wMenuDataDisplayFunctionPointer
	call ._hl_
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop de
	jr .loop

._hl_
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

; Combines pokegold functions "InitMenuCursorAndButtonPermissions" and "GetStaticMenuJoypad".
GetStaticMenuJoypad::
	push de
	call InitVerticalMenuCursor
	ld hl, wMenuJoypadFilter
	ld a, [wMenuDataFlags]
	bit STATICMENU_ENABLE_START_F, a
	jr z, .disallow_start
	set START_F, [hl]

.disallow_start
	bit STATICMENU_ENABLE_LEFT_RIGHT_F, a
	jr z, .disallow_left_right
	ld a, [hl]
	or D_LEFT | D_RIGHT
	ld [hl], a

.disallow_left_right:
	call StaticMenuJoypad
	pop de
	bit A_BUTTON_F, a
	jr nz, .a_pressed
	bit B_BUTTON_F, a
	jr nz, .b_start_pressed
	bit START_F, a
	jr nz, .b_start_pressed
	bit D_RIGHT_F, a
	jr nz, .right_pressed
	bit D_LEFT_F, a
	jr nz, .left_pressed
	ret

.right_pressed
	ld a, D_RIGHT
	ld [wMenuJoypad], a
	jr .move_cursor

.left_pressed
	ld a, D_LEFT
	ld [wMenuJoypad], a
	jr .move_cursor

.a_pressed
	ld a, A_BUTTON
	ld [wMenuJoypad], a
.move_cursor
	ld a, [wMenuCursorY]
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	ld [wMenuSelection], a
	ld a, [wMenuCursorY]
	ld [wMenuCursorPosition], a
	and a
	ret

.b_start_pressed
	ld a, B_BUTTON
	ld [wMenuJoypad], a
	ld a, -1
	ld [wMenuSelection], a
	scf
	ret

PlaceMenuStrings::
	push de
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMenuSelection]
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ret

ClearWindowData::
	ld hl, wWindowStackPointer
	call .ClearMenuData
	ld hl, wMenuDataHeader
	call .ClearMenuData
	ld hl, wMenuData
	call .ClearMenuData
	ld hl, wMoreMenuData
	call .ClearMenuData

	xor a
	call OpenSRAM

	xor a
	ld hl, sWindowStackTop
	ld [hld], a
	ld [hld], a
	ld a, l
	ld [wWindowStackPointer], a
	ld a, h
	ld [wWindowStackPointer + 1], a

	call CloseSRAM
	ret

.ClearMenuData:
	ld bc, wMenuDataHeaderEnd - wMenuDataHeader
	xor a
	call ByteFill
	ret
