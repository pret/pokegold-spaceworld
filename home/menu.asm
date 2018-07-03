include "constants.asm"

SECTION "home/menu.asm", ROM0

LoadMenuHeader:: ; 00:1d49
	call CopyMenuHeader
	call PushWindow
	ret

CopyMenuHeader:: ; 00:1d50
	ld de, wMenuDataHeader
	ld bc, $10
	jp CopyBytes

MenuTextBox:: ; 00:1d59
	push hl
	ld hl, .Data
	call LoadMenuHeader
	pop hl
	jp PrintText

; unused
	ret

.Data: ; 00:1d65
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

.Data: ; 00:1d7b
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw 0
	db 1 ; default option

Call_ExitMenu::
	call ExitMenu
	ret

VerticalMenu:: ; 00:1d87
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call WaitBGMap
	call CopyMenuData
	ld a, [wMenuData2]
	bit 7, a
	jr z, .asm_1daa
	call InitVerticalMenuCursor
	call Get2DMenuJoypad
	bit 1, a
	jr z, .asm_1dac
.asm_1daa: ; 00:1daa
	scf
	ret

.asm_1dac: ; 00:1dac
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
	lb bc, 14, 7
	jr asm_1ddc

PlaceGenericTwoOptionBox::
	call LoadMenuHeader
	jr asm_1df9

asm_1ddc: ; 00:1ddc
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
asm_1df9: ; 00:1df9
	call VerticalMenu
	push af
	ld c, 15
	call DelayFrames
	call CloseWindow
	pop af
	jr c, .asm_1e11
	ld a, [wMenuCursorY]
	cp $2
	jr z, .asm_1e11
	and a
	ret

.asm_1e11: ; 00:1e11
	ld a, $2
	ld [wMenuCursorY], a
	scf
	ret

YesNoMenuHeader:: ; 00:1e18
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

_OffsetMenuHeader:: ; 00:1e30
	push de
	call CopyMenuHeader
	pop de
	ld a, [wMenuBorderLeftCoord]
	ld h, a
	ld a, [wMenuBorderRightCoord]
	sub h
.asm_1e3d: ; 00:1e3d
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

OpenMenu:: ; 00:1e58
	call CopyMenuData
	call GetMenuIndexSet
	push de
	ld a, [wMenuCursorBuffer]
	push af
	call Function1e8a
	pop af
	ld [wMenuCursorBuffer], a
	call AutomaticGetMenuBottomCoord
	call PushWindow
	call MenuBox
	pop de
	call GetMenuIndexSet
	push de
	call RunMenuItemPrintingFunction
	ld a, $1
	ldh [hBGMapMode], a
	call UpdateSprites
	call GetMenuIndexSet
	pop de
	call Function1f27
	ret

Function1e8a:: ; 00:1e8a
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

AutomaticGetMenuBottomCoord:: ; 00:1eac
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

GetMenuIndexSet:: ; 00:1ec3
	ld hl, wMenuDataIndicesPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wWhichIndexSet]
	and a
	jr z, .asm_1ed9
	ld b, a
	ld c, -1
.asm_1ed2: ; 00:1ed2
	ld a, [hli]
	cp c
	jr nz, .asm_1ed2
	dec b
	jr nz, .asm_1ed2
.asm_1ed9: ; 00:1ed9
	ld d, h
	ld e, l
	inc hl
	ld c, $ff
.asm_1ede: ; 00:1ede
	inc c
	ld a, [hli]
	cp $ff
	jr nz, .asm_1ede
	ld a, c
	ld [wMenuDataItems], a
	ret

Function1ee9:: ; 1ee9
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	ld a, [wMenuDataItems]
	add a
	cp b
	jr nc, .asm_1ef9
	ld b, a
	dec c
	ret

.asm_1ef9: ; 00:1ef9
	ld a, b
	srl a
	dec a
	ld [wMenuDataItems], a
	dec c
	ret

RunMenuItemPrintingFunction:: ; 00:1f02
	call MenuBoxCoord2Tile
	ld bc, 2 * SCREEN_WIDTH + 2
	add hl, bc
.asm_1f09: ; 00:1f09
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
	jr .asm_1f09

._hl_:
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Function1f27:: ; 00:1f27
; Combines Crystal functions "InitMenuCursorAndButtonPermissions" and "GetStaticMenuJoypad"
	push de
	call InitVerticalMenuCursor
	ld hl, wMenuJoypadFilter
	ld a, [wMenuData2]
	bit 3, a
	jr z, .asm_1f37
	set 3, [hl]
.asm_1f37: ; 00:1f37
	bit 2, a
	jr z, .asm_1f3f
	ld a, [hl]
	or D_LEFT | D_RIGHT
	ld [hl], a
.asm_1f3f: ; 00:1f3f
	call Get2DMenuJoypad
	pop de
	bit 0, a
	jr nz, .asm_1f66
	bit 1, a
	jr nz, .asm_1f7e
	bit 3, a
	jr nz, .asm_1f7e
	bit 4, a
	jr nz, .asm_1f58
	bit 5, a
	jr nz, .asm_1f5f
	ret

.asm_1f58: ; 00:1f58
	ld a, D_RIGHT
	ld [wMenuJoypad], a
	jr .asm_1f6b

.asm_1f5f: ; 00:1f5f
	ld a, D_LEFT
	ld [wMenuJoypad], a
	jr .asm_1f6b

.asm_1f66: ; 00:1f66
	ld a, A_BUTTON
	ld [wMenuJoypad], a
.asm_1f6b: ; 00:1f6b
	ld a, [wMenuCursorY]
	ld l, a
	ld h, $0
	add hl, de
	ld a, [hl]
	ld [wMenuSelection], a
	ld a, [wMenuCursorY]
	ld [wMenuCursorBuffer], a
	and a
	ret

.asm_1f7e: ; 00:1f7e
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

ClearWindowData:: ; 00:1f9e
	ld hl, wWindowStackPointer
	call .bytefill
	ld hl, wMenuDataHeader
	call .bytefill
	ld hl, wMenuData2
	call .bytefill
	ld hl, wMenuData3
	call .bytefill

	xor a
	call OpenSRAM

	xor a
	ld hl, sWindowStackTop + 1
	ld [hld], a
	ld [hld], a
	ld a, l
	ld [wWindowStackPointer], a
	ld a, h
	ld [wWindowStackPointer + 1], a

	call CloseSRAM
	ret

.bytefill: ; 00:1fcc
	ld bc, 16
	xor a
	call ByteFill
	ret