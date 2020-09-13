INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Prince.asm", ROMX
	map_attributes Prince, PRINCE, NORTH | SOUTH
	connection north, MtFujiRoute, MT_FUJI_ROUTE, 0, 0, 10
	connection south, PrinceRoute, PRINCE_ROUTE, 0, 0, 10

Prince_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

Prince_Blocks:: INCBIN "maps/placeholder/blk/Prince.blk"
