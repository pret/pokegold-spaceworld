INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/NorthHouse1.asm", ROMX
	map_attributes NorthHouse1, NORTH_HOUSE_1, 0

NorthHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 1, NORTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 1, NORTH, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_TWIN, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthHouse1_Blocks:: INCBIN "maps/placeholder/blk/NorthHouse1.blk"