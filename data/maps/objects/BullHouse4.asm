INCLUDE "constants.asm"

SECTION "data/maps/objects/BullHouse4.asm", ROMX

	map_attributes BullHouse4, BULL_HOUSE_4, 0

BullHouse4_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 8, BULL_FOREST, wOverworldMapBlocks + 47
	warp_event 5, 7, 8, BULL_FOREST, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 0 ; person events

BullHouse4_Blocks::
INCBIN "maps/BullHouse4.blk"
