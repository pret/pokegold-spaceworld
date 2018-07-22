INCLUDE "constants.asm"

SECTION "data/maps/attributes/BaadonRouteGateNewtype.asm", ROMX
	map_attributes BaadonRouteGateNewtype, BAADON_ROUTE_GATE_NEWTYPE, 0

BaadonRouteGateNewtype_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 1, ROUTE_15, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, ROUTE_15, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, BAADON_ROUTE_3, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, BAADON_ROUTE_3, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

BaadonRouteGateNewtype_Blocks:: INCBIN "maps/blk/BaadonRouteGateNewtype.blk"