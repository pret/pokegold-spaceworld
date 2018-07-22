INCLUDE "constants.asm"

SECTION "data/maps/attributes/CaveMinecarts1.asm", ROMX
	map_attributes CaveMinecarts1, CAVE_MINECARTS_1, 0

CaveMinecarts1_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts1_Blocks:: INCBIN "maps/blk/CaveMinecarts1.blk"