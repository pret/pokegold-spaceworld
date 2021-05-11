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
	dw \1_TextPointers
	dw \1_ScriptLoader
	dw \1_MapEvents
	db \3
ENDM

; Connections go in order: north, south, west, east
connection: MACRO
;\1: direction
;\2: map name
;\3: map id
;\4: offset of the target map relative to the current map
;    (x offset for east/west, y offset for north/south)

; LEGACY: Support for old connection macro
if _NARG == 6
	connection \1, \2, \3, (\4) - (\5)
else

; Calculate tile offsets for source (current) and target maps
_src = 0
_tgt = (\4) + 3
if _tgt < 0
_src = -_tgt
_tgt = 0
endc

if !STRCMP("\1", "north")
_blk = \3_WIDTH * (\3_HEIGHT - 3) + _src
_map = _tgt
_win = (\3_WIDTH + 6) * \3_HEIGHT + 1
_y = \3_HEIGHT * 2 - 1
_x = (\4) * -2
_len = CURRENT_MAP_WIDTH + 3 - (\4)
if _len > \3_WIDTH
_len = \3_WIDTH
endc

elif !STRCMP("\1", "south")
_blk = _src
_map = (CURRENT_MAP_WIDTH + 6) * (CURRENT_MAP_HEIGHT + 3) + _tgt
_win = \3_WIDTH + 7
_y = 0
_x = (\4) * -2
_len = CURRENT_MAP_WIDTH + 3 - (\4)
if _len > \3_WIDTH
_len = \3_WIDTH
endc

elif !STRCMP("\1", "west")
_blk = (\3_WIDTH * _src) + \3_WIDTH - 3
_map = (CURRENT_MAP_WIDTH + 6) * _tgt
_win = (\3_WIDTH + 6) * 2 - 6
_y = (\4) * -2
_x = \3_WIDTH * 2 - 1
_len = CURRENT_MAP_HEIGHT + 3 - (\4)
if _len > \3_HEIGHT
_len = \3_HEIGHT
endc

elif !STRCMP("\1", "east")
_blk = (\3_WIDTH * _src)
_map = (CURRENT_MAP_WIDTH + 6) * _tgt + CURRENT_MAP_WIDTH + 3
_win = \3_WIDTH + 7
_y = (\4) * -2
_x = 0
_len = CURRENT_MAP_HEIGHT + 3 - (\4)
if _len > \3_HEIGHT
_len = \3_HEIGHT
endc

else
fail "Invalid direction for 'connection'."
endc

	map_id \3
	dw \2_Blocks + _blk
	dw wOverworldMapBlocks + _map
	db _len - _src
	db \3_WIDTH
	db _y, _x
	dw wOverworldMapBlocks + _win
endc
ENDM

def_warp_events: MACRO
if DEF(_NUM_WARP_EVENTS)
	PURGE _NUM_WARP_EVENTS
endc
_NUM_WARP_EVENTS EQUS "_NUM_WARP_EVENTS_\@"
	db _NUM_WARP_EVENTS
_NUM_WARP_EVENTS = 0
ENDM

warp_event: MACRO
;\1: x: left to right, starts at 0
;\2: y: top to bottom, starts at 0
;\3: map id: from constants/map_constants.asm
;\4: warp destination: starts at 1
;\5: wOverworldMapBlocks offset (unused)
	db \2, \1, \4
	map_id \3
	dw wOverworldMapBlocks + \5
_NUM_WARP_EVENTS = _NUM_WARP_EVENTS + 1
ENDM

def_bg_events: MACRO
if DEF(_NUM_BG_EVENTS)
	PURGE _NUM_BG_EVENTS
endc
_NUM_BG_EVENTS EQUS "_NUM_BG_EVENTS_\@"
	db _NUM_BG_EVENTS
_NUM_BG_EVENTS = 0
ENDM

bg_event: MACRO
;\1: x: left to right, starts at 0
;\2: y: top to bottom, starts at 0
;\3: text index
	db \2, \1, 0, \3
_NUM_BG_EVENTS = _NUM_BG_EVENTS + 1
ENDM

def_object_events: MACRO
if DEF(_NUM_OBJECT_EVENTS)
	PURGE _NUM_OBJECT_EVENTS
endc
_NUM_OBJECT_EVENTS EQUS "_NUM_OBJECT_EVENTS_\@"
	db _NUM_OBJECT_EVENTS
_NUM_OBJECT_EVENTS = 0
ENDM

object_event: MACRO
;\1: x: left to right, starts at 0
;\2: y: top to bottom, starts at 0
;\3: sprite: a SPRITE_* constant
;\4: movement function: a SPRITEMOVEDATA_* constant
;\5, \6: movement radius: x, y
;\7, \8: hour limits: h1, h2 (0-23)
;  * if h1 < h2, the object_event will only appear from h1 to h2
;  * if h1 > h2, the object_event will not appear from h2 to h1
;  * if h1 == h2, the object_event will always appear
;  * if h1 == -1, h2 is treated as a time-of-day value:
;    a combo of MORN, DAY, and/or NITE, or -1 to always appear
;\9: object type function
;\<10>: unknown 1
;\<11>: unknown 2
;\<12>: sight range
;\<13>: unknown 3
;\<14>: unknown 4
	db \3, \2 + 4, \1 + 4, \4
	dn \5, \6
	db \7, \8, \9, \<10>, \<11>, \<12>, \<13>, \<14>
_NUM_OBJECT_EVENTS = _NUM_OBJECT_EVENTS + 1
ENDM
