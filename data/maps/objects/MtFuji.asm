INCLUDE "constants.asm"

SECTION "data/maps/objects/MtFuji.asm", ROMX

	map_attributes MtFuji, MT_FUJI, SOUTH
	connection south, MtFujiRoute, MT_FUJI_ROUTE, 0

MtFuji_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

MtFuji_Blocks::
INCBIN "maps/MtFuji.blk"
