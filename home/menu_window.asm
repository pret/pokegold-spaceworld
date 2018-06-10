include "constants.asm"

SECTION "Menu Window Functions", ROM0 [$1bf4]

PushWindow:: ; 00:1bf4
	ld hl, PlaceWaitingText
	ld a, $9
	jp FarCall_hl

ExitMenu:: ; 00:1bfc
	push af
	callab _ExitMenu
	call Function1c0a
	pop af
	ret

Function1c0a:: ; 00:1c0a
	ld a, [wVramState]
	bit 0, a
	ret z

	xor a
	call OpenSRAM
	hlcoord 0, 0
	ld de, sSpriteBuffer0
	ld bc, $168
	call CopyBytes
	call CloseSRAM

	call LoadMapPart

	xor a
	call OpenSRAM
	ld hl, sSpriteBuffer0
	decoord 0, 0
	ld bc, $168
.asm_1c33: ; 00:1c33
	ld a, [hl]
	cp $61
	jr c, .asm_1c39
	ld [de], a
.asm_1c39: ; 00:1c39
	inc hl
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .asm_1c33
	call CloseSRAM

	ret

InitVerticalMenuCursor:: ; 00:1c44
	jpab _InitVerticalMenuCursor

CloseWindow:: ; 00:1c4c
	push af
	call ExitMenu
	call WaitBGMap
	call UpdateSprites
	pop af
	ret

Function1c58::
	jpab Function24185

RestoreTileBackup:: ; 00:1c60
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	inc b
	inc c
.asm_1c68: ; 00:1c68
	push bc
	push hl
.asm_1c6a: ; 00:1c6a
	ld a, [de]
	ld [hli], a
	dec de
	dec c
	jr nz, .asm_1c6a
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_1c68
	ret

PopWindow:: ; 00:1c7a
	ld b, $10
	ld de, wMenuDataHeader
.asm_1c7f: ; 00:1c7f
	ld a, [hld]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_1c7f
	ret

GetMenuBoxDims:: ; 00:1c86
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

CopyMenuData:: ; 00:1c96
	push hl
	push de
	push bc
	push af
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wMenuDataFlags
	ld bc, $10
	call CopyBytes
	pop af
	pop bc
	pop de
	pop hl
	ret

GetWindowStackTop:: ; 00:1cae
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

PlaceVerticalMenuItems:: ; 00:1cb9
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
.asm_1ccc: ; 00:1ccc
	push bc
	call PlaceString
	inc de
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_1ccc

	ld a, [wMenuDataFlags]
	bit 4, a
	ret z

	call MenuBoxCoord2Tile
	ld a, [de]
	ld c, a
	inc de
	ld b, $0
	add hl, bc
	jp PlaceString

MenuBox:: ; 00:1ceb
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	dec b
	dec c
	jp DrawTextBox

GetMenuTextStartCoord:: ; 00:1cf6
	ld a, [wMenuBorderTopCoord]
	ld b, a
	inc b
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	inc c
	ld a, [wMenuDataFlags]
	bit 6, a
	jr nz, .asm_1d08
	inc b
.asm_1d08: ; 00:1d08
	ld a, [wMenuDataFlags]
	bit 7, a
	jr z, .asm_1d10
	inc c
.asm_1d10: ; 00:1d10
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

MenuBoxCoord2Tile:: ; 00:1d2d
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	ld a, [wMenuBorderTopCoord]
	ld b, a
Coord2Tile:: ; 00:1d35
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
