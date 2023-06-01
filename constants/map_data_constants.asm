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

; connection directions (see data/maps/data.asm)
	const_def
	const EAST_F
	const WEST_F
	const SOUTH_F
	const NORTH_F

; wMapConnections
	const_def
	shift_const EAST
	shift_const WEST
	shift_const SOUTH
	shift_const NORTH

; SpawnPoints indexes (see data/maps/spawn_points.asm)
DEF const_value = -1
	const SPAWN_N_A
DEF NUM_SPAWNS EQU 18

; size of each spawn point data
DEF SPAWN_POINT_SIZE EQU 4

; size of sprite sets (see data/maps/sprite_sets.asm)
DEF SPRITE_SET_LENGTH EQU 10
