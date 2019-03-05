INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/SugarHouse2.asm", ROMX
	map_attributes SugarHouse2, SUGAR_HOUSE_2, 0

SugarHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 2, SUGAR, wOverworldMapBlocks + 42
	warp_event 4, 7, 2, SUGAR, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_FISHING_GURU, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarHouse2_Blocks:: INCBIN "maps/placeholder/blk/SugarHouse2.blk"