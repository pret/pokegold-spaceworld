INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoEastRoute.asm", ROMX

	map_attributes KantoEastRoute, KANTO_EAST_ROUTE, NORTH | WEST
	connection north, StandRoute, STAND_ROUTE, 10, 0, 10
	connection west, Kanto, KANTO, -3, 6, 15

KantoEastRoute_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 28, 5, 1, STAND_ROUTE_GATE_KANTO, wOverworldMapBlocks + 93
	warp_event 29, 5, 2, STAND_ROUTE_GATE_KANTO, wOverworldMapBlocks + 93

	db 0 ; bg events

	db 0 ; person events

KantoEastRoute_Blocks::
INCBIN "maps/KantoEastRoute.blk"
