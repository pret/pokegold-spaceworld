DEF GROUP_N_A  EQU -1
DEF MAP_N_A    EQU -1
DEF GROUP_NONE EQU 0
DEF MAP_NONE   EQU 0

; map struct members (see data/maps/maps.asm)
	const_def
	const MAP_MAPATTRIBUTES_BANK ; 0
	const MAP_TILESET            ; 1
	const MAP_ENVIRONMENT        ; 2
	const MAP_MAPATTRIBUTES      ; 3
	const MAP_MAPATTRIBUTES_HI   ; 4
	const MAP_LOCATION           ; 5
	const MAP_MUSIC              ; 6
	const MAP_PALETTE            ; 7
	const MAP_FISHGROUP          ; 8

; map environments (wEnvironment)
	const_def 1
	const TOWN
	const ROUTE
	const INDOOR
	const CAVE
	const ENVIRONMENT_5
	const GATE
	const DUNGEON

; map palettes (wEnvironment)
	const_def
	const PALETTE_AUTO
	const PALETTE_DAY
	const PALETTE_NITE
	const PALETTE_MORN
	const PALETTE_DARK
DEF NUM_MAP_PALETTES EQU const_value

; FishGroups indexes (see data/wild/fish.asm)
	const_def
	const FISHGROUP_NONE
	const FISHGROUP_SHORE
	const FISHGROUP_OCEAN
	const FISHGROUP_LAKE
	const FISHGROUP_POND
	const FISHGROUP_DRATINI
	const FISHGROUP_QWILFISH_SWARM
	const FISHGROUP_REMORAID_SWARM
	const FISHGROUP_GYARADOS
	const FISHGROUP_DRATINI_2
	const FISHGROUP_WHIRL_ISLANDS
	const FISHGROUP_QWILFISH
	const FISHGROUP_REMORAID
	const FISHGROUP_QWILFISH_NO_SWARM

; wMapConnections / connection directions (see data/maps/data.asm)
	const_def
	shift_const EAST
	shift_const WEST
	shift_const SOUTH
	shift_const NORTH

; SpawnPoints indexes (see data/maps/spawn_points.asm and data/maps/debug_warps.asm) 
	const_def
	const SPAWN_NONE
	const SPAWN_SILENT_HILL
	const SPAWN_OLD_CITY
	const SPAWN_WEST
	const SPAWN_HIGHTECH
	const SPAWN_FONT
	const SPAWN_BIRDON
	const SPAWN_NEWTYPE
	const SPAWN_SUGAR
	const SPAWN_BLUE_FOREST
	const SPAWN_STAND
	const SPAWN_KANTO
	const SPAWN_PRINCE
	const SPAWN_MT_FUJI
	const SPAWN_SOUTH
	const SPAWN_NORTH
	const SPAWN_ROUTE_15
	const SPAWN_ROUTE_18
	const SPAWN_POWER_PLANT_1
	const SPAWN_POWER_PLANT_2
	const SPAWN_POWER_PLANT_3
	const SPAWN_POWER_PLANT_4
	const SPAWN_RUINS_OF_ALPH_ENTRANCE
	const SPAWN_RUINS_OF_ALPH_MAIN
	const SPAWN_CAVE_MINECARTS_1
	const SPAWN_CAVE_MINECARTS_2
	const SPAWN_CAVE_MINECARTS_3
	const SPAWN_CAVE_MINECARTS_4
	const SPAWN_CAVE_MINECARTS_5
	const SPAWN_CAVE_MINECARTS_6
	const SPAWN_CAVE_MINECARTS_7
	const SPAWN_OFFICE_1
	const SPAWN_OFFICE_2
	const SPAWN_OFFICE_3
	const SPAWN_SLOWPOKE_WELL_ENTRANCE
	const SPAWN_SLOWPOKE_WELL_MAIN
	const SPAWN_OLD_CITY_GYM
	const SPAWN_WEST_GYM
	const SPAWN_HIGHTECH_LEAGUE_2F
	const SPAWN_BIRDON_LEAGUE_2F
	const SPAWN_NEWTYPE_LEAGUE_2F
	const SPAWN_BLUE_LEAGUE_2F
	const SPAWN_STAND_LEAGUE_2F
	const SPAWN_KANTO_LEAGUE_2F
	const SPAWN_KANTO_LEAGUE_2_2F
	const SPAWN_QUIET_HILLS
DEF NUM_SPAWNS EQU const_value

DEF SPAWN_N_A EQU -1

; Flypoints indexes (see data/maps/flypoints.asm)
	const_def
	const FLY_POINT_SILENT_HILL ; 0
	const FLY_POINT_OLD         ; 1
	const FLY_POINT_WEST        ; 2
	const FLY_POINT_HIGH_TECH   ; 3
	const FLY_POINT_FONT        ; 4
	const FLY_POINT_BIRDON      ; 5
	const FLY_POINT_NEWTYPE     ; 6
	const FLY_POINT_SUGAR       ; 7
	const FLY_POINT_BLUE_FOREST ; 8
	const FLY_POINT_STAND       ; 9
	const FLY_POINT_KANTO       ; 10
	const FLY_POINT_PRINCE      ; 11
	const FLY_POINT_MT_FUJI     ; 12
	const FLY_POINT_SOUTH       ; 13
	const FLY_POINT_NORTH       ; 14
; Unused?
	const FLY_POINT_ROUTE_15    ; 15
	const FLY_POINT_ROUTE_18    ; 16
	const FLY_POINT_17			; 17 ; Deleted map? Sends to Power Plant 1, which is an interior map.
DEF NUM_FLYPOINTS EQU const_value

DEF FLY_POINT_N_A EQU $FF

; size of each spawn point data
DEF SPAWN_POINT_SIZE EQU 4

DEF MAX_NUM_WARP_EVENTS EQU 32

DEF MAX_NUM_BG_EVENTS EQU 16

; size of sprite sets (see data/maps/sprite_sets.asm)
DEF SPRITE_SET_LENGTH EQU 10

; CutReplacementBlocks indexes (see data/collision/cut_blocks.asm)
	const_def 4
	const BLOCK_GRASS                        ; $04
	const_skip 31
	const BLOCK_TREES_TOP_LEFT_CORNER        ; $24
	const BLOCK_TREES_TOP_CENTER             ; $25
	const BLOCK_TREES_TOP_RIGHT_CORNER       ; $26
	const_skip
	const BLOCK_TREES_MIDDLE_LEFT            ; $28
	const_skip
	const BLOCK_TREES_MIDDLE_RIGHT           ; $2a
	const_skip
	const BLOCK_TREES_BOTTOM_LEFT_CORNER     ; $2c
	const BLOCK_TREES_BOTTOM_CENTER          ; $2d
	const BLOCK_TREES_BOTTOM_RIGHT_CORNER    ; $2e
	const_skip
	const BLOCK_TREES_TOP_CENTER_CUT_TREE    ; $30 (variant of $25)
	const BLOCK_TREES_MIDDLE_RIGHT_CUT_TREE  ; $31 (variant of $2A)
	const BLOCK_1_TREE_TOP_LEFT_CUT_TREE     ; $32 (variant of $34)
	const BLOCK_1_TREE_BOTTOM_RIGHT_CUT_TREE ; $33 (variant of $35)
	const BLOCK_1_TREE_TOP_LEFT              ; $34
	const BLOCK_1_TREE_BOTTOM_RIGHT          ; $35
	const_skip 5
	const BLOCK_TALL_GRASS                   ; $3b (variant of $04)
