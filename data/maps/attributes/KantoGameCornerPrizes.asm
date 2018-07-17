INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoGameCornerPrizes.asm", ROMX
	map_attributes KantoGameCornerPrizes, KANTO_GAME_CORNER_PRIZES, 0

KantoGameCornerPrizes_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 15, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 15, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 3 ; person events
	object_event 2, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGameCornerPrizes_Blocks:: INCBIN "maps/blk/KantoGameCornerPrizes.blk"
