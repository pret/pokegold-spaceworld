INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/WestMart2F.asm", ROMX
	map_attributes WestMart2F, WEST_MART_2F, 0

WestMart2F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, WEST_MART_3F, wOverworldMapBlocks + 21
	warp_event 15, 0, 3, WEST_MART_1F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 16 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2
	bg_event 3, 4, 0, 3
	bg_event 3, 5, 0, 3
	bg_event 3, 6, 0, 3
	bg_event 3, 7, 0, 3
	bg_event 7, 4, 0, 3
	bg_event 7, 5, 0, 3
	bg_event 7, 6, 0, 3
	bg_event 7, 7, 0, 3
	bg_event 4, 1, 0, 3
	bg_event 5, 1, 0, 3
	bg_event 6, 1, 0, 3
	bg_event 7, 1, 0, 3
	bg_event 8, 1, 0, 3
	bg_event 9, 1, 0, 3

	db 4 ; person events
	object_event 14, 5, SPRITE_CLERK, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 6, SPRITE_LASS, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_BURGLAR, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_ROCKET_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart2F_Blocks:: INCBIN "maps/placeholder/blk/WestMart2F.blk"