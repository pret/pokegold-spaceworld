INCLUDE "constants.asm"

SECTION "data/maps/attributes/NorthMart.asm", ROMX
	map_attributes NorthMart, NORTH_MART, 0

NorthMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 2, NORTH, wOverworldMapBlocks + 51
	warp_event 5, 7, 2, NORTH, wOverworldMapBlocks + 51

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_GIRL, FACE_RIGHT, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthMart_Blocks:: INCBIN "maps/blk/NorthMart.blk"
