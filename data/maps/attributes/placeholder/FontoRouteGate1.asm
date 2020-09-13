INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/FontoRouteGate1.asm", ROMX
	map_attributes FontoRouteGate1, FONTO_ROUTE_GATE_1, 0

FontoRouteGate1_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 0, 7, 7, SOUTH, wOverworldMapBlocks + 45
	warp_event 1, 7, 7, SOUTH, wOverworldMapBlocks + 45
	warp_event 8, 7, 1, FONTO_ROUTE_1, wOverworldMapBlocks + 49
	warp_event 9, 7, 1, FONTO_ROUTE_1, wOverworldMapBlocks + 49

	db 0 ; bg events

	db 0 ; person events

FontoRouteGate1_Blocks:: INCBIN "maps/placeholder/blk/FontoRouteGate1.blk"
