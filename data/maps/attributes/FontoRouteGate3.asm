INCLUDE "constants.asm"

SECTION "data/maps/attributes/FontoRouteGate3.asm", ROMX
	map_attributes FontoRouteGate3, FONTO_ROUTE_GATE_3, 0

FontoRouteGate3_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 5, SOUTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 6, SOUTH, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, FONTO_ROUTE_5, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, FONTO_ROUTE_5, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

FontoRouteGate3_Blocks:: INCBIN "maps/blk/FontoRouteGate3.blk"
