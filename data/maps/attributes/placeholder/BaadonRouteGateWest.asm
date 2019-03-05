INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/BaadonRouteGateWest.asm", ROMX
	map_attributes BaadonRouteGateWest, BAADON_ROUTE_GATE_WEST, 0

BaadonRouteGateWest_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 11, WEST, wOverworldMapBlocks + 47
	warp_event 5, 7, 12, WEST, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, BAADON_ROUTE_1, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, BAADON_ROUTE_1, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

BaadonRouteGateWest_Blocks:: INCBIN "maps/placeholder/blk/BaadonRouteGateWest.blk"