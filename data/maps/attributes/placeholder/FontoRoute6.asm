INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/FontoRoute6.asm", ROMX
	map_attributes FontoRoute6, FONTO_ROUTE_6, WEST | EAST
	connection west, FontoRoute5, FONTO_ROUTE_5, 0, 0, 12
	connection east, FontoRoute2, FONTO_ROUTE_2, 0, 0, 12

FontoRoute6_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

FontoRoute6_Blocks:: INCBIN "maps/placeholder/blk/FontoRoute6.blk"