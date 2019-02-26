INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/OldCityMart.asm", ROMX
	map_attributes OldCityMart, OLD_CITY_MART, 0

OldCityMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 8, OLD_CITY, wOverworldMapBlocks + 51
	warp_event 5, 7, 8, OLD_CITY, wOverworldMapBlocks + 51

	db 1 ; bg events
	bg_event 0, 7, 0, 1

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_YOUNGSTER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityMart_Blocks:: INCBIN "maps/placeholder/blk/OldCityMart.blk"