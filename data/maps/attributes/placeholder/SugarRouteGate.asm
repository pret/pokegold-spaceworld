INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/SugarRouteGate.asm", ROMX
	map_attributes SugarRouteGate, SUGAR_ROUTE_GATE, 0

SugarRouteGate_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 12, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 13, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, SUGAR_ROUTE, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, SUGAR_ROUTE, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

SugarRouteGate_Blocks:: INCBIN "maps/placeholder/blk/SugarRouteGate.blk"
