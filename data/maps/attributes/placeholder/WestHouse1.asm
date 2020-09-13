INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/WestHouse1.asm", ROMX
	map_attributes WestHouse1, WEST_HOUSE_1, 0

WestHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 9, WEST, wOverworldMapBlocks + 47
	warp_event 5, 7, 9, WEST, wOverworldMapBlocks + 47

	db 4 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 5, 1, 0, 3
	bg_event 8, 0, 0, 4

	db 3 ; person events
	object_event 7, 3, SPRITE_GRAMPS, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 6, SPRITE_YOUNGSTER, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 4, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestHouse1_Blocks:: INCBIN "maps/placeholder/blk/WestHouse1.blk"
