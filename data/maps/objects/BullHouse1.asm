INCLUDE "constants.asm"

SECTION "data/maps/objects/BullHouse1.asm", ROMX

	map_attributes BullHouse1, BULL_HOUSE_1, 0

BullHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 2, BULL_FOREST, wOverworldMapBlocks + 42
	warp_event 4, 7, 2, BULL_FOREST, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_KIKUKO, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse1_Blocks::
INCBIN "maps/BullHouse1.blk"
