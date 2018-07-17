INCLUDE "constants.asm"

SECTION "data/maps/attributes/BaadonHouse1.asm", ROMX
	map_attributes BaadonHouse1, BAADON_HOUSE_1, 0

BaadonHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 3, BAADON, wOverworldMapBlocks + 42
	warp_event 4, 7, 3, BAADON, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_ELDER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonHouse1_Blocks:: INCBIN "maps/blk/BaadonHouse1.blk"
