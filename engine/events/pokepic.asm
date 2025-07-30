INCLUDE "constants.asm"

SECTION "engine/events/pokepic.asm", ROMX

Pokepic::
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
