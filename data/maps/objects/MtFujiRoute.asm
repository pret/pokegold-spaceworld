INCLUDE "constants.asm"

SECTION "data/maps/objects/MtFujiRoute.asm", ROMX

	map_attributes MtFujiRoute, MT_FUJI_ROUTE, NORTH | SOUTH
	connection north, MtFuji, MT_FUJI, 0
	connection south, Prince, PRINCE, 0

MtFujiRoute_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

MtFujiRoute_Blocks::
INCBIN "maps/MtFujiRoute.blk"
