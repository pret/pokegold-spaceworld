MACRO scene_pointers
	map_id \1
	dw w\2SceneID, \2ScriptPointers, w\2Flags
ENDM

MapScenes::
	scene_pointers PLAYER_HOUSE_2F,        PlayerHouse2F
	scene_pointers PLAYER_HOUSE_1F,        PlayerHouse1F
	scene_pointers SILENT_HILL,            SilentHill
	scene_pointers SILENT_HILL_LAB_FRONT,  SilentHillLabFront
	scene_pointers SILENT_HILL_LAB_BACK,   SilentHillLabBack
	scene_pointers SILENT_HILL_POKECENTER, SilentHillPokecenter
	scene_pointers RIVAL_HOUSE,            RivalHouse
	scene_pointers ROUTE_1,                Route1
	scene_pointers ROUTE_2,                Route2
	scene_pointers ROUTE_1_GATE_1F,        Route1Gate1F
	scene_pointers ROUTE_1_GATE_2F,        Route1Gate2F
	scene_pointers QUIET_HILLS,            QuietHills
	scene_pointers OLD_CITY_POKECENTER_2F, OldCityPokecenter2F
	db -1
