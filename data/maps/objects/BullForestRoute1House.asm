INCLUDE "constants.asm"

SECTION "data/maps/objects/BullForestRoute1House.asm", ROMX

	map_attributes BullForestRoute1House, BULL_FOREST_ROUTE_1_HOUSE, 0

BullForestRoute1House_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, BULL_FOREST_ROUTE_1, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, BULL_FOREST_ROUTE_1, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 1, 5, SPRITE_COOLTRAINER_F, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullForestRoute1House_Blocks::
INCBIN "maps/BullForestRoute1House.blk"
