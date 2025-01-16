INCLUDE "constants.asm"

SECTION "home/menu_window.asm", ROM0

SetMenuAttributes::
	push hl
	push bc
	ld hl, wMenuData3
	ld b, $8
.asm_1a6b:
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .asm_1a6b
	ld a, $1
	ld [hli], a
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	pop bc
	pop hl
	ret

Get2DMenuJoypad::
	call Place2DMenuCursor
Get2DMenuJoypad_NoPlaceCursor::
	ld hl, w2DMenuFlags + 1
	res 7, [hl]
.loop:
	call Move2DMenuCursor
	call WaitBGMap
.asm_1a8a:
	call UpdateTime
	call UpdateTimeOfDayPalettes
	call Menu_WasButtonPressed
	jr c, .asm_1a9f
	ld a, [w2DMenuFlags]
	bit 7, a
	jp nz, .done
	jr .asm_1a8a

.asm_1a9f:
	call _2DMenuInterpretJoypad
	jp c, .done
	ld a, [w2DMenuFlags]
	bit 7, a
	jr nz, .done
	ldh a, [hJoySum]
	ld b, a
	ld a, [wMenuJoypadFilter]
	and b
	jp z, .loop
.done:
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr z, .asm_1ac4
	push de
	ld de, SE_SELECT
	call PlaySFX
	pop de
.asm_1ac4:
	ldh a, [hJoySum]
	ret

Menu_WasButtonPressed::
	ld a, [w2DMenuFlags]
	bit 6, a
	jr z, .asm_1ad6
	farcall PlaySpriteAnimationsAndDelayFrame
.asm_1ad6:
	call GetJoypadDebounced
	ldh a, [hJoySum]
	and a
	ret z
	scf
	ret

_2DMenuInterpretJoypad::
	ldh a, [hJoySum]
	bit A_BUTTON_F, a
	jp nz, .PressedABStartOrSelect
	bit B_BUTTON_F, a
	jp nz, .PressedABStartOrSelect
	bit SELECT_F, a
	jp nz, .PressedABStartOrSelect
	bit START_F, a
	jp nz, .PressedABStartOrSelect
	bit D_RIGHT_F, a
	jr nz, .PressedRight
	bit D_LEFT_F, a
	jr nz, .PressedLeft
	bit D_UP_F, a
	jr nz, .PressedUp
	bit D_DOWN_F, a
	jr nz, .PressedDown
	and a
	ret

.SetFlag15AndCarry:
	ld hl, w2DMenuFlags + 1
	set 7, [hl]
	scf
	ret

.PressedDown:
	ld hl, wMenuCursorY
	ld a, [w2DMenuNumRows]
	cp [hl]
	jr z, .asm_1b1a
	inc [hl]
	xor a
	ret

.asm_1b1a:
	ld a, [w2DMenuFlags]
	bit 5, a
	jr nz, .asm_1b28
	bit 3, a
	jp nz, .SetFlag15AndCarry
	xor a
	ret

.asm_1b28:
	ld [hl], $1
	xor a
	ret

.PressedUp:
	ld hl, wMenuCursorY
	ld a, [hl]
	dec a
	jr z, .asm_1b36
	ld [hl], a
	xor a
	ret

.asm_1b36:
	ld a, [w2DMenuFlags]
	bit 5, a
	jr nz, .asm_1b44
	bit 2, a
	jp nz, .SetFlag15AndCarry
	xor a
	ret

.asm_1b44:
	ld a, [w2DMenuNumRows]
	ld [hl], a
	xor a
	ret

.PressedLeft:
	ld hl, wMenuCursorX
	ld a, [hl]
	dec a
	jr z, .asm_1b54
	ld [hl], a
	xor a
	ret

.asm_1b54:
	ld a, [w2DMenuFlags]
	bit 4, a
	jr nz, .asm_1b62
	bit 1, a
	jp nz, .SetFlag15AndCarry
	xor a
	ret

.asm_1b62:
	ld a, [w2DMenuNumCols]
	ld [hl], a
	xor a
	ret

.PressedRight:
	ld hl, wMenuCursorX
	ld a, [w2DMenuNumCols]
	cp [hl]
	jr z, .asm_1b74
	inc [hl]
	xor a
	ret

.asm_1b74:
	ld a, [w2DMenuFlags]
	bit 4, a
	jr nz, .asm_1b82
	bit 0, a
	jp nz, .SetFlag15AndCarry
	xor a
	ret

.asm_1b82:
	ld [hl], $1
	xor a
	ret

.PressedABStartOrSelect:
	xor a
	ret

Move2DMenuCursor::
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	cp $ed
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
	jr z, .asm_1bb6
.asm_1bb2:
	add c
	dec b
	jr nz, .asm_1bb2
.asm_1bb6:
	ld c, SCREEN_WIDTH
	call AddNTimes
	ld a, [w2DMenuCursorOffsets]
	and $f
	ld c, a
	ld a, [wMenuCursorX]
	ld b, a
	xor a
	dec b
	jr z, .asm_1bcd
.asm_1bc9:
	add c
	dec b
	jr nz, .asm_1bc9
.asm_1bcd:
	ld c, a
	add hl, bc
	ld a, [hl]
	cp $ed
	jr z, .asm_1bd9
	ld [wCursorOffCharacter], a
	ld [hl], $ed
.asm_1bd9:
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
	ld [hl], $ec
	ret

HideCursor::
	ld hl, wCursorCurrentTile
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], $7f
	ret

PushWindow::
	ld hl, PlaceWaitingText
	ld a, $9
	jp FarCall_hl

ExitMenu::
	push af
	callfar _ExitMenu
	call Function1c0a
	pop af
	ret

Function1c0a::
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
.asm_1c33:
	ld a, [hl]
	cp $61
	jr c, .asm_1c39
	ld [de], a
.asm_1c39:
	inc hl
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .asm_1c33
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

Function1c58::
	jpfar Function24185

RestoreTileBackup::
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	inc b
	inc c
.asm_1c68:
	push bc
	push hl
.asm_1c6a:
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

PopWindow::
	ld b, $10
	ld de, wMenuDataHeader
.asm_1c7f:
	ld a, [hld]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_1c7f
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
	ld bc, $10
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
.asm_1ccc:
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
	ld a, [wMenuDataFlags]
	bit 6, a
	jr nz, .asm_1d08
	inc b
.asm_1d08
	ld a, [wMenuDataFlags]
	bit 7, a
	jr z, .done
	inc c
.done
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
