INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityBillsHouse.asm", ROMX
	map_attributes OldCityBillsHouse, OLD_CITY_BILLS_HOUSE, 0

OldCityBillsHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 7, OLD_CITY, wOverworldMapBlocks + 42
	warp_event 4, 7, 7, OLD_CITY, wOverworldMapBlocks + 43

	db 6 ; bg events
	bg_event 2, 1, 0, 1
	bg_event 3, 1, 0, 2
	bg_event 4, 1, 0, 3
	bg_event 6, 1, 0, 4
	bg_event 7, 1, 0, 5
	bg_event 1, 1, 0, 6

	db 1 ; person events
	object_event 5, 4, SPRITE_MASAKI, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityBillsHouse_Blocks:: INCBIN "maps/blk/OldCityBillsHouse.blk"
