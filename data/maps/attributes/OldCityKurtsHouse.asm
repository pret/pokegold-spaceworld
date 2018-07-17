INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityKurtsHouse.asm", ROMX
	map_attributes OldCityKurtsHouse, OLD_CITY_KURTS_HOUSE, 0

OldCityKurtsHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 11, OLD_CITY, wOverworldMapBlocks + 58
	warp_event 4, 7, 11, OLD_CITY, wOverworldMapBlocks + 59

	db 5 ; bg events
	bg_event 4, 1, 0, 1
	bg_event 5, 1, 0, 2
	bg_event 12, 1, 0, 3
	bg_event 14, 0, 0, 4
	bg_event 15, 0, 0, 4

	db 1 ; person events
	object_event 2, 2, SPRITE_GANTETSU, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityKurtsHouse_Blocks:: INCBIN "maps/blk/OldCityKurtsHouse.blk"
