INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/WestGym.asm", ROMX
	map_attributes WestGym, WEST_GYM, 0

WestGym_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 17, 7, WEST, wOverworldMapBlocks + 102
	warp_event 5, 17, 8, WEST, wOverworldMapBlocks + 102

	db 2 ; bg events
	bg_event 3, 15, 0, 1
	bg_event 6, 15, 0, 1

	db 6 ; person events
	object_event 4, 4, SPRITE_TSUKUSHI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 7, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 3, 11, SPRITE_COOLTRAINER_F, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 5, 9, SPRITE_LASS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 4, 6, SPRITE_TWIN, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 7, 15, SPRITE_GYM_GUY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestGym_Blocks:: INCBIN "maps/placeholder/blk/WestGym.blk"