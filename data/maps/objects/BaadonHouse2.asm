INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonHouse2.asm", ROMX

	map_attributes BaadonHouse2, BAADON_HOUSE_2, 0

BaadonHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, BAADON, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, BAADON, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 5, SPRITE_GRANNY, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonHouse2_Blocks::
INCBIN "maps/BaadonHouse2.blk"
