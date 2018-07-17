INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityHouse.asm", ROMX
	map_attributes OldCityHouse, OLD_CITY_HOUSE, 0

OldCityHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 9, OLD_CITY, wOverworldMapBlocks + 42
	warp_event 4, 7, 9, OLD_CITY, wOverworldMapBlocks + 43

	db 4 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 2, 1, 0, 3
	bg_event 7, 1, 0, 4

	db 3 ; person events
	object_event 2, 3, SPRITE_POKEFAN_M, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 6, SPRITE_LASS, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityHouse_Blocks:: INCBIN "maps/blk/OldCityHouse.blk"