INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/SouthHouse2.asm", ROMX
	map_attributes SouthHouse2, SOUTH_HOUSE_2, 0

SouthHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 4, SOUTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 4, SOUTH, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 1, 2, SPRITE_FISHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthHouse2_Blocks:: INCBIN "maps/placeholder/blk/SouthHouse2.blk"