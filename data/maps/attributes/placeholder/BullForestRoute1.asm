INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/BullForestRoute1.asm", ROMX
	map_attributes BullForestRoute1, BULL_FOREST_ROUTE_1, SOUTH | EAST
	connection south, Route18, ROUTE_18, 0, 0, 10
	connection east, BullForest, BULL_FOREST, -3, 6, 12

BullForestRoute1_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 8, 12, 3, NEWTYPE_ROUTE_GATE, wOverworldMapBlocks + 222
	warp_event 9, 12, 4, NEWTYPE_ROUTE_GATE, wOverworldMapBlocks + 222
	warp_event 9, 5, 1, BULL_FOREST_ROUTE_1_HOUSE, wOverworldMapBlocks + 98

	db 0 ; bg events

	db 0 ; person events

BullForestRoute1_Blocks:: INCBIN "maps/placeholder/blk/BullForestRoute1.blk"