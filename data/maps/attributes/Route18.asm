INCLUDE "constants.asm"

SECTION "data/maps/attributes/Route18.asm", ROMX
	map_attributes Route18, ROUTE_18, NORTH | WEST
	connection north, BullForestRoute1, BULL_FOREST_ROUTE_1, 0, 0, 13
	connection west, NewtypeRoute, NEWTYPE_ROUTE, 36, 0, 9

Route18_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 8, 5, 1, NEWTYPE_ROUTE_GATE, wOverworldMapBlocks + 53
	warp_event 9, 5, 2, NEWTYPE_ROUTE_GATE, wOverworldMapBlocks + 53
	warp_event 13, 28, 1, ROUTE_18_POKECENTER_1F, wOverworldMapBlocks + 247

	db 0 ; bg events

	db 0 ; person events

Route18_Blocks:: INCBIN "maps/blk/Route18.blk"