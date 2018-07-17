INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoGamefreakHQ1.asm", ROMX
	map_attributes KantoGamefreakHQ1, KANTO_GAMEFREAK_HQ_1, 0

KantoGamefreakHQ1_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 4, 11, 9, KANTO, wOverworldMapBlocks + 63
	warp_event 5, 11, 10, KANTO, wOverworldMapBlocks + 63
	warp_event 7, 1, 2, KANTO_GAMEFREAK_HQ_2, wOverworldMapBlocks + 14
	warp_event 2, 1, 3, KANTO_GAMEFREAK_HQ_2, wOverworldMapBlocks + 12
	warp_event 4, 0, 30, KANTO, wOverworldMapBlocks + 13

	db 0 ; bg events

	db 4 ; person events
	object_event 1, 5, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 5, SPRITE_SIDON, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 8, SPRITE_PIPPI, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 7, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ1_Blocks:: INCBIN "maps/blk/KantoGamefreakHQ1.blk"
