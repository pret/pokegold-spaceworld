INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoGameCorner.asm", ROMX
	map_attributes KantoGameCorner, KANTO_GAME_CORNER, 0

KantoGameCorner_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 8, 13, 14, KANTO, wOverworldMapBlocks + 117
	warp_event 9, 13, 14, KANTO, wOverworldMapBlocks + 117
	warp_event 10, 13, 14, KANTO, wOverworldMapBlocks + 118
	warp_event 11, 13, 14, KANTO, wOverworldMapBlocks + 118

	db 0 ; bg events

	db 10 ; person events
	object_event 3, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 6, SPRITE_POKEFAN_M, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 7, SPRITE_TWIN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 8, SPRITE_ROCKER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11, 6, SPRITE_GIRL, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11, 8, SPRITE_GRAMPS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_FISHER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 17, 9, SPRITE_POKEFAN_M, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 2, SPRITE_ROCKER, SLOW_STEP_DOWN, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGameCorner_Blocks:: INCBIN "maps/blk/KantoGameCorner.blk"