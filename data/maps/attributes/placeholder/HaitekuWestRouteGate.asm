INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/HaitekuWestRouteGate.asm", ROMX
	map_attributes HaitekuWestRouteGate, HAITEKU_WEST_ROUTE_GATE, 0

HaitekuWestRouteGate_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 1, HAITEKU_WEST_ROUTE_OCEAN, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, HAITEKU_WEST_ROUTE_OCEAN, wOverworldMapBlocks + 47
	warp_event 4, 0, 8, SOUTH, wOverworldMapBlocks + 14
	warp_event 5, 0, 9, SOUTH, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

HaitekuWestRouteGate_Blocks:: INCBIN "maps/placeholder/blk/HaitekuWestRouteGate.blk"