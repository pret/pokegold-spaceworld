INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/WestMart4F.asm", ROMX
	map_attributes WestMart4F, WEST_MART_4F, 0

WestMart4F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, WEST_MART_5F, wOverworldMapBlocks + 21
	warp_event 15, 0, 2, WEST_MART_3F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 14 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2
	bg_event 2, 5, 0, 3
	bg_event 3, 5, 0, 3
	bg_event 4, 5, 0, 3
	bg_event 5, 5, 0, 3
	bg_event 6, 5, 0, 3
	bg_event 7, 5, 0, 3
	bg_event 8, 5, 0, 3
	bg_event 9, 5, 0, 3
	bg_event 6, 1, 0, 3
	bg_event 7, 1, 0, 3
	bg_event 8, 1, 0, 3
	bg_event 9, 1, 0, 3

	db 3 ; person events
	object_event 13, 5, SPRITE_CLERK, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 6, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 2, SPRITE_ROCKER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart4F_Blocks:: INCBIN "maps/placeholder/blk/WestMart4F.blk"