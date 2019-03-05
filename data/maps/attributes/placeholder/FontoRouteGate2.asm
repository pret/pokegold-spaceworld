INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/FontoRouteGate2.asm", ROMX
	map_attributes FontoRouteGate2, FONTO_ROUTE_GATE_2, 0

FontoRouteGate2_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 8, BAADON, wOverworldMapBlocks + 47
	warp_event 5, 7, 9, BAADON, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, FONTO_ROUTE_4, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, FONTO_ROUTE_4, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

FontoRouteGate2_Blocks:: INCBIN "maps/placeholder/blk/FontoRouteGate2.blk"