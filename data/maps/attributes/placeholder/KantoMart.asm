INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoMart.asm", ROMX
	map_attributes KantoMart, KANTO_MART, 0

KantoMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 8, KANTO, wOverworldMapBlocks + 59
	warp_event 5, 7, 8, KANTO, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_TWIN, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_GRAMPS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoMart_Blocks:: INCBIN "maps/placeholder/blk/KantoMart.blk"