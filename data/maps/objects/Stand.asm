INCLUDE "constants.asm"

SECTION "data/maps/objects/Stand.asm", ROMX

	map_attributes Stand, STAND, NORTH | SOUTH
	connection north, BullForestRoute2, BULL_FOREST_ROUTE_2, 10
	connection south, StandRoute, STAND_ROUTE, 10

Stand_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 24, 17, STAND_LAB, 1, 247
	warp_event 33, 20, STAND_POKECENTER_1F, 1, 303
	warp_event 16, 21, STAND_OFFICE, 1, 295
	warp_event 35, 26, STAND_MART, 1, 382
	warp_event 26, 29, STAND_HOUSE, 1, 404
	warp_event 17, 31, STAND_ROCKET_HOUSE_1F, 1, 425
	warp_event 34, 31, STAND_LEAGUE_1F, 1, 434
	warp_event 35, 31, STAND_LEAGUE_1F, 2, 434
	warp_event 30, 13, BULL_FOREST_ROUTE_GATE_STAND, 1, 198
	warp_event 31, 13, BULL_FOREST_ROUTE_GATE_STAND, 2, 198

	def_bg_events
	bg_event  8,  8, 0, 1
	bg_event 14,  8, 0, 2
	bg_event 20, 10, 0, 3
	bg_event 16, 16, 0, 4
	bg_event 10, 20, 0, 5
	bg_event 18, 21, 0, 6
	bg_event 24, 20, 0, 7
	bg_event 34, 20, 0, 8
	bg_event 36, 26, 0, 9
	bg_event 32, 35, 0, 10

	def_object_events
	object_event 10, 10, SPRITE_POKEFAN_M, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 17, SPRITE_TWIN, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 28, 19, SPRITE_ROCKER, FACE_RIGHT, 0, 3, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 30, 31, SPRITE_TEACHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 21,  8, SPRITE_SIDON, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  6, SPRITE_PIPPI, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  6, SPRITE_SIDON, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 15, SPRITE_POPPO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6, 21, SPRITE_SIDON, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

Stand_Blocks::
INCBIN "maps/Stand.blk"
