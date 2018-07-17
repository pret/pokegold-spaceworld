INCLUDE "constants.asm"

SECTION "data/maps/attributes/CaveMinecarts3.asm", ROMX
	map_attributes CaveMinecarts3, CAVE_MINECARTS_3, 0

CaveMinecarts3_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts3_Blocks:: INCBIN "maps/blk/CaveMinecarts3.blk"
