; Spawn points used by Fly, Debug Warp, etc.

MACRO spawn
; map, x, y
	map_id \1
	db \2, \3
ENDM
SpawnPoints:

; Fly destinations
	table_width 4
	spawn SILENT_HILL, $05, $05
	spawn OLD_CITY, $1b, $1d
	spawn WEST, $19, $0f
	spawn HIGHTECH, $1f, $0b
	spawn FONT, $03, $0d
	spawn BIRDON, $0f, $05
	spawn NEWTYPE, $07, $09
	spawn SUGAR, $09, $0b
	spawn BLUE_FOREST, $0d, $13
	spawn STAND, $21, $15
	spawn KANTO, $31, $1f
	spawn PRINCE, $05, $05 ; This should be $05, $0f, to line up with the Pokecenter Entrance.
	spawn MT_FUJI, $05, $05
	spawn SOUTH, $21, $0f
	spawn NORTH, $0d, $0b

; Seemingly recognized as valid warps by hacking wFlyDestination, but inaccessible other than through debug Warp

	spawn ROUTE_15, $09, $0b
	spawn ROUTE_18, $0d, $1d

; Hidden warps (do not appear in debug menu normally)

	spawn POWER_PLANT_1, $06, $06
	spawn POWER_PLANT_2, $06, $06
	spawn POWER_PLANT_3, $04, $10
	spawn POWER_PLANT_4, $06, $06

	spawn RUINS_OF_ALPH_ENTRANCE, $09, $0d
	spawn RUINS_OF_ALPH_MAIN, $17, $2f

	spawn CAVE_MINECARTS_1, $06, $0a
	spawn CAVE_MINECARTS_2, $06, $06
	spawn CAVE_MINECARTS_3, $06, $06
	spawn CAVE_MINECARTS_4, $06, $06
	spawn CAVE_MINECARTS_5, $06, $06
	spawn CAVE_MINECARTS_6, $06, $06
	spawn CAVE_MINECARTS_7, $06, $06

	spawn OFFICE_1, $10, $0d
	spawn OFFICE_2, $08, $08
	spawn OFFICE_3, $08, $08

	spawn SLOWPOKE_WELL_ENTRANCE, $09, $0b
	spawn SLOWPOKE_WELL_MAIN, $09, $23

	spawn OLD_CITY_GYM, $06, $06
	spawn WEST_GYM, $06, $06
	spawn HIGHTECH_LEAGUE_2F, $06, $06
	spawn BIRDON_LEAGUE_2F, $06, $06
	spawn NEWTYPE_LEAGUE_2F, $06, $06
	spawn BLUE_LEAGUE_2F, $06, $06
	spawn STAND_LEAGUE_2F, $06, $06
	spawn KANTO_LEAGUE_2F, $06, $06
	spawn KANTO_LEAGUE_2_2F, $06, $06

; Only appears in debug menu, likely for the purposes of testing the demo

	spawn QUIET_HILLS, $10, $10
	spawn N_A, $ff, $ff
	assert_table_length NUM_SPAWNS
