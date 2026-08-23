MACRO warp_const
	db SPAWN_\1
	const WARP_\1
ENDM

WarpMenuOptions::

	db NUM_WARPS ; Number of options in the menu - 43 total stored in data, but most are unused

	const_def
	warp_const SILENT_HILL
	warp_const OLD_CITY
	warp_const WEST
	warp_const HIGHTECH
	warp_const FONT
	warp_const BIRDON
	warp_const NEWTYPE
	warp_const SUGAR
	warp_const BLUE_FOREST
	warp_const STAND
	warp_const KANTO

; PRINCE and MT_FUJI are skipped in the menu
;	warp_const PRINCE
;	warp_const MT_FUJI

	warp_const SOUTH
	warp_const NORTH
	warp_const ROUTE_15
	warp_const ROUTE_18
	warp_const QUIET_HILLS
	db SPAWN_N_A

	DEF NUM_WARPS EQU const_value

	; The demo's options stop here, but the spawn points included actually extend far beyond what is available

	warp_const POWER_PLANT_1
	warp_const POWER_PLANT_2
	warp_const POWER_PLANT_3
	warp_const POWER_PLANT_4
	warp_const RUINS_OF_ALPH_ENTRANCE
	warp_const RUINS_OF_ALPH_MAIN
	warp_const CAVE_MINECARTS_1
	warp_const CAVE_MINECARTS_2
	warp_const CAVE_MINECARTS_3
	warp_const CAVE_MINECARTS_4
	warp_const CAVE_MINECARTS_5
	warp_const CAVE_MINECARTS_6
	warp_const CAVE_MINECARTS_7
	warp_const OFFICE_1
	warp_const OFFICE_2
	warp_const OFFICE_3
	warp_const SLOWPOKE_WELL_ENTRANCE
	warp_const SLOWPOKE_WELL_MAIN
	warp_const OLD_CITY_GYM
	warp_const WEST_GYM
	warp_const HIGHTECH_LEAGUE_2F
	warp_const BIRDON_LEAGUE_2F
	warp_const NEWTYPE_LEAGUE_2F
	warp_const BLUE_LEAGUE_2F
	warp_const STAND_LEAGUE_2F
	warp_const KANTO_LEAGUE_2F
	warp_const KANTO_LEAGUE_2_2F
	db SPAWN_N_A
