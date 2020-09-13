INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/StandRouteGateKanto.asm", ROMX
	map_attributes StandRouteGateKanto, STAND_ROUTE_GATE_KANTO, 0

StandRouteGateKanto_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 1, KANTO_EAST_ROUTE, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, KANTO_EAST_ROUTE, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, STAND_ROUTE, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, STAND_ROUTE, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

StandRouteGateKanto_Blocks:: INCBIN "maps/placeholder/blk/StandRouteGateKanto.blk"
