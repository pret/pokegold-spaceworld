FieldDebug_CheckTile:
	call .CheckTile
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.CheckTile:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call MenuBox
	ld a, [wPlayerNextMapX]
	ld d, a
	ld a, [wPlayerNextMapY]
	ld e, a
	call GetBlockLocation
	ld a, [hl]
	push af
	call MenuBoxCoord2Tile
	ld bc, $2a
	add hl, bc
	pop af
	call .ShowTileNumber
	ld a, 10
	call DelayFrames
	ld a, BUTTONS
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ret

.MenuHeader:
	db $40
	menu_coords 0, 0, 5, 4
	dw .MenuData
	db 0

.MenuData: ; empty
	db 0

.ShowTileNumber:
	push af
	swap a
	and $f
	call .ShowHexDigit
	ld [hli], a
	pop af
	and $f
	call .ShowHexDigit
	ld [hli], a
	ret

.ShowHexDigit:
	push de
	push hl
	ld hl, .HexadecimalNumbers
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	pop hl
	pop de
	ret

.HexadecimalNumbers:
	db "０１２３４５６７８９ＡＢＣＤＥＦ"

