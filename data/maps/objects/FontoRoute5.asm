INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRoute5.asm", ROMX

	map_attributes FontoRoute5, FONTO_ROUTE_5, SOUTH | EAST
	connection south, South, SOUTH, -10
	connection east, FontoRoute6, FONTO_ROUTE_6, 0

FontoRoute5_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 30, 3, FONTO_ROUTE_GATE_3, wOverworldMapBlocks + 261
	warp_event 9, 30, 4, FONTO_ROUTE_GATE_3, wOverworldMapBlocks + 261

	db 0 ; bg events

	db 0 ; person events

FontoRoute5_Blocks::
INCBIN "maps/FontoRoute5.blk"
