INCLUDE "constants.asm"

SECTION "data/maps/attributes/NorthHouse2.asm", ROMX
	map_attributes NorthHouse2, NORTH_HOUSE_2, 0

NorthHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, NORTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, NORTH, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_TWIN, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthHouse2_Blocks:: INCBIN "maps/blk/NorthHouse2.blk"