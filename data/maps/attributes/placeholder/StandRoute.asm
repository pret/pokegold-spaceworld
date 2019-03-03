INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/StandRoute.asm", ROMX
	map_attributes StandRoute, STAND_ROUTE, NORTH | SOUTH
	connection north, Stand, STAND, -3, 7, 13
	connection south, KantoEastRoute, KANTO_EAST_ROUTE, -3, 7, 13

StandRoute_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 48, 3, STAND_ROUTE_GATE_KANTO, wOverworldMapBlocks + 405
	warp_event 9, 48, 4, STAND_ROUTE_GATE_KANTO, wOverworldMapBlocks + 405

	db 0 ; bg events

	db 0 ; person events

StandRoute_Blocks:: INCBIN "maps/placeholder/blk/StandRoute.blk"