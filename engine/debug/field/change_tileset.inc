SECTION "engine/debug/field/change_tileset.inc@FieldDebug_ChangeTileset", ROMX

FieldDebug_ChangeTileset:
	ld hl, .MenuHeader
	call LoadMenuHeader
	ld a, [wMapTileset]
	inc a
	ld [wMenuCursorBuffer], a
	call VerticalMenu
	call CloseWindow
	jr c, .reopen
	ld a, [wMapTileset]
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	cp b
	jr z, .reopen
	ld [wMapTileset], a
	call LoadTileset
	call LoadTilesetGFX
	jr FieldDebug_ChangeTileset

.reopen:
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 8, 10
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 3
	db "セル１@"
	db "セル２@"
	db "セル３@"

