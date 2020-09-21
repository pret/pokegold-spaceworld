INCLUDE "constants.asm"

SECTION "data/maps/objects/BullHouse2.asm", ROMX

	map_attributes BullHouse2, BULL_HOUSE_2, 0

BullHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, BULL_FOREST, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, BULL_FOREST, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 8, 4, SPRITE_GRANNY, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse2_Blocks::
INCBIN "maps/BullHouse2.blk"
