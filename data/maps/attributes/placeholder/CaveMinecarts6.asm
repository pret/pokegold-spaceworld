INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/CaveMinecarts6.asm", ROMX
	map_attributes CaveMinecarts6, CAVE_MINECARTS_6, 0

CaveMinecarts6_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts6_Blocks:: INCBIN "maps/placeholder/blk/CaveMinecarts6.blk"