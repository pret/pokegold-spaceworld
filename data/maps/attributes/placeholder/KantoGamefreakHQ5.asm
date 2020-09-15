INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoGamefreakHQ5.asm", ROMX
	map_attributes KantoGamefreakHQ5, KANTO_GAMEFREAK_HQ_5, 0

KantoGamefreakHQ5_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 1, KANTO_GAMEFREAK_HQ_4, wOverworldMapBlocks + 42
	warp_event 4, 7, 1, KANTO_GAMEFREAK_HQ_4, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 0 ; person events

KantoGamefreakHQ5_Blocks:: INCBIN "maps/placeholder/blk/KantoGamefreakHQ5.blk"
