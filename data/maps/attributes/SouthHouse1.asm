INCLUDE "constants.asm"

SECTION "data/maps/attributes/SouthHouse1.asm", ROMX
	map_attributes SouthHouse1, SOUTH_HOUSE_1, 0

SouthHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 1, SOUTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 1, SOUTH, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthHouse1_Blocks:: INCBIN "maps/blk/SouthHouse1.blk"