INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/FontoRoute3.asm", ROMX
	map_attributes FontoRoute3, FONTO_ROUTE_3, WEST | EAST
	connection west, Fonto, FONTO, 0, 0, 9
	connection east, FontoRoute4, FONTO_ROUTE_4, 0, 0, 12

FontoRoute3_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

FontoRoute3_Blocks:: INCBIN "maps/placeholder/blk/FontoRoute3.blk"