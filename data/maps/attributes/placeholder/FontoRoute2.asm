INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/FontoRoute2.asm", ROMX
	map_attributes FontoRoute2, FONTO_ROUTE_2, SOUTH | WEST
	connection south, Fonto, FONTO, 0, 0, 10
	connection west, FontoRoute6, FONTO_ROUTE_6, 0, 0, 9

FontoRoute2_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

FontoRoute2_Blocks:: INCBIN "maps/placeholder/blk/FontoRoute2.blk"
