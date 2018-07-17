INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoGamefreakHQ2.asm", ROMX
	map_attributes KantoGamefreakHQ2, KANTO_GAMEFREAK_HQ_2, 0

KantoGamefreakHQ2_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 6, 1, 1, KANTO_GAMEFREAK_HQ_3, wOverworldMapBlocks + 14
	warp_event 7, 1, 3, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 14
	warp_event 2, 1, 4, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 12
	warp_event 4, 1, 4, KANTO_GAMEFREAK_HQ_3, wOverworldMapBlocks + 13

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 4, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ2_Blocks:: INCBIN "maps/blk/KantoGamefreakHQ2.blk"
