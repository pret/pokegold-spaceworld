INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/CaveMinecarts7.asm", ROMX
	map_attributes CaveMinecarts7, CAVE_MINECARTS_7, 0

CaveMinecarts7_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts7_Blocks:: INCBIN "maps/placeholder/blk/CaveMinecarts7.blk"
