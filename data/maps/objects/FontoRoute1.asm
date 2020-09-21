INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRoute1.asm", ROMX

	map_attributes FontoRoute1, FONTO_ROUTE_1, WEST | EAST
	connection west, South, SOUTH, 0, 0, 12
	connection east, Fonto, FONTO, 0, 0, 9

FontoRoute1_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 6, 9, 3, FONTO_ROUTE_GATE_1, wOverworldMapBlocks + 209

	db 0 ; bg events

	db 0 ; person events

FontoRoute1_Blocks::
INCBIN "maps/FontoRoute1.blk"
