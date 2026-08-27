; Spawn points used by Fly, Debug Warp, etc.

MACRO spawn
; map, x, y
	map_id \1
	db \2, \3
ENDM
SpawnPoints:

; Fly destinations
	table_width 4
	spawn SILENT_HILL,             5,   5
	spawn OLD_CITY,               27,  29
	spawn WEST,                   25,  15
	spawn HIGHTECH,               31,  11
	spawn FONT,                    3,  13
	spawn BIRDON,                 15,   5
	spawn NEWTYPE,                 7,   9
	spawn SUGAR,                   9,  11
	spawn BLUE_FOREST,            13,  19
	spawn STAND,                  33,  21
	spawn KANTO,                  49,  31
	spawn PRINCE,                  5,   5 ; this should be 5, 15, to line up with the Pokémon Center entrance
	spawn MT_FUJI,                 5,   5
	spawn SOUTH,                  33,  15
	spawn NORTH,                  13,  11

; Seemingly recognized as valid warps by hacking wFlyDestination, but inaccessible other than through debug Warp

	spawn ROUTE_15,                9,  11
	spawn ROUTE_18,               13,  29

; Hidden warps (do not appear in debug menu normally)

	spawn POWER_PLANT_1,           6,   6
	spawn POWER_PLANT_2,           6,   6
	spawn POWER_PLANT_3,           4,  16
	spawn POWER_PLANT_4,           6,   6

	spawn RUINS_OF_ALPH_ENTRANCE,  9,  13
	spawn RUINS_OF_ALPH_MAIN,     23,  47

	spawn CAVE_MINECARTS_1,        6,  10
	spawn CAVE_MINECARTS_2,        6,   6
	spawn CAVE_MINECARTS_3,        6,   6
	spawn CAVE_MINECARTS_4,        6,   6
	spawn CAVE_MINECARTS_5,        6,   6
	spawn CAVE_MINECARTS_6,        6,   6
	spawn CAVE_MINECARTS_7,        6,   6

	spawn OFFICE_1,               16,  13
	spawn OFFICE_2,                8,   8
	spawn OFFICE_3,                8,   8

	spawn SLOWPOKE_WELL_ENTRANCE,  9,  11
	spawn SLOWPOKE_WELL_MAIN,      9,  35

	spawn OLD_CITY_GYM,            6,   6
	spawn WEST_GYM,                6,   6
	spawn HIGHTECH_LEAGUE_2F,      6,   6
	spawn BIRDON_LEAGUE_2F,        6,   6
	spawn NEWTYPE_LEAGUE_2F,       6,   6
	spawn BLUE_LEAGUE_2F,          6,   6
	spawn STAND_LEAGUE_2F,         6,   6
	spawn KANTO_LEAGUE_2F,         6,   6
	spawn KANTO_LEAGUE_2_2F,       6,   6

; Only appears in debug menu, likely for the purposes of testing the demo

	spawn QUIET_HILLS,            16,  16
	spawn N_A,                   $ff, $ff
	assert_table_length NUM_SPAWNS
