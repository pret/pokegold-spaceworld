INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/BaadonRoute3.asm", ROMX
	map_attributes BaadonRoute3, BAADON_ROUTE_3, SOUTH | WEST
	connection south, Route15, ROUTE_15, 0, 0, 13
	connection west, BaadonRoute2, BAADON_ROUTE_2, 0, 0, 9

BaadonRoute3_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 30, 3, BAADON_ROUTE_GATE_NEWTYPE, wOverworldMapBlocks + 261
	warp_event 9, 30, 4, BAADON_ROUTE_GATE_NEWTYPE, wOverworldMapBlocks + 261

	db 0 ; bg events

	db 0 ; person events

BaadonRoute3_Blocks:: INCBIN "maps/placeholder/blk/BaadonRoute3.blk"
