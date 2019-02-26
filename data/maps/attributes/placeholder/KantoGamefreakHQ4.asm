INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoGamefreakHQ4.asm", ROMX
	map_attributes KantoGamefreakHQ4, KANTO_GAMEFREAK_HQ_4, 0

KantoGamefreakHQ4_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 2, 7, 1, KANTO_GAMEFREAK_HQ_5, wOverworldMapBlocks + 42
	warp_event 6, 1, 2, KANTO_GAMEFREAK_HQ_3, wOverworldMapBlocks + 14
	warp_event 2, 1, 3, KANTO_GAMEFREAK_HQ_3, wOverworldMapBlocks + 12

	db 0 ; bg events

	db 0 ; person events

KantoGamefreakHQ4_Blocks:: INCBIN "maps/placeholder/blk/KantoGamefreakHQ4.blk"