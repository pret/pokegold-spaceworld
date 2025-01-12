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

	dba WarpMenuOptions
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

WarpMenuOptions::

	db 16 ; Number of options in the menu - 43 total stored in data, but most are unused

	db SPAWN_POINT_SILENT
	db SPAWN_POINT_OLD
	db SPAWN_POINT_WEST
	db SPAWN_POINT_HIGH_TECH
	db SPAWN_POINT_FOUNT
	db SPAWN_POINT_BIRDON
	db SPAWN_POINT_NEW_TYPE
	db SPAWN_POINT_SUGAR
	db SPAWN_POINT_BLUE_FOREST
	db SPAWN_POINT_STAND
	db SPAWN_POINT_KANTO

	; PRINCE and MT_FUJI are skipped in the menu

	db SPAWN_POINT_SOUTH
	db SPAWN_POINT_NORTH
	db SPAWN_POINT_ROUTE_15
	db SPAWN_POINT_ROUTE_18
	db SPAWN_POINT_SILENT_HILL
	db $ff

	; The demo's options stop here, but the spawn points included actually extend far beyond what is available

	db SPAWN_POINT_POWER_PLANT_1
	db SPAWN_POINT_POWER_PLANT_2
	db SPAWN_POINT_POWER_PLANT_3
	db SPAWN_POINT_POWER_PLANT_4
	db SPAWN_POINT_RUINS_1
	db SPAWN_POINT_RUINS_2
	db SPAWN_POINT_MINES_1
	db SPAWN_POINT_MINES_2
	db SPAWN_POINT_MINES_3
	db SPAWN_POINT_MINES_4
	db SPAWN_POINT_MINES_5
	db SPAWN_POINT_MINES_6
	db SPAWN_POINT_MINES_7
	db SPAWN_POINT_HIDEOUT_1
	db SPAWN_POINT_HIDEOUT_2
	db SPAWN_POINT_HIDEOUT_3
	db SPAWN_POINT_SLOWPOKE_WELL_1
	db SPAWN_POINT_SLOWPOKE_WELL_2
	db SPAWN_POINT_POKEMON_LEAGUE_1
	db SPAWN_POINT_POKEMON_LEAGUE_1_2
	db SPAWN_POINT_POKEMON_LEAGUE_2
	db SPAWN_POINT_POKEMON_LEAGUE_3
	db SPAWN_POINT_POKEMON_LEAGUE_4
	db SPAWN_POINT_POKEMON_LEAGUE_5
	db SPAWN_POINT_POKEMON_LEAGUE_6
	db SPAWN_POINT_POKEMON_LEAGUE_7
	db SPAWN_POINT_POKEMON_LEAGUE_7_2
	db $ff
