INCLUDE "constants.asm"

SECTION "data/maps/attributes/BaadonRoute1.asm", ROMX
	map_attributes BaadonRoute1, BAADON_ROUTE_1, NORTH | SOUTH
	connection north, Baadon, BAADON, 0, 0, 10
	connection south, West, WEST, -3, 2, 16

BaadonRoute1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 12, 48, 3, BAADON_ROUTE_GATE_WEST, wOverworldMapBlocks + 407
	warp_event 13, 48, 4, BAADON_ROUTE_GATE_WEST, wOverworldMapBlocks + 407

	db 0 ; bg events

	db 0 ; person events

BaadonRoute1_Blocks:: INCBIN "maps/blk/BaadonRoute1.blk"