include "constants.asm"

SECTION "Window related functions", ROM0 [$1E58]

OpenMenu:: ; 00:1e58
	call Function1c96
	call GetMenuIndexSet
	push de
	ld a, [wMenuCursorBuffer]
	push af
	call Function1e8a
	pop af
	ld [wMenuCursorBuffer], a
	call AutomaticGetMenuBottomCoord
	call Function1bf4
	call Function1ceb
	pop de
	call GetMenuIndexSet
	push de
	call RunMenuItemPrintingFunction
	ld a, $1
	ldh [hBGMapMode], a
	call Function17a8
	call GetMenuIndexSet
	pop de
	call Function1f27
	ret

Function1e8a:: ; 00:1e8a
	xor a
	ldh [hBGMapMode], a
	xor a
	call OpenSRAM
	call Function1cae
	ld a, l
	ld [wWindowStackPointer], a
	ld a, h
	ld [wWindowStackPointer + 1], a
	call Function1c7a
	ld d, h
	ld e, l
	call Function1c60
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
	call Function1c86
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
	call Function1a7c
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

RefreshScreen::
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; and BANK(LoadFonts_NoOAMUpdate)
	call Bankswitch

	call ReanchorBGMap_NoOAMUpdate
	call LoadFonts_NoOAMUpdate

	pop af
	call Bankswitch
	ret

Function1fea::
	call Function3171
	call ClearWindowData
	call Function202c
	ret
