MACRO newgroup
DEF const_value = const_value + 1
DEF CURRENT_NUM_MAPGROUP_MAPS EQUS "NUM_\1_MAPS"
DEF MAPGROUP_\1 EQU const_value
DEF __map_value__ = 1
ENDM

MACRO map_const
;\1: map id
;\2: width: in blocks
;\3: height: in blocks
DEF GROUP_\1 EQU const_value
DEF MAP_\1 EQU __map_value__
DEF __map_value__ = __map_value__ + 1
DEF \1_WIDTH EQU \2
DEF \1_HEIGHT EQU \3
ENDM

MACRO endgroup
DEF {CURRENT_NUM_MAPGROUP_MAPS} EQU __map_value__ - 1
PURGE CURRENT_NUM_MAPGROUP_MAPS
ENDM

; map ids
	const_def

	newgroup  SILENT                                   ;  1
	map_const ROUTE_1_P1,                       15,  9 ;  1
	map_const ROUTE_1_P2,                       10, 18 ;  2
	map_const ROUTE_SILENT_EAST,                30,  9 ;  3
	map_const SILENT_HILL,                      10,  9 ;  4
	map_const ROUTE_1_GATE_1F,                   5,  4 ;  5
	map_const ROUTE_1_GATE_2F,                   4,  3 ;  6
	map_const ROUTE_SILENT_EAST_GATE,            5,  4 ;  7
	map_const PLAYER_HOUSE_1F,                   5,  4 ;  8
	map_const PLAYER_HOUSE_2F,                   5,  4 ;  9
	map_const SILENT_HILL_POKECENTER,            8,  4 ; 10
	map_const SILENT_HILL_HOUSE,                 5,  4 ; 11
	map_const SILENT_HILL_LAB_FRONT,             4,  8 ; 12
	map_const SILENT_HILL_LAB_BACK,              4,  4 ; 13
	map_const UNUSED_MAP_13,                     4,  4 ; 14
	map_const SHIZUKANA_OKA,                    25, 18 ; 15
	endgroup

	newgroup  OLD                                      ;  2
	map_const ROUTE_2,                          15,  9 ;  1
	map_const OLD_CITY,                         20, 18 ;  2
	map_const ROUTE_2_GATE_1F,                   5,  4 ;  3
	map_const ROUTE_2_GATE_2F,                   4,  3 ;  4
	map_const ROUTE_2_HOUSE,                     4,  4 ;  5
	map_const OLD_CITY_MUSEUM,                   8,  4 ;  6
	map_const OLD_CITY_GYM,                      5,  9 ;  7
	map_const OLD_CITY_TOWER_1F,                 4,  4 ;  8
	map_const OLD_CITY_TOWER_2F,                 4,  4 ;  9
	map_const OLD_CITY_TOWER_3F,                 4,  4 ; 10
	map_const OLD_CITY_TOWER_4F,                 4,  4 ; 11
	map_const OLD_CITY_TOWER_5F,                 3,  3 ; 12
	map_const OLD_CITY_BILLS_HOUSE,              4,  4 ; 13
	map_const OLD_CITY_MART,                     6,  4 ; 14
	map_const OLD_CITY_HOUSE,                    4,  4 ; 15
	map_const OLD_CITY_POKECENTER_1F,            8,  4 ; 16
	map_const OLD_CITY_POKECENTER_2F,            8,  4 ; 17
	map_const OLD_CITY_POKECENTER_TRADE,         5,  4 ; 18
	map_const OLD_CITY_POKECENTER_BATTLE,        5,  4 ; 19
	map_const OLD_CITY_POKECENTER_TIME_MACHINE,  8,  4 ; 20
	map_const OLD_CITY_KURTS_HOUSE,              8,  4 ; 21
	map_const OLD_CITY_SCHOOL,                   4,  8 ; 22
	endgroup

	newgroup  WEST                                     ;  3
	map_const WEST,                             20, 18 ;  1
	map_const WEST_MART_1F,                      8,  4 ;  2
	map_const WEST_MART_2F,                      8,  4 ;  3
	map_const WEST_MART_3F,                      8,  4 ;  4
	map_const WEST_MART_4F,                      8,  4 ;  5
	map_const WEST_MART_5F,                      8,  4 ;  6
	map_const WEST_MART_6F,                      8,  4 ;  7
	map_const WEST_MART_ELEVATOR,                2,  2 ;  8
	map_const WEST_RADIO_TOWER_1F,               4,  4 ;  9
	map_const WEST_RADIO_TOWER_2F,               4,  4 ; 10
	map_const WEST_RADIO_TOWER_3F,               4,  4 ; 11
	map_const WEST_RADIO_TOWER_4F,               4,  4 ; 12
	map_const WEST_RADIO_TOWER_5F,               4,  4 ; 13
	map_const WEST_ROCKET_RAIDED_HOUSE,          5,  4 ; 14
	map_const WEST_POKECENTER_1F,                8,  4 ; 15
	map_const WEST_POKECENTER_2F,                8,  4 ; 16
	map_const WEST_GYM,                          5,  9 ; 17
	map_const WEST_HOUSE_1,                      5,  4 ; 18
	map_const WEST_HOUSE_2,                      5,  4 ; 19
	endgroup

	newgroup  HAITEKU                                  ;  4
	map_const HAITEKU_WEST_ROUTE,               25,  9 ;  1
	map_const HAITEKU_WEST_ROUTE_OCEAN,         10, 27 ;  2
	map_const HAITEKU,                          20, 18 ;  3
	map_const HAITEKU_WEST_ROUTE_GATE,           5,  4 ;  4
	map_const HAITEKU_POKECENTER_1F,             8,  4 ;  5
	map_const HAITEKU_POKECENTER_2F,             8,  4 ;  6
	map_const HAITEKU_LEAGUE_1F,                 4,  8 ;  7
	map_const HAITEKU_LEAGUE_2F,                 5,  9 ;  8
	map_const HAITEKU_MART,                      6,  4 ;  9
	map_const HAITEKU_HOUSE_1,                   5,  4 ; 10
	map_const HAITEKU_HOUSE_2,                   5,  4 ; 11
	map_const HAITEKU_IMPOSTER_OAK_HOUSE,        5,  4 ; 12
	map_const HAITEKU_AQUARIUM_1F,               8,  4 ; 13
	map_const HAITEKU_AQUARIUM_2F,               8,  4 ; 14
	endgroup

	newgroup  FONTO                                    ;  5
	map_const FONTO_ROUTE_1,                    35,  9 ;  1
	map_const FONTO_ROUTE_2,                    10, 18 ;  2
	map_const FONTO_ROUTE_3,                    25,  9 ;  3
	map_const FONTO_ROUTE_4,                    10, 18 ;  4
	map_const FONTO_ROUTE_5,                    10, 18 ;  5
	map_const FONTO_ROUTE_6,                    35,  9 ;  6
	map_const FONTO,                            10,  9 ;  7
	map_const FONTO_ROUTE_GATE_1,                5,  4 ;  8
	map_const FONTO_ROUTE_GATE_2,                5,  4 ;  9
	map_const FONTO_ROUTE_GATE_3,                5,  4 ; 10
	map_const FONTO_ROCKET_HOUSE,                8,  4 ; 11
	map_const FONTO_MART,                        8,  4 ; 12
	map_const FONTO_HOUSE,                       5,  4 ; 13
	map_const FONTO_POKECENTER_1F,               8,  4 ; 14
	map_const FONTO_POKECENTER_2F,               8,  4 ; 15
	map_const FONTO_LAB,                         5,  4 ; 16
	endgroup

	newgroup  BAADON                                   ;  6
	map_const BAADON_ROUTE_1,                   10, 27 ;  1
	map_const BAADON_ROUTE_2,                   50,  9 ;  2
	map_const BAADON_ROUTE_3,                   10, 18 ;  3
	map_const BAADON,                           10,  9 ;  4
	map_const BAADON_ROUTE_GATE_WEST,            5,  4 ;  5
	map_const BAADON_ROUTE_GATE_NEWTYPE,         5,  4 ;  6
	map_const BAADON_MART,                       8,  4 ;  7
	map_const BAADON_POKECENTER_1F,              8,  4 ;  8
	map_const BAADON_POKECENTER_2F,              8,  4 ;  9
	map_const BAADON_HOUSE_1,                    4,  4 ; 10
	map_const BAADON_WALLPAPER_HOUSE,            4,  4 ; 11
	map_const BAADON_HOUSE_2,                    5,  4 ; 12
	map_const BAADON_LEAGUE_1F,                  4,  8 ; 13
	map_const BAADON_LEAGUE_2F,                  5,  9 ; 14
	endgroup

	newgroup  NEWTYPE                                  ;  7
	map_const ROUTE_15,                         15,  9 ;  1
	map_const NEWTYPE_ROUTE,                    15,  9 ;  2
	map_const ROUTE_18,                         10, 45 ;  3
	map_const NEWTYPE,                          20, 18 ;  4
	map_const ROUTE_15_POKECENTER_1F,            8,  4 ;  5
	map_const ROUTE_15_POKECENTER_2F,            8,  4 ;  6
	map_const NEWTYPE_ROUTE_GATE,                5,  4 ;  7
	map_const ROUTE_18_POKECENTER_1F,            8,  4 ;  8
	map_const ROUTE_18_POKECENTER_2F,            8,  4 ;  9
	map_const NEWTYPE_POKECENTER_1F,             8,  4 ; 10
	map_const NEWTYPE_POKECENTER_2F,             8,  4 ; 11
	map_const NEWTYPE_LEAGUE_1F,                 4,  8 ; 12
	map_const NEWTYPE_LEAGUE_2F,                 5,  9 ; 13
	map_const NEWTYPE_SAILOR_HOUSE,              5,  4 ; 14
	map_const NEWTYPE_MART,                      8,  4 ; 15
	map_const NEWTYPE_DOJO,                      4,  8 ; 16
	map_const NEWTYPE_HOUSE_1,                   5,  4 ; 17
	map_const NEWTYPE_DINER,                     4,  4 ; 18
	map_const NEWTYPE_HOUSE_2,                   5,  4 ; 19
	map_const NEWTYPE_HOUSE_3,                   5,  4 ; 20
	endgroup

	newgroup  SUGAR                                    ;  8
	map_const SUGAR_ROUTE,                      10, 27 ;  1
	map_const SUGAR,                            10,  9 ;  2
	map_const SUGAR_ROUTE_GATE,                  5,  4 ;  3
	map_const SUGAR_HOUSE,                       4,  8 ;  4
	map_const SUGAR_HOUSE_2,                     4,  4 ;  5
	map_const SUGAR_MART,                        8,  4 ;  6
	map_const SUGAR_POKECENTER_1F,               8,  4 ;  7
	map_const SUGAR_POKECENTER_2F,               8,  4 ;  8
	endgroup

	newgroup  BULL                                     ;  9
	map_const BULL_FOREST_ROUTE_1,              25,  9 ;  1
	map_const BULL_FOREST_ROUTE_2,              10, 27 ;  2
	map_const BULL_FOREST_ROUTE_3,              10, 27 ;  3
	map_const BULL_FOREST,                      20, 18 ;  4
	map_const BULL_FOREST_ROUTE_1_HOUSE,         5,  4 ;  5
	map_const BULL_FOREST_ROUTE_GATE_STAND,      5,  4 ;  6
	map_const BULL_MART,                         8,  4 ;  7
	map_const BULL_HOUSE_1,                      4,  4 ;  8
	map_const BULL_HOUSE_2,                      5,  4 ;  9
	map_const BULL_HOUSE_3,                      5,  4 ; 10
	map_const BULL_POKECENTER_1F,                8,  4 ; 11
	map_const BULL_POKECENTER_2F,                8,  4 ; 12
	map_const BULL_LEAGUE_1F,                    4,  8 ; 13
	map_const BULL_LEAGUE_2F,                    5,  9 ; 14
	map_const BULL_HOUSE_4,                      5,  4 ; 15
	endgroup

	newgroup  STAND                                    ; 10
	map_const STAND_ROUTE,                      10, 27 ;  1
	map_const STAND,                            20, 18 ;  2
	map_const STAND_ROUTE_GATE_KANTO,            5,  4 ;  3
	map_const STAND_LAB,                         4,  4 ;  4
	map_const STAND_POKECENTER_1F,               8,  4 ;  5
	map_const STAND_POKECENTER_2F,               8,  4 ;  6
	map_const STAND_OFFICE,                      8,  4 ;  7
	map_const STAND_MART,                        8,  4 ;  8
	map_const STAND_HOUSE,                       5,  4 ;  9
	map_const STAND_ROCKET_HOUSE_1F,             8,  4 ; 10
	map_const STAND_ROCKET_HOUSE_2F,             8,  4 ; 11
	map_const STAND_LEAGUE_1F,                   4,  8 ; 12
	map_const STAND_LEAGUE_2F,                   5,  9 ; 13
	endgroup

	newgroup  KANTO                                    ; 11
	map_const KANTO_EAST_ROUTE,                 20,  9 ;  1
	map_const KANTO,                            30, 27 ;  2
	map_const KANTO_CERULEAN_HOUSE,              5,  4 ;  3
	map_const KANTO_POKECENTER_1F,               8,  4 ;  4
	map_const KANTO_POKECENTER_2F,               8,  4 ;  5
	map_const KANTO_LEAGUE_1F,                   4,  8 ;  6
	map_const KANTO_LEAGUE_2F,                   5,  9 ;  7
	map_const KANTO_LAVENDER_HOUSE,              5,  4 ;  8
	map_const KANTO_CELADON_MART_1F,             8,  4 ;  9
	map_const KANTO_CELADON_MART_2F,             8,  4 ; 10
	map_const KANTO_CELADON_MART_3F,             8,  4 ; 11
	map_const KANTO_CELADON_MART_4F,             8,  4 ; 12
	map_const KANTO_CELADON_MART_5F,             8,  4 ; 13
	map_const KANTO_CELADON_ELEVATOR,            2,  2 ; 14
	map_const KANTO_MART,                        8,  4 ; 15
	map_const KANTO_GAMEFREAK_HQ_1,              4,  6 ; 16
	map_const KANTO_GAMEFREAK_HQ_2,              4,  6 ; 17
	map_const KANTO_GAMEFREAK_HQ_3,              4,  6 ; 18
	map_const KANTO_GAMEFREAK_HQ_4,              4,  6 ; 19
	map_const KANTO_GAMEFREAK_HQ_5,              4,  4 ; 20
	map_const KANTO_SILPH_CO,                   12,  8 ; 21
	map_const KANTO_VIRIDIAN_HOUSE,              5,  4 ; 22
	map_const KANTO_GAME_CORNER,                10,  7 ; 23
	map_const KANTO_UNUSED_AREA,                 4,  4 ; 24
	map_const KANTO_GAME_CORNER_PRIZES,          5,  4 ; 25
	map_const KANTO_DINER,                       5,  4 ; 26
	map_const KANTO_SCHOOL,                      4,  8 ; 27
	map_const KANTO_HOSPITAL,                    8,  4 ; 28
	map_const KANTO_POKECENTER_2_1F,             8,  4 ; 29
	map_const KANTO_POKECENTER_2_2F,             8,  4 ; 30
	map_const KANTO_REDS_HOUSE,                  5,  4 ; 31
	map_const KANTO_GREENS_HOUSE_1F,             4,  4 ; 32
	map_const KANTO_GREENS_HOUSE_2F,             4,  4 ; 33
	map_const KANTO_ELDERS_HOUSE,                5,  4 ; 34
	map_const KANTO_OAKS_LAB,                    4,  4 ; 35
	map_const KANTO_LEAGUE_2_1F,                 4,  8 ; 36
	map_const KANTO_LEAGUE_2_2F,                 5,  9 ; 37
	map_const KANTO_FISHING_GURU,                5,  4 ; 38
	endgroup

	newgroup  PRINCE                                   ; 12
	map_const PRINCE_ROUTE,                     10,  5 ;  1
	map_const PRINCE,                           10,  9 ;  2
	endgroup

	newgroup  MT_FUJI                                  ; 13
	map_const MT_FUJI_ROUTE,                    10,  5 ;  1
	map_const MT_FUJI,                          10,  9 ;  2
	endgroup

	newgroup  SOUTH                                    ; 14
	map_const SOUTH,                            20, 18 ;  1
	map_const SOUTH_HOUSE_1,                     5,  4 ;  2
	map_const SOUTH_POKECENTER_1F,               8,  4 ;  3
	map_const SOUTH_POKECENTER_2F,               8,  4 ;  4
	map_const SOUTH_MART,                        8,  4 ;  5
	map_const SOUTH_HOUSE_2,                     5,  4 ;  6
	endgroup

	newgroup  NORTH                                    ; 15
	map_const NORTH,                            10,  9 ;  1
	map_const NORTH_HOUSE_1,                     5,  4 ;  2
	map_const NORTH_MART,                        6,  4 ;  3
	map_const NORTH_HOUSE_2,                     5,  4 ;  4
	map_const NORTH_POKECENTER_1F,               8,  4 ;  5
	map_const NORTH_POKECENTER_2F,               8,  4 ;  6
	endgroup

	newgroup  MISC                                     ; 16
	map_const POWER_PLANT_1,                    10,  9 ;  1
	map_const POWER_PLANT_2,                    10,  9 ;  2
	map_const POWER_PLANT_3,                    15, 18 ;  3
	map_const POWER_PLANT_4,                    15, 18 ;  4
	map_const RUINS_OF_ALPH_ENTRANCE,           10,  9 ;  5
	map_const RUINS_OF_ALPH_MAIN,               25, 27 ;  6
	map_const CAVE_MINECARTS_1,                 20, 18 ;  7
	map_const CAVE_MINECARTS_2,                 20, 18 ;  8
	map_const CAVE_MINECARTS_3,                 20, 18 ;  9
	map_const CAVE_MINECARTS_4,                 20, 18 ; 10
	map_const CAVE_MINECARTS_5,                 20, 18 ; 11
	map_const CAVE_MINECARTS_6,                 10, 18 ; 12
	map_const CAVE_MINECARTS_7,                 10, 18 ; 13
	map_const OFFICE_1,                         10,  9 ; 14
	map_const OFFICE_2,                         15, 18 ; 15
	map_const OFFICE_3,                         10, 18 ; 16
	map_const SLOWPOKE_WELL_ENTRANCE,           10,  9 ; 17
	map_const SLOWPOKE_WELL_MAIN,               10, 18 ; 18
	endgroup

	newgroup  EMPTY                                    ; 17
	endgroup

DEF NUM_MAP_GROUPS EQU const_value
