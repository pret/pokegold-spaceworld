map_id: MACRO
;\1: map id
	db GROUP_\1, MAP_\1
ENDM

map_attributes: MACRO
;\1: map name
;\2: map id
;\3: connections: combo of NORTH, SOUTH, WEST, and/or EAST, or 0 for none
CURRENT_MAP_WIDTH = \2_WIDTH
CURRENT_MAP_HEIGHT = \2_HEIGHT
\1_MapAttributes::
	db CURRENT_MAP_HEIGHT, CURRENT_MAP_WIDTH
	dw \1_Blocks
	dw \1_Unk
	dw \1_MapScripts
	dw \1_MapEvents
	db \3
ENDM

; Connections go in order: north, south, west, east
connection: MACRO
;\1: direction
;\2: map name
;\3: map id
;\4: final y offset for east/west, x offset for north/south
;\5: map data y offset for east/west, x offset for north/south
;\6: strip length
if "\1" == "north"
	map_id \3
	dw \2_Blocks + \3_WIDTH * (\3_HEIGHT - 3) + \5
	dw wOverworldMapBlocks + \4 + 3
	db \6
	db \3_WIDTH
	db \3_HEIGHT * 2 - 1
	db (\4 - \5) * -2
	dw wOverworldMapBlocks + \3_HEIGHT * (\3_WIDTH + 6) + 1
elif "\1" == "south"
	map_id \3
	dw \2_Blocks + \5
	dw wOverworldMapBlocks + (CURRENT_MAP_HEIGHT + 3) * (CURRENT_MAP_WIDTH + 6) + \4 + 3
	db \6
	db \3_WIDTH
	db 0
	db (\4 - \5) * -2
	dw wOverworldMapBlocks + \3_WIDTH + 7
elif "\1" == "west"
	map_id \3
	dw \2_Blocks + (\3_WIDTH * \5) + \3_WIDTH - 3
	dw wOverworldMapBlocks + (CURRENT_MAP_WIDTH + 6) * (\4 + 3)
	db \6
	db \3_WIDTH
	db (\4 - \5) * -2
	db \3_WIDTH * 2 - 1
	dw wOverworldMapBlocks + \3_WIDTH * 2 + 6
elif "\1" == "east"
	map_id \3
	dw \2_Blocks + (\3_WIDTH * \5)
	dw wOverworldMapBlocks + (CURRENT_MAP_WIDTH + 6) * (\4 + 3 + 1) - 3
	db \6
	db \3_WIDTH
	db (\4 - \5) * -2
	db 0
	dw wOverworldMapBlocks + \3_WIDTH + 7
endc
ENDM

map: MACRO
;\1: map name: for the MapAttributes pointer (see data/maps/attributes.asm)
;\2: tileset: a TILESET_* constant
;\3: environment: TOWN, ROUTE, INDOOR, CAVE, ENVIRONMENT_5, GATE, or DUNGEON
;\4: location: from constants/landmark_constants.asm
	db BANK(\1_MapAttributes), \2, \3
	dw \1_MapAttributes
	db \4
	db 0, 0 ; ???
ENDM

warp_event: MACRO
    db \2, \1 ; y, x
    db \3 ; index
    map_id \4
    dw \5 ; unused wOverworldMap offset
ENDM

bg_event: MACRO
	db \2, \1 ; y, x
	db \3 ; function (unused?)
	db \4 ; text index
ENDM

object_event: MACRO
	db \3 ; sprite
	db \2 + 4, \1 + 4 ; x, y
	db \4 ; movement function
	dn \5, \6 ; radius
	db \7, \8 ; hour limits?
	shift
	db \8 ; object type function
	shift
	db \8, \9 ; unknown 1, 2
	shift
	db \9 ; sight range
	shift
	db \9 ; unknown 3
	shift
	db \9 ; unknown 4
ENDM