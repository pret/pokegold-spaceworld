INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/BullHouse3.asm", ROMX
	map_attributes BullHouse3, BULL_HOUSE_3, 0

BullHouse3_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 4, BULL_FOREST, wOverworldMapBlocks + 47
	warp_event 5, 7, 4, BULL_FOREST, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 4, 3, SPRITE_GRAMPS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse3_Blocks:: INCBIN "maps/placeholder/blk/BullHouse3.blk"
