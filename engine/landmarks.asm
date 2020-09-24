INCLUDE "constants.asm"

SECTION "engine/landmarks.asm@1", ROMX

DebugMenu_DisplayWarpSubmenu::
	xor a
	ldh [hBGMapMode], a
	call LoadStandardMenuHeader
	ld hl, wTileMap
	ld b, 10
	ld c, 11
	call DrawTextBox
	call UpdateSprites
	ld hl, DebugMenu_WarpMenuHeader
	call CopyMenuHeader
	call ScrollingMenu
	call CloseWindow
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .cancel
	and a
	ret

.cancel
	scf
	ret

DebugMenu_WarpMenuHeader::
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, 11, 10
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $00 ; flags
	db 4 ; items
	dw $0100 ; ???

	dba Data_3f_4bc6
	dba PlaceSelectedMapName

	db $00, $00, $00 ; ???
	db $00, $00, $00 ; ???

PlaceSelectedMapName::
	push de
	ld a, [wMenuSelection]
	call GetLandmarkName
	pop hl
	call PlaceString
	ret

GetLandmarkName::
	dec a
	ld hl, LandmarkNames
	call GetNthString
	ld d, h
	ld e, l
	ret

SECTION "engine/landmarks.asm@2", ROMX

Data_3f_4bc6::
	db 16 ; #
	db $01
	db $02
	db $03
	db $04
	db $05
	db $06
	db $07
	db $08
	db $09
	db $0a
	db $0b
	db $0e
	db $0f
	db $10
	db $11
	db $2d
	db $ff

	db $12
	db $13
	db $14
	db $15
	db $16
	db $17
	db $18
	db $19
	db $1a
	db $1b
	db $1c
	db $1d
	db $1e
	db $1f
	db $20
	db $21
	db $22
	db $23
	db $24
	db $25
	db $26
	db $27
	db $28
	db $29
	db $2a
	db $2b
	db $2c
	db $ff
