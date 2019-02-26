INCLUDE "constants.asm"

SECTION "data/maps/attributes/WestMart1F.asm", ROMX
	map_attributes WestMart1F, WEST_MART_1F, 0

WestMart1F_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 13, 7, 1, WEST, wOverworldMapBlocks + 63
	warp_event 14, 7, 2, WEST, wOverworldMapBlocks + 64
	warp_event 15, 0, 2, WEST_MART_2F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 2 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2

	db 1 ; person events
	object_event 7, 1, SPRITE_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart1F_Blocks:: INCBIN "maps/blk/WestMart1F.blk"