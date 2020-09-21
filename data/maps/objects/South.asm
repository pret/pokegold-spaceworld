INCLUDE "constants.asm"

SECTION "data/maps/objects/South.asm", ROMX

	map_attributes South, SOUTH, NORTH | SOUTH | EAST
	connection north, FontoRoute5, FONTO_ROUTE_5, 10, 0, 10
	connection south, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, 10, 0, 10
	connection east, FontoRoute1, FONTO_ROUTE_1, 0, 0, 9

South_MapEvents::
	dw $4000 ; unknown

	db 9 ; warp events
	warp_event 26, 10, 1, SOUTH_HOUSE_1, wOverworldMapBlocks + 170
	warp_event 33, 14, 1, SOUTH_POKECENTER_1F, wOverworldMapBlocks + 225
	warp_event 19, 22, 1, SOUTH_MART, wOverworldMapBlocks + 322
	warp_event 33, 23, 1, SOUTH_HOUSE_2, wOverworldMapBlocks + 329
	warp_event 30, 5, 1, FONTO_ROUTE_GATE_3, wOverworldMapBlocks + 94
	warp_event 31, 5, 2, FONTO_ROUTE_GATE_3, wOverworldMapBlocks + 94
	warp_event 35, 19, 2, FONTO_ROUTE_GATE_1, wOverworldMapBlocks + 278
	warp_event 30, 30, 3, HAITEKU_WEST_ROUTE_GATE, wOverworldMapBlocks + 432
	warp_event 31, 30, 4, HAITEKU_WEST_ROUTE_GATE, wOverworldMapBlocks + 432

	db 5 ; bg events
	bg_event 30, 14, 0, 1
	bg_event 34, 14, 0, 2
	bg_event 28, 17, 0, 3
	bg_event 16, 22, 0, 4
	bg_event 20, 22, 0, 5

	db 4 ; person events
	object_event 25, 21, SPRITE_TWIN, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24, 21, SPRITE_PIPPI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22, 16, SPRITE_ROCKER, SLOW_STEP_DOWN, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 30, 11, SPRITE_FISHING_GURU, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

South_Blocks::
INCBIN "maps/South.blk"
