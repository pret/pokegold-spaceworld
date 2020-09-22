INCLUDE "constants.asm"

SECTION "data/maps/objects/Sugar.asm", ROMX

	map_attributes Sugar, SUGAR, SOUTH
	connection south, SugarRoute, SUGAR_ROUTE, 0

Sugar_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 5, 5, 1, SUGAR_HOUSE, wOverworldMapBlocks + 51
	warp_event 15, 9, 1, SUGAR_HOUSE_2, wOverworldMapBlocks + 88
	warp_event 5, 10, 1, SUGAR_MART, wOverworldMapBlocks + 99
	warp_event 9, 10, 1, SUGAR_POKECENTER_1F, wOverworldMapBlocks + 101

	db 4 ; bg events
	bg_event 14, 6, 0, 1
	bg_event 6, 10, 0, 2
	bg_event 10, 10, 0, 3
	bg_event 10, 14, 0, 4

	db 3 ; person events
	object_event 8, 12, SPRITE_TWIN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 6, SPRITE_GRANNY, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 11, SPRITE_GRAMPS, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Sugar_Blocks::
INCBIN "maps/Sugar.blk"
