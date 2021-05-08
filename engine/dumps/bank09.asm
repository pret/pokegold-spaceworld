INCLUDE "constants.asm"

SECTION "engine/dumps/bank09.asm@Function24000", ROMX

Function24000:
	xor a
	call OpenSRAM
	ld hl, wWindowStackPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	push de
	ld b, $10
	ld hl, wMenuDataHeader
.asm_24010
	ld a, [hli]
	ld [de], a
	dec de
	dec b
	jr nz, .asm_24010
	ld a, [wMenuDataHeader]
	bit 6, a
	jr nz, .asm_24028
	bit 7, a
	jr z, .asm_2404e
	push de
	call asm_240b3
	pop de
	jr nc, .asm_2404e
.asm_24028
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	set 0, [hl]
	call MenuBoxCoord2Tile
	call GetMenuBoxDims
	inc b
	inc c
	call Function2406d

.asm_2403b
	push bc
	push hl
.asm_2403d
	ld a, [hli]
	ld [de], a
	dec de
	dec c
	jr nz, .asm_2403d
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_2403b
	jr .asm_24055

.asm_2404e
	pop hl
	push hl
	ld a, [hld]
	ld l, [hl]
	ld h, a
	res 0, [hl]

.asm_24055
	pop hl
	call Function2406d
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

Function2406d:
	push bc
	push de
	push hl
	xor a
	ld l, c
	ld h, $00
	ld c, b
	ld b, $00
	ld a, $14
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
	sub $00
	ld a, d
	sbc $b8
	jr c, Function24090
	pop hl
	pop de
	pop bc
	ret

Function24090:
	ld hl, .text_2409c
	call PrintText
	call WaitBGMap
.asm_24099
	nop
	jr .asm_24099

.text_2409c:
	text "ウィンドウセーブエりアが"
	next "オーバーしました"
	done

asm_240b3:
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
asm_240b9:
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, asm_240d0
	push hl
	dec hl
	ld b, [hl]
	dec hl
	ld c, [hl]
	dec hl
	ld d, [hl]
	dec hl
	ld e, [hl]
	call asm_240f2
	pop hl
	ret c
	jr asm_240b9
asm_240d0:
	ld hl, wMenuBorderTopCoord
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld hl, wWindowStackPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
asm_240e1:
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	ret z
	push hl
	ld a, [hld]
	ld l, [hl]
	ld h, a
	call asm_24116
	pop hl
	ret c
	jr asm_240e1
asm_240f2:
	ld a, [wMenuBorderTopCoord]
	ld h, a
	ld a, [wMenuBorderLeftCoord]
	ld l, a
	call asm_24116
	ret c
	ld a, [wMenuBorderBottomCoord]
	ld h, a
	call asm_24116
	ret c
	ld a, [wMenuBorderRightCoord]
	ld l, a
	call asm_24116
	ret c
	ld a, [wMenuBorderTopCoord]
	ld h, a
	call asm_24116
	ret

asm_24116:
	ld a, h
	cp b
	jr c, asm_2412a
	cp d
	jr c, asm_2411f
	jr nz, asm_2412a
asm_2411f:
	ld a, l
	cp c
	jr c, asm_2412a
	cp e
	jr c, asm_24128
	jr nz, asm_2412a
asm_24128:
	scf
	ret

asm_2412a:
	and a
	ret

_ExitMenu::
	xor a
	ldh [hBGMapMode], a
	xor a
	call OpenSRAM
	call GetWindowStackTop
	ld a, l
	or h
	jp z, Function24164
	ld a, l
	ld [wWindowStackPointer], a
	ld a, h
	ld [wWindowStackPointer + 1], a
	call PopWindow
	ld a, [wMenuDataHeader]
	bit 0, a
	jr z, asm_24152
	ld d, h
	ld e, l
	call RestoreTileBackup
asm_24152:
	call GetWindowStackTop
	ld a, h
	or l
	jr z, asm_2415c
	call PopWindow
asm_2415c:
	call CloseSRAM
	ld hl, wWindowStackSize
	dec [hl]
	ret

Function24164:
	ld hl, .text_2416f
	call PrintText
	call WaitBGMap
.loop
	jr .loop

.text_2416f:
	text "ポップできる　ウィンドウが"
	next "ありません！"
	done

Function24185::
	xor a
	call OpenSRAM
	call GetWindowStackTop
	ld a, l
	or h
	jr z, asm_24195
	call _ExitMenu
	jr Function24185
asm_24195:
	call CloseSRAM
	ret

_InitVerticalMenuCursor::
	ld a, [wMenuDataHeaderEnd]
	ld b, a
	ld hl, wMenuData3
	ld a, [wMenuBorderTopCoord]
	inc a
	bit 6, b
	jr nz, asm_241a9
	inc a
asm_241a9:
	ld [hli], a
	ld a, [wMenuBorderLeftCoord]
	inc a
	ld [hli], a
	ld a, [wMenuDataItems]
	ld [hli], a
	ld a, $01
	ld [hli], a
	ld [hl], $00
	bit 5, b
	jr z, asm_241be
	set 5, [hl]
asm_241be:
	ld a, [wMenuDataHeader]
	bit 4, a
	jr z, asm_241c7
	set 6, [hl]
asm_241c7:
	inc hl
	xor a
	ld [hli], a
	ld a, $20
	ld [hli], a
	ld a, $01
	bit 0, b
	jr nz, asm_241d5
	add $02
asm_241d5:
	ld [hli], a
	ld a, [wMenuCursorBuffer]
	and a
	jr z, asm_241e3
	ld c, a
	ld a, [wMenuDataItems]
	cp c
	jr nc, asm_241e5
asm_241e3:
	ld c, $01
asm_241e5:
	ld [hl], c
	inc hl
	ld a, $01
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret

UpdateItemDescription::
	ld a, [wMenuSelection]
	ld [wSelectedItem], a
	hlcoord 0, 12
	ld b, $04
	ld c, $12
	call DrawTextBox
	decoord 1, 14
	callab ShowItemDescription
	ret

Function2420b:
	ld a, $01
	ldh [hBGMapMode], a
	ld hl, .MenuHeader24262
	call LoadMenuHeader
	call MenuBox
	call UpdateSprites
	ld b, SGB_POKEPIC
	call GetSGBLayout
	xor a
	ldh [hBGMapMode], a
	ld a, [wMonDexIndex]
	ld [wCurSpecies], a
	call GetMonHeader
	ld de, vFont
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
	ld bc, $0707
	predef PlaceGraphic
	ld a, $01
	ldh [hBGMapMode], a
	call TextboxWaitPressAorB_BlinkCursor
	call ClearMenuBoxInterior
	call WaitBGMap
	call GetMemSGBLayout
	call CloseWindow
	call LoadFont
	ret

.MenuHeader24262:
	db MENU_BACKUP_TILES
	menu_coords 6, 4, $e, $d
	dw 0
	db 1

_InitScrollingMenu::
	xor a
	ld [wMenuJoypad], a
	ldh [hBGMapMode], a
	inc a
	ldh [hJoyDebounceSrc], a
	ld hl, wce5f
	set 4, [hl]
	call asm_243c3
	call asm_243fc
	ld c, $0a
	call DelayFrames
	call Function242a3
	ret

_ScrollingMenu::
	call Function242b6
	jp c, .asm_24296
	ld a, $00
	ldh [hJoypadSum], a
	call z, Function242a3
	jr _ScrollingMenu
.asm_24296
	ld [wMenuJoypad], a
	ld a, $00
	ldh [hJoyDebounceSrc], a
	ld hl, wce5f
	res 4, [hl]
	ret

Function242a3:
	xor a
	ldh [hBGMapMode], a
	call Function24475
	call Function244ff
	call Function2452c
	xor a
	ldh [hJoypadSum], a
	call WaitBGMap
	ret

Function242b6:
	call Get2DMenuJoypad_NoPlaceCursor
	ldh a, [hJoySum]
	and $f0
	ld b, a
	ldh a, [hJoypadSum]
	and $0f
	or b
	bit 0, a
	jp nz, Function242f1
	bit 1, a
	jp nz, asm_2431c
	bit 2, a
	jp nz, Function24320
	bit 3, a
	jp nz, Function24342
	bit 4, a
	jp nz, asm_24362
	bit 5, a
	jp nz, asm_2434e
	bit 6, a
	jp nz, asm_24376
	bit 7, a
	jp nz, asm_2438a
	jr Function242b6
	ld a, $ff
	and a
	ret

Function242f1:
	call PlaceHollowCursor
	ld a, [w2DMenuDataEnd]
	dec a
	call asm_24555
	ld a, [wMenuSelection]
	ld [wCurItem], a
	ld a, [wMenuSelectionQuantity]
	ld [wItemQuantityBuffer], a
	call asm_243a5
	dec a
	ld [wScrollingMenuCursorPosition], a
	ld [wItemIndex], a
	ld a, [wMenuSelection]
	cp $ff
	jr z, asm_2431c
	ld a, $01
	scf
	ret

asm_2431c:
	ld a, $02
	scf
	ret

Function24320:
	ld a, [wMenuDataHeaderEnd]
	bit 7, a
	jp z, SetFFInAccumulator
	ld a, [w2DMenuDataEnd]
	dec a
	call asm_24555
	ld a, [wMenuSelection]
	cp $ff
	jp z, SetFFInAccumulator
	call asm_243a5
	dec a
	ld [wScrollingMenuCursorPosition], a
	ld a, $04
	scf
	ret

Function24342:
	ld a, [wMenuDataHeaderEnd]
	bit 6, a
	jp z, SetFFInAccumulator
	ld a, $08
	scf
	ret

asm_2434e:
	ld hl, w2DMenuFlags + 1
	bit 7, [hl]
	jp z, SetFFInAccumulator
	ld a, [wMenuDataHeaderEnd]
	bit 3, a
	jp z, SetFFInAccumulator
	ld a, $20
	scf
	ret

asm_24362:
	ld hl, w2DMenuFlags + 1
	bit 7, [hl]
	jp z, SetFFInAccumulator
	ld a, [wMenuDataHeaderEnd]
	bit 2, a
	jp z, SetFFInAccumulator
	ld a, $10
	scf
	ret

asm_24376:
	ld hl, w2DMenuFlags + 1
	bit 7, [hl]
	jp z, ClearAccumulator
	ld hl, wMenuScrollPosition
	ld a, [hl]
	and a
	jp z, ClearAccumulator
	dec [hl]
	jp ClearAccumulator

asm_2438a:
	ld hl, w2DMenuFlags + 1
	bit 7, [hl]
	jp z, ClearAccumulator
	ld hl, wMenuScrollPosition
	ld a, [wMenuDataItems]
	add [hl]
	ld b, a
	ld a, [wcdbc]
	cp b
	jp c, ClearAccumulator
	inc [hl]
	jp ClearAccumulator

asm_243a5:
	ld a, [wMenuScrollPosition]
	ld c, a
	ld a, [w2DMenuDataEnd]
	add c
	ld c, a
	ret

ScrollingMenu_ClearLeftColumn::
	call MenuBoxCoord2Tile
	ld de, $14
	add hl, de
	ld de, $28
	ld a, [wMenuDataItems]
asm_243bc:
	ld [hl], $7f
	add hl, de
	dec a
	jr nz, asm_243bc
	ret

asm_243c3:
	ld hl, wMenuDataDisplayFunctionPointer + 1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMenuDataDisplayFunctionPointer]
	call GetFarByte
	ld [wcdbc], a
	ld a, [wMenuScrollPosition]
	ld c, a
	ld a, [wMenuCursorBuffer]
	add c
	ld b, a
	ld a, [wcdbc]
	inc a
	cp b
	jr c, .asm_243f2
	ld a, [wMenuScrollPosition]
	ld c, a
	ld a, [wMenuDataItems]
	add c
	ld b, a
	ld a, [wcdbc]
	inc a
	cp b
	jr nc, .asm_243fb
.asm_243f2
	xor a
	ld [wMenuScrollPosition], a
	ld a, $01
	ld [wMenuCursorBuffer], a
.asm_243fb
	ret

asm_243fc:
	ld a, [wMenuDataHeaderEnd]
	ld c, a
	ld a, [wcdbc]
	ld b, a
	ld a, [wMenuBorderTopCoord]
	add $01
	ld [wMenuData3], a
	ld a, [wMenuBorderLeftCoord]
	add $00
	ld [w2DMenuCursorInitX], a
	ld a, [wMenuDataItems]
	cp b
	jr c, asm_2441e
	jr z, asm_2441e
	ld a, b
	inc a
asm_2441e:
	ld [w2DMenuNumRows], a
	ld a, $01
	ld [w2DMenuNumCols], a
	ld a, $8c
	bit 2, c
	jr z, asm_2442e
	set 0, a
asm_2442e:
	bit 3, c
	jr z, asm_24434
	set 1, a
asm_24434:
	ld [w2DMenuFlags], a
	xor a
	ld [w2DMenuFlags + 1], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, $c3
	bit 7, c
	jr z, asm_24448
	add $04
asm_24448:
	bit 6, c
	jr z, asm_2444e
	add $08
asm_2444e:
	ld [wMenuJoypadFilter], a
	ld a, [w2DMenuNumRows]
	ld b, a
	ld a, [wMenuCursorBuffer]
	and a
	jr z, asm_24460
	cp b
	jr z, asm_24462
	jr c, asm_24462
asm_24460:
	ld a, $01
asm_24462:
	ld [w2DMenuDataEnd], a
	ld a, $01
	ld [wMenuCursorX], a
	xor a
	ld [wCursorCurrentTile], a
	ld [wCursorCurrentTile + 1], a
	ld [wCursorOffCharacter], a
	ret

Function24475:
	call ClearWholeMenuBox
	ld a, [wMenuScrollPosition]
	and a
	jr z, asm_2448b
	ld a, [wMenuBorderTopCoord]
	ld b, a
	ld a, [wMenuBorderRightCoord]
	ld c, a
	call Coord2Tile
	ld [hl], $61
asm_2448b:
	call MenuBoxCoord2Tile
	ld bc, $0015
	add hl, bc
	ld a, [wMenuDataItems]
	ld b, a
	ld c, $00
asm_24498:
	ld a, [wMenuScrollPosition]
	add c
	ld [wScrollingMenuCursorPosition], a
	ld a, c
	call asm_24555
	ld a, [wMenuSelection]
	cp $ff
	jr z, asm_244c8
	push bc
	push hl
	call asm_244e2
	pop hl
	ld bc, $0028
	add hl, bc
	pop bc
	inc c
	ld a, c
	cp b
	jr nz, asm_24498
	ld a, [wMenuBorderBottomCoord]
	ld b, a
	ld a, [wMenuBorderRightCoord]
	ld c, a
	call Coord2Tile
	ld [hl], $ee
	ret

asm_244c8:
	ld a, [wMenuDataHeaderEnd]
	bit 0, a
	jr nz, asm_244da
	ld de, .text_244d6
	call PlaceString
	ret

.text_244d6:
	db "やめる@"

asm_244da:
	ld d, h
	ld e, l
	ld hl, wMenuDataPointerTableAddr + 1
	jp CallFar_atHL

asm_244e2:
	push hl
	ld d, h
	ld e, l
	ld hl, wMenuDataPointerTableAddr + 1
	call CallFar_atHL
	pop hl
	ld a, [wMenuDataIndicesPointer]
	and a
	jr z, asm_244fe
	ld e, a
	ld d, $00
	add hl, de
	ld d, h
	ld e, l
	ld hl, wcc1c
	call CallFar_atHL
asm_244fe:
	ret

Function244ff:
	ld a, [wSelectedSwapPosition]
	and a
	jr z, asm_2452b
	ld b, a
	ld a, [wMenuScrollPosition]
	cp b
	jr nc, asm_2452b
	ld c, a
	ld a, [wMenuDataItems]
	add c
	cp b
	jr c, asm_2452b
	ld a, b
	sub c
	dec a
	add a
	add $01
	ld c, a
	ld a, [wMenuBorderTopCoord]
	add c
	ld b, a
	ld a, [wMenuBorderLeftCoord]
	add $00
	ld c, a
	call Coord2Tile
	ld [hl], $ec
asm_2452b:
	ret

Function2452c:
	ld a, [wMenuDataHeaderEnd]
	bit 5, a
	ret z
	hlcoord 0, 12
	ld b, $04
	ld c, $12
	call DrawTextBox
	ld a, [w2DMenuDataEnd]
	dec a
	call asm_24555
	ld a, [wMenuSelection]
	cp $ff
	jr z, .done
	decoord 1, 14
	ld hl, wcc1f
	call CallFar_atHL
	ret

.done
	ret

asm_24555:
	push de
	push hl
	ld e, a
	ld a, [wMenuScrollPosition]
	add e
	ld e, a
	ld d, $00
	ld hl, wMenuDataDisplayFunctionPointer + 1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [wMenuDataIndicesPointer + 1]
	cp $01
	jr z, asm_24576
	cp $02
	jr z, asm_24575
	cp $80
	jr z, asm_24590
asm_24575:
	add hl, de
asm_24576:
	add hl, de
	ld a, [wMenuDataDisplayFunctionPointer]
	call GetFarByte
	ld [wMenuSelection], a
	ld [wCurItem], a
	inc hl
	ld a, [wMenuDataDisplayFunctionPointer]
	call GetFarByte
	ld [wMenuSelectionQuantity], a
	pop hl
	pop de
	ret

asm_24590:
	ld a, [wcdbc]
	ld d, a
	ld a, e
	cp d
	jr nc, asm_245b5
	inc e
	ld d, $00
asm_2459b:
	inc d
	ld a, [hli]
	and a
	jr z, asm_2459b
	dec e
	jr nz, asm_2459b
	dec hl
	dec d
	push bc
	push hl
	ld c, d
	callab GetBallByIndex
	ld d, c
	pop hl
	pop bc
	jr asm_245b7
asm_245b5:
	ld d, $ff
asm_245b7:
	ld a, d
	ld [wMenuSelection], a
	ld [wCurItem], a
	ld a, [hl]
	ld [wMenuSelectionQuantity], a
	pop hl
	pop de
	ret

SwitchItemsInBag::
	ld a, [wSelectedSwapPosition]
	and a
	jr z, asm_24602
	ld b, a
	ld a, [wScrollingMenuCursorPosition]
	inc a
	cp b
	jr z, asm_2460a
	ld a, [wScrollingMenuCursorPosition]
	call asm_246f7
	ld a, [hl]
	cp $ff
	ret z
	ld a, [wSelectedSwapPosition]
	dec a
	ld [wSelectedSwapPosition], a
	ld a, [wSelectedSwapPosition]
	call asm_246f7
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call asm_246f7
	ld a, [hl]
	pop hl
	cp [hl]
	jr z, asm_2466c
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld a, [wSelectedSwapPosition]
	cp c
	jr c, asm_2463f
	jr asm_2460f
asm_24602:
	ld a, [wScrollingMenuCursorPosition]
	inc a
	ld [wSelectedSwapPosition], a
	ret

asm_2460a:
	xor a
	ld [wSelectedSwapPosition], a
	ret

asm_2460f:
	ld a, [wSelectedSwapPosition]
	call asm_246db
	ld a, [wScrollingMenuCursorPosition]
	ld d, a
	ld a, [wSelectedSwapPosition]
	ld e, a
	call asm_24707
	push bc
	ld a, [wSelectedSwapPosition]
	call asm_246f7
	dec hl
	push hl
	call asm_2471b
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	call asm_24732
	ld a, [wScrollingMenuCursorPosition]
	call asm_246e8
	xor a
	ld [wSelectedSwapPosition], a
	ret

asm_2463f:
	ld a, [wSelectedSwapPosition]
	call asm_246db
	ld a, [wScrollingMenuCursorPosition]
	ld d, a
	ld a, [wSelectedSwapPosition]
	ld e, a
	call asm_24707
	push bc
	ld a, [wSelectedSwapPosition]
	call asm_246f7
	ld d, h
	ld e, l
	call asm_2471b
	add hl, bc
	pop bc
	call CopyBytes
	ld a, [wScrollingMenuCursorPosition]
	call asm_246e8
	xor a
	ld [wSelectedSwapPosition], a
	ret

asm_2466c:
	ld a, [wSelectedSwapPosition]
	call asm_246f7
	inc hl
	push hl
	ld a, [wScrollingMenuCursorPosition]
	call asm_246f7
	inc hl
	ld a, [hl]
	pop hl
	add [hl]
	cp $64
	jr c, asm_2469c
	sub $63
	push af
	ld a, [wScrollingMenuCursorPosition]
	call asm_246f7
	inc hl
	ld [hl], $63
	ld a, [wSelectedSwapPosition]
	call asm_246f7
	inc hl
	pop af
	ld [hl], a
	xor a
	ld [wSelectedSwapPosition], a
	ret

asm_2469c:
	push af
	ld a, [wScrollingMenuCursorPosition]
	call asm_246f7
	inc hl
	pop af
	ld [hl], a
	ld hl, wMenuDataDisplayFunctionPointer + 1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wSelectedSwapPosition]
	cp [hl]
	jr nz, asm_246c0
	dec [hl]
	ld a, [wSelectedSwapPosition]
	call asm_246f7
	ld [hl], $ff
	xor a
	ld [wSelectedSwapPosition], a
	ret

asm_246c0:
	dec [hl]
	call asm_2471b
	push bc
	ld a, [wSelectedSwapPosition]
	call asm_246f7
	pop bc
	push hl
	add hl, bc
	pop de
asm_246cf:
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, asm_246cf
	xor a
	ld [wSelectedSwapPosition], a
	ret

asm_246db:
	call asm_246f7
	ld de, wMovementBufferCount
	call asm_2471b
	call CopyBytes
	ret

asm_246e8:
	call asm_246f7
	ld d, h
	ld e, l
	ld hl, wMovementBufferCount
	call asm_2471b
	call CopyBytes
	ret

asm_246f7:
	push af
	call asm_2471b
	ld hl, wMenuDataDisplayFunctionPointer + 1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	pop af
	call AddNTimes
	ret

asm_24707:
	push hl
	call asm_2471b
	ld a, d
	sub e
	jr nc, asm_24711
	dec a
	cpl
asm_24711:
	ld hl, 0
	call AddNTimes
	ld b, h
	ld c, l
	pop hl
	ret

asm_2471b:
	push hl
	ld a, [wMenuDataIndicesPointer + 1]
	ld c, a
	ld b, $00
	ld hl, .data_2472c
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	ret

.data_2472c:
	dw 0
	dw 1
	dw 2

asm_24732:
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, b
	or c
	jr nz, asm_24732
	ret

Function2473b::
	ld a, [wMenuSelection]
	cp $ff
	jr z, .asm_24762
	push de
	callab CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld e, a
	ld d, $00
	ld hl, .data_2475b
	add hl, de
	ld a, [hl]
	pop de
	ld [de], a
	inc de
	jr PlaceMenuItemName

.data_2475b:
	db $7f, $62, $64, $63, $7f, $7f, $7f

.asm_24762
	ld h, d
	ld l, e
	ld de, .text_2476b
	call PlaceString
	ret

.text_2476b:
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
	callab _CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	pop hl
	and a
	jr nz, .done
	ld [hl], $f1
	inc hl
	ld de, wMenuSelectionQuantity
	ld bc, $0102
	call PrintNumber
.done
	ret

asm_247a6:
	ld hl, wPartyMonOTEnd
	jr .asm_247ae
	ld hl, wdf17
.asm_247ae
	push de
	ld a, [wScrollingMenuCursorPosition]
	call GetNick
	pop hl
	call PlaceString
	ret

asm_247ba:
	ld a, $00
	ld [wMonType], a
	jr .asm_247c6
	ld a, $02
	ld [wMonType], a
.asm_247c6
	push de
	ld a, [wScrollingMenuCursorPosition]
	ld [wWhichPokemon], a
	predef Function50000
	pop hl
	call PrintLevel
	ret

ret_247d7:
	ret

asm_247d8:
	push de
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld b, $00
	ld hl, wBoxList
	add hl, bc
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	pop hl
	call PlaceString
	ld de, 6
	add hl, de
	push hl
	ld a, [wScrollingMenuCursorPosition]
	ld hl, wdf17
	call GetNick
	pop hl
	call PlaceString
	ld de, 6
	add hl, de
	push hl
	ld a, [wScrollingMenuCursorPosition]
	ld [wWhichPokemon], a
	ld a, $02
	ld [wMonType], a
	ld a, $31
	call Predef
	pop hl
	push hl
	call PrintLevel
	pop hl
	ld de, 3
	add hl, de
	push hl
	callab Function5069e
	ld a, $ef
	jr c, .asm_2482e
	ld a, $f5
.asm_2482e
	pop hl
	ld [hl], a
	ret

asm_4831:
	ld hl, .MenuHeader2484e
	call CopyMenuHeader
	call MenuBox
	call PlaceVerticalMenuItems
	call MenuBoxCoord2Tile
	ld de, $0015
	add hl, de
	ld de, wd15d
	ld bc, $4306
	call PrintNumber
	ret

.MenuHeader2484e:
	db 0
	menu_coords 11, 0, $13, 2
	dw .data_24856
	db 1

.data_24856:
	db $40, $01
	db "　　　　　　円@"

asm_24860:
	ld hl, MenuHeader24888
	call CopyMenuHeader
	jr asm_24872

asm_24868:
	ld hl, MenuHeader24888
	ld d, $0b
	ld e, $00
	call OffsetMenuHeader

asm_24872:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, $0015
	add hl, de
	ld de, wd15d
	ld bc, $4306
	call PrintNumber
	ld [hl], $f0
	ret

MenuHeader24888:
	db MENU_BACKUP_TILES
	menu_coords 11, 0, $13, 2
	dw 0
	db 1

asm_24890:
	ld hl, .MenuHeader2489a
	call LoadMenuHeader
	call VerticalMenu
	ret

.MenuHeader2489a:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 6, 10
	dw .text_248a2
	db 1

.text_248a2:
	db "たエ゛うる@"
	db "かう@"
	db "やめる@"
	db "くさかり@"
	db "とんでけ@"
	db "どんぶらこ@"
	db "フルパワー@"
	db "ひかりゴケ@"
	db "うずしお@"
	db "とびはねる@"
	db "あなをほる@"
	db "テレポート@"
	db "タマゴうみ@"

Text248e7:
	db "つよさをみる@"
	db "ならびかえ@"
	db "そうび@"
	db "キャンセル@"
	db "もちわざ@"
	db "メール@"
	db "エラー！@"

Data2490c:
	db $f5, $01
	db $f6, $02
	db $f7, $03
	db $f8, $04
	db $f9, $05
	db $fa, $06
	db $fb, $07
	db $5b, $08
	db $64, $09
	db $87, $0a
	db $ff

Data24921:
	db $01, $01, $f5
	db $01, $02, $f6
	db $01, $03, $f7
	db $01, $04, $f8
	db $01, $05, $f9
	db $01, $06, $fa
	db $01, $07, $fb
	db $01, $08, $5b
	db $01, $09, $64
	db $01, $0a, $87
	db $00, $0b, $01
	db $00, $0c, $02
	db $00, $0d, $03
	db $00, $0e, $04
	db $00, $0f, $05
	db $00, $10, $06
	db $00, $11, $07
	db $ff

Function24955::
	xor a
	ldh [hBGMapMode], a
	call asm_24a0c
	callab Function_8f1cb
	ld hl, .MenuHeader2497d
	call LoadMenuHeader
	call asm_24985
	call asm_249c9
	ld a, 1
	ldh [hBGMapMode], a
	call asm_24997
	ld [wMenuSelection], a
	call CloseWindow
	ret

.MenuHeader2497d:
	db $40
	menu_coords 11, 0, $13, $11
	dw 0
	db 1

asm_24985:
	ld a, [wFieldMoveScriptID]
	inc a
	add a
	ld b, a
	ld a, [wMenuBorderBottomCoord]
	sub b
	inc a
	ld [wMenuBorderTopCoord], a
	call MenuBox
	ret

asm_24997:
	ld a, $a0
	ld [wMenuDataHeaderEnd], a
	ld a, [wFieldMoveScriptID]
	ld [wMenuDataItems], a
	call InitVerticalMenuCursor
	ld hl, w2DMenuFlags
	set 6, [hl]
	call Get2DMenuJoypad
	ldh a, [hJoyDown]
	bit 0, a
	jr nz, asm_249bc
	bit 1, a
	jr nz, asm_249b9
	jr asm_24997
asm_249b9:
	ld a, $0e
	ret

asm_249bc:
	ld a, [w2DMenuDataEnd]
	dec a
	ld c, a
	ld b, $00
	ld hl, wMapBlocksAddress
	add hl, bc
	ld a, [hl]
	ret

asm_249c9:
	call MenuBoxCoord2Tile
	ld bc, $002a
	add hl, bc
	ld de, wMapBlocksAddress
asm_249d3:
	ld a, [de]
	inc de
	cp $ff
	ret z
	push de
	push hl
	call asm_249e8
	pop hl
	call PlaceString
	ld bc, $0028
	add hl, bc
	pop de
	jr asm_249d3
asm_249e8:
	dec a
	ld b, a
	add a
	add b
	ld c, a
	ld b, $00
	ld hl, Data24921
	add hl, bc
	ld a, [hli]
	and a
	jr z, asm_24a00
	inc hl
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call Unreferenced_GetMoveName
	ret

asm_24a00:
	inc hl
	ld a, [hl]
	dec a
	ld hl, Text248e7
	call GetNthString
	ld d, h
	ld e, l
	ret

asm_24a0c:
	call asm_24a78
	ld a, $02
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld hl, wMapBlocksAddress
	ld c, $04
asm_24a1b:
	push bc
	push de
	ld a, [de]
	and a
	jr z, asm_24a2b
	push hl
	call asm_24a63
	pop hl
	jr nc, asm_24a2b
	call asm_24a93
asm_24a2b:
	pop de
	inc de
	pop bc
	dec c
	jr nz, asm_24a1b
	ld a, $0b
	call asm_24a93
	ld a, $0c
	call asm_24a93
	ld a, $0f
	call asm_24a93
	push hl
	ld a, $01
	call GetPartyParamLocation
	ld a, [hl]
	pop hl
	cp $9e
	ld a, $0d
	jr nz, asm_24a50
	ld a, $10
asm_24a50:
	call asm_24a93
	ld a, [wFieldMoveScriptID]
	cp $08
	jr z, asm_24a5f
	ld a, $0e
	call asm_24a93
asm_24a5f:
	call asm_24a86
	ret

asm_24a63:
	ld b, a
	ld hl, Data24921
asm_24a67:
	ld a, [hli]
	cp $ff
	jr z, asm_24a77
	and a
	jr z, asm_24a77
	ld d, [hl]
	inc hl
	ld a, [hli]
	cp b
	jr nz, asm_24a67
	ld a, d
	scf
asm_24a77:
	ret

asm_24a78:
	xor a
	ld [wFieldMoveScriptID], a
	ld hl, wMapBlocksAddress
	ld bc, $9
	call ByteFill
	ret

asm_24a86:
	ld a, [wFieldMoveScriptID]
	ld e, a
	ld d, $00
	ld hl, wMapBlocksAddress
	add hl, de
	ld [hl], $ff
	ret

asm_24a93:
	push hl
	push de
	push af
	ld a, [wFieldMoveScriptID]
	ld e, a
	inc a
	ld [wFieldMoveScriptID], a
	ld d, $00
	ld hl, wMapBlocksAddress
	add hl, de
	pop af
	ld [hl], a
	pop de
	pop hl
	ret

asm_24aa9:
	ld hl, .MenuHeader24ae9
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
	ld de, wMenuDataHeaderEnd
	ld bc, $8
	call CopyBytes
	ld a, [wMenuDataHeaderEnd]
	bit 7, a
	jr z, .asm_24ae4
	call InitVerticalMenuCursor
	ld hl, w2DMenuFlags
	set 6, [hl]
	call Get2DMenuJoypad
	bit 1, a
	jr z, .asm_24ae6
	ret z
.asm_24ae4:
	scf
	ret

.asm_24ae6:
	and a
	ret

	ret

.MenuHeader24ae9:
	db 0
	menu_coords 11, 11, $13, $11
	dw .text_24af1
	db 1

.text_24af1:
	db "たエ゛とりかえる@"
	db "つよさをみる@"
	db "キャンセル@"

asm_24b06:
	ld hl, MenuHeader24b24
	jr asm_24b0e

asm_24b0b:
	ld hl, MenuHeader24b3e
asm_24b0e:
	call LoadMenuHeader
	ld a, [wStartmenuCursor]
	ld [wMenuCursorBuffer], a
	call asm_24b67
	ld a, [wMenuCursorBuffer]
	ld [wStartmenuCursor], a
	call ExitMenu
	ret

MenuHeader24b24:
	db MENU_BACKUP_TILES
	menu_coords 9, 12, $13, $11
	dw .text_24b2c
	db 1

.text_24b2c:
	db "ア<TA!>ガたたかう@"
	db "どうぐ@"
	db "#@"
	db "にげる@"

MenuHeader24b3e:
	db MENU_BACKUP_TILES
	menu_coords 0, 12, $13, $11
	dw .text_24b46
	db 1

.text_24b46:
	db "ア<TA!>ジサファりボール×　　　@"
	db "エサをなげる@"
	db "いしをなげる@"
	db "にげる@"

asm_24b67:
	call CopyMenuData
	call MenuBox
	ld a, [wMenuDataItems]
	ld b, a
	and $0f
	ld [wMovementBufferCount], a
	ld a, b
	and $f0
	swap a
	ld [wMovementBufferObject], a
	call asm_24bb8
	call asm_24bee
	call Get2DMenuJoypad
	ldh a, [hJoySum]
	bit 2, a
	jr nz, asm_24ba2
	ld a, [w2DMenuNumRows]
	ld c, a
	ld a, [w2DMenuDataEnd]
	dec a
	call asm_24ba4
	ld c, a
	ld a, [wMenuCursorX]
	add c
	ld [wMenuCursorBuffer], a
	and a
	ret

asm_24ba2:
	scf
	ret

asm_24ba4:
	and a
	ret z
	push bc
	ld b, a
	xor a
asm_24ba9:
	add c
	dec b
	jr nz, asm_24ba9
	pop bc
	ret

asm_24baf:
	ld b, $00
asm_24bb1:
	inc b
	sub c
	jr nc, asm_24bb1
	dec b
	add c
	ret

asm_24bb8:
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $0003
	add hl, de
	ld d, h
	ld e, l
	call GetMenuTextStartCoord
	call Coord2Tile
	ld a, [wMovementBufferCount]
	ld b, a
asm_24bce:
	push bc
	push hl
	ld a, [wMovementBufferObject]
	ld c, a
asm_24bd4:
	push bc
	call PlaceString
	inc de
	ld a, [wMenuDataIndicesPointer]
	ld c, a
	ld b, $00
	add hl, bc
	pop bc
	dec c
	jr nz, asm_24bd4
	pop hl
	ld bc, $0028
	add hl, bc
	pop bc
	dec b
	jr nz, asm_24bce
	ret

asm_24bee:
	call GetMenuTextStartCoord
	ld a, b
	ld [wMenuData3], a
	dec c
	ld a, c
	ld [w2DMenuCursorInitX], a
	ld a, [wMovementBufferCount]
	ld [w2DMenuNumRows], a
	ld a, [wMovementBufferObject]
	ld [w2DMenuNumCols], a
	ld a, [wMenuDataHeaderEnd]
	ld d, a
	bit 5, d
	ld a, $00
	jr z, asm_24c12
	ld a, $30
asm_24c12:
	ld [w2DMenuFlags], a
	ld a, [wMenuDataIndicesPointer]
	or $20
	ld [w2DMenuCursorOffsets], a
	ld a, $05
	ld [wMenuJoypadFilter], a
	ld a, [w2DMenuNumCols]
	ld e, a
	ld a, [wMenuCursorBuffer]
	ld b, a
	xor a
	ld d, $00
asm_24c2d:
	inc d
	add e
	cp b
	jr c, asm_24c2d
	sub e
	ld c, a
	ld a, b
	sub c
	and a
	jr z, asm_24c3e
	cp e
	jr z, asm_24c40
	jr c, asm_24c40
asm_24c3e:
	ld a, $01
asm_24c40:
	ld [wMenuCursorX], a
	ld a, [w2DMenuNumRows]
	ld e, a
	ld a, d
	and a
	jr z, asm_24c50
	cp e
	jr z, asm_24c52
	jr c, asm_24c52
asm_24c50:
	ld a, $01
asm_24c52:
	ld [w2DMenuDataEnd], a
	xor a
	ld [wCursorOffCharacter], a
	ld [wCursorCurrentTile], a
	ld [wCursorCurrentTile + 1], a
	ret

SelectQuantityToToss::
	ld hl, MenuHeader24d64
	call LoadMenuHeader
	call asm_24c84
	ret

asm_24c64:
	callab GetItemPrice
	ld a, d
	ld [wFieldMoveScriptID], a
	ld a, e
	ld [wMapBlocksAddress], a
	ld hl, MenuHeader24d6c
	call LoadMenuHeader
	call asm_24c84
	ret

asm_24c84:
	ld a, 1
	ld [wItemQuantity], a
asm_24c89:
	call GetJoypad
	ldh a, [hJoyState]
	bit 0, a
	jr nz, asm_24c89
asm_24c92:
	call asm_24d15
	call asm_24ca2
	jr nc, asm_24c92
	cp $ff
	jr nz, asm_24ca0
	scf
	ret

asm_24ca0:
	and a
	ret

asm_24ca2:
	call DelayFrame
	ldh a, [hJoyDebounceSrc]
	push af
	ld a, $01
	ldh [hJoyDebounceSrc], a
	call GetJoypadDebounced
	pop af
	ldh [hJoyDebounceSrc], a
	ldh a, [hJoyDown]
	bit 1, a
	jr nz, asm_24cd0
	bit 0, a
	jr nz, asm_24cd4
	ldh a, [hJoySum]
	bit 7, a
	jr nz, asm_24cd6
	bit 6, a
	jr nz, asm_24ce2
	bit 5, a
	jr nz, asm_24cf0
	bit 4, a
	jr nz, asm_24d02
	jr asm_24ca2
asm_24cd0:
	ld a, $ff
	scf
	ret

asm_24cd4:
	scf
	ret

asm_24cd6:
	ld hl, wItemQuantity
	dec [hl]
	jr nz, asm_24ce0
	ld a, [wItemQuantityBuffer]
	ld [hl], a
asm_24ce0:
	and a
	ret

asm_24ce2:
	ld hl, wItemQuantity
	inc [hl]
	ld a, [wItemQuantityBuffer]
	cp [hl]
	jr nc, asm_24cee
	ld [hl], 1
asm_24cee:
	and a
	ret

asm_24cf0:
	ld a, [wItemQuantity]
	sub 10
	jr c, asm_24cfb
	jr z, asm_24cfb
	jr asm_24cfd
asm_24cfb:
	ld a, 1
asm_24cfd:
	ld [wItemQuantity], a
	and a
	ret

asm_24d02:
	ld a, [wItemQuantity]
	add 10
	ld b, a
	ld a, [wItemQuantityBuffer]
	cp b
	jr nc, asm_24d0f
	ld b, a
asm_24d0f:
	ld a, b
	ld [wItemQuantity], a
	and a
	ret

asm_24d15:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, $15
	add hl, de
	ld [hl], $f1
	inc hl
	ld de, wItemQuantity
	ld bc, $8102
	call PrintNumber
	ld a, [wMenuDataPointer]
	cp $ff
	ret nz
	xor a
	ldh [hMultiplicand], a
	ld a, [wFieldMoveScriptID]
	ldh [hMultiplicand + 1], a
	ld a, [wMapBlocksAddress]
	ldh [hMultiplicand + 2], a
	ld a, [wItemQuantity]
	ldh [hMultiplier], a
	push hl
	call Multiply
	ld hl, hFFCD
	ldh a, [hMultiplicand]
	ld [hli], a
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ldh a, [hMultiplicand + 2]
	ld [hl], a
	pop hl
	inc hl
	ld de, hFFCD
	ld bc, $0406
	call PrintNumber
	ld [hl], $f0
	call WaitBGMap
	ret

MenuHeader24d64:
	db MENU_BACKUP_TILES
	menu_coords 15, 9, $13, 11
	dw 0
	db 0

MenuHeader24d6c:
	db MENU_BACKUP_TILES
	menu_coords 7, 15, $13, $11
	dw $ff
	db $ff

