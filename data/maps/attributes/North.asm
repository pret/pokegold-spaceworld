INCLUDE "constants.asm"

SECTION "data/maps/attributes/North.asm", ROMX
	map_attributes North, NORTH, SOUTH
	connection south, BullForestRoute3, BULL_FOREST_ROUTE_3, 0, 0, 10

North_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 5, 5, 1, NORTH_HOUSE_1, wOverworldMapBlocks + 51
	warp_event 15, 6, 1, NORTH_MART, wOverworldMapBlocks + 72
	warp_event 5, 9, 1, NORTH_HOUSE_2, wOverworldMapBlocks + 83
	warp_event 13, 10, 1, NORTH_POKECENTER_1F, wOverworldMapBlocks + 103

	db 4 ; bg events
	bg_event 12, 4, 0, 1
	bg_event 16, 6, 0, 2
	bg_event 14, 10, 0, 3
	bg_event 8, 12, 0, 4

	db 3 ; person events
	object_event 9, 6, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 9, SPRITE_TWIN, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

North_Blocks:: INCBIN "maps/blk/North.blk"
