INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoGamefreakHQ3.asm", ROMX
	map_attributes KantoGamefreakHQ3, KANTO_GAMEFREAK_HQ_3, 0

KantoGamefreakHQ3_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 6, 1, 1, KANTO_GAMEFREAK_HQ_2, wOverworldMapBlocks + 14
	warp_event 7, 1, 2, KANTO_GAMEFREAK_HQ_4, wOverworldMapBlocks + 14
	warp_event 2, 1, 3, KANTO_GAMEFREAK_HQ_4, wOverworldMapBlocks + 12
	warp_event 4, 1, 4, KANTO_GAMEFREAK_HQ_2, wOverworldMapBlocks + 13

	db 0 ; bg events

	db 3 ; person events
	object_event 0, 5, SPRITE_GYM_GUY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 7, SPRITE_BURGLAR, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 7, SPRITE_FISHER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ3_Blocks:: INCBIN "maps/blk/KantoGamefreakHQ3.blk"
