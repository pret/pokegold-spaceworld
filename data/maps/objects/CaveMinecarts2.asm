INCLUDE "constants.asm"

SECTION "data/maps/objects/CaveMinecarts2.asm", ROMX

	map_attributes CaveMinecarts2, CAVE_MINECARTS_2, 0

CaveMinecarts2_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts2_Blocks::
INCBIN "maps/CaveMinecarts2.blk"
