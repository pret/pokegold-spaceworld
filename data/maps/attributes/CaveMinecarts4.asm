INCLUDE "constants.asm"

SECTION "data/maps/attributes/CaveMinecarts4.asm", ROMX
	map_attributes CaveMinecarts4, CAVE_MINECARTS_4, 0

CaveMinecarts4_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts4_Blocks:: INCBIN "maps/blk/CaveMinecarts4.blk"