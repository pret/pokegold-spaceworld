INCLUDE "constants.asm"

SECTION "data/maps/attributes/BullForest.asm", ROMX
	map_attributes BullForest, BULL_FOREST, NORTH | SOUTH | WEST
	connection north, BullForestRoute3, BULL_FOREST_ROUTE_3, 5, 0, 10
	connection south, BullForestRoute2, BULL_FOREST_ROUTE_2, 5, 0, 10
	connection west, BullForestRoute1, BULL_FOREST_ROUTE_1, 9, 0, 9

BullForest_MapEvents::
	dw $4000 ; unknown

	db 8 ; warp events
	warp_event 25, 6, 1, BULL_MART, wOverworldMapBlocks + 117
	warp_event 9, 9, 1, BULL_HOUSE_1, wOverworldMapBlocks + 135
	warp_event 27, 11, 1, BULL_HOUSE_2, wOverworldMapBlocks + 170
	warp_event 19, 13, 1, BULL_HOUSE_3, wOverworldMapBlocks + 192
	warp_event 13, 18, 1, BULL_POKECENTER_1F, wOverworldMapBlocks + 267
	warp_event 26, 21, 1, BULL_LEAGUE_1F, wOverworldMapBlocks + 300
	warp_event 27, 21, 2, BULL_LEAGUE_1F, wOverworldMapBlocks + 300
	warp_event 3, 22, 1, BULL_HOUSE_4, wOverworldMapBlocks + 314

	db 3 ; bg events
	bg_event 26, 6, 0, 1
	bg_event 2, 16, 0, 2
	bg_event 14, 18, 0, 3

	db 5 ; person events
	object_event 21, 9, SPRITE_TWIN, SLOW_STEP_DOWN, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11, 12, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 16, SPRITE_GRANNY, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 20, 19, SPRITE_TEACHER, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 20, 29, SPRITE_BUG_CATCHER_BOY, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

BullForest_Blocks:: INCBIN "maps/blk/BullForest.blk"
