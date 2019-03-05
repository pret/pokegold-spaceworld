INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/NewtypeRouteGate.asm", ROMX
	map_attributes NewtypeRouteGate, NEWTYPE_ROUTE_GATE, 0

NewtypeRouteGate_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 1, ROUTE_18, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, ROUTE_18, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, BULL_FOREST_ROUTE_1, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, BULL_FOREST_ROUTE_1, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

NewtypeRouteGate_Blocks:: INCBIN "maps/placeholder/blk/NewtypeRouteGate.blk"