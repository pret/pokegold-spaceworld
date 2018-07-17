INCLUDE "constants.asm"

SECTION "data/maps/attributes/CaveMinecarts5.asm", ROMX
	map_attributes CaveMinecarts5, CAVE_MINECARTS_5, 0

CaveMinecarts5_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts5_Blocks:: INCBIN "maps/blk/CaveMinecarts5.blk"
