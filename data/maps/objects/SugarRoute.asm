INCLUDE "constants.asm"

SECTION "data/maps/objects/SugarRoute.asm", ROMX

	map_attributes SugarRoute, SUGAR_ROUTE, NORTH | SOUTH
	connection north, Sugar, SUGAR, 0
	connection south, Newtype, NEWTYPE, -5

SugarRoute_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 48, 3, SUGAR_ROUTE_GATE, wOverworldMapBlocks + 405
	warp_event 9, 48, 4, SUGAR_ROUTE_GATE, wOverworldMapBlocks + 405

	db 0 ; bg events

	db 0 ; person events

SugarRoute_Blocks::
INCBIN "maps/SugarRoute.blk"
