INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/FontoRoute4.asm", ROMX
	map_attributes FontoRoute4, FONTO_ROUTE_4, SOUTH | WEST
	connection south, Baadon, BAADON, 0, 0, 10
	connection west, FontoRoute3, FONTO_ROUTE_3, 0, 0, 9

FontoRoute4_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 30, 3, FONTO_ROUTE_GATE_2, wOverworldMapBlocks + 261
	warp_event 9, 30, 4, FONTO_ROUTE_GATE_2, wOverworldMapBlocks + 261

	db 0 ; bg events

	db 0 ; person events

FontoRoute4_Blocks:: INCBIN "maps/placeholder/blk/FontoRoute4.blk"