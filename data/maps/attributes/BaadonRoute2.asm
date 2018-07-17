INCLUDE "constants.asm"

SECTION "data/maps/attributes/BaadonRoute2.asm", ROMX
	map_attributes BaadonRoute2, BAADON_ROUTE_2, WEST | EAST
	connection west, Baadon, BAADON, 0, 0, 9
	connection east, BaadonRoute3, BAADON_ROUTE_3, 0, 0, 12

BaadonRoute2_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

BaadonRoute2_Blocks:: INCBIN "maps/blk/BaadonRoute2.blk"
