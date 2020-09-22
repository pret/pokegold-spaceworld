INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRoute2.asm", ROMX

	map_attributes FontoRoute2, FONTO_ROUTE_2, SOUTH | WEST
	connection south, Fonto, FONTO, 0
	connection west, FontoRoute6, FONTO_ROUTE_6, 0

FontoRoute2_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

FontoRoute2_Blocks::
INCBIN "maps/FontoRoute2.blk"
