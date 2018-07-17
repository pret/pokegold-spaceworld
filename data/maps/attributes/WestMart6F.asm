INCLUDE "constants.asm"

SECTION "data/maps/attributes/WestMart6F.asm", ROMX
	map_attributes WestMart6F, WEST_MART_6F, 0

WestMart6F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 15, 0, 2, WEST_MART_5F, wOverworldMapBlocks + 22

	db 5 ; bg events
	bg_event 8, 1, 0, 1
	bg_event 9, 1, 0, 2
	bg_event 10, 1, 0, 3
	bg_event 11, 1, 0, 4
	bg_event 14, 0, 0, 5

	db 3 ; person events
	object_event 12, 3, SPRITE_OFFICER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 4, SPRITE_SIDON, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 6, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart6F_Blocks:: INCBIN "maps/blk/WestMart6F.blk"
