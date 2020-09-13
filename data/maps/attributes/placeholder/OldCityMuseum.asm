INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/OldCityMuseum.asm", ROMX
	map_attributes OldCityMuseum, OLD_CITY_MUSEUM, 0

OldCityMuseum_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 2, 7, 1, OLD_CITY, wOverworldMapBlocks + 58
	warp_event 3, 7, 2, OLD_CITY, wOverworldMapBlocks + 58

	db 4 ; bg events
	bg_event 2, 3, 0, 1
	bg_event 5, 4, 0, 2
	bg_event 9, 4, 0, 3
	bg_event 13, 4, 0, 4

	db 2 ; person events
	object_event 1, 5, SPRITE_FISHER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 4, SPRITE_EGG, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityMuseum_Blocks:: INCBIN "maps/placeholder/blk/OldCityMuseum.blk"
