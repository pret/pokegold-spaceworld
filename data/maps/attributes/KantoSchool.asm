INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoSchool.asm", ROMX
	map_attributes KantoSchool, KANTO_SCHOOL, 0

KantoSchool_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 15, 17, KANTO, wOverworldMapBlocks + 82
	warp_event 4, 15, 18, KANTO, wOverworldMapBlocks + 83

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

KantoSchool_Blocks:: INCBIN "maps/blk/KantoSchool.blk"