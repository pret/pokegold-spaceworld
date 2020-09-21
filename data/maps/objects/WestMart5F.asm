INCLUDE "constants.asm"

SECTION "data/maps/objects/WestMart5F.asm", ROMX

	map_attributes WestMart5F, WEST_MART_5F, 0

WestMart5F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, WEST_MART_4F, wOverworldMapBlocks + 21
	warp_event 15, 0, 1, WEST_MART_6F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 2 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2

	db 3 ; person events
	object_event 8, 5, SPRITE_GYM_GUY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 5, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 4, SPRITE_NYOROBON, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart5F_Blocks::
INCBIN "maps/WestMart5F.blk"
