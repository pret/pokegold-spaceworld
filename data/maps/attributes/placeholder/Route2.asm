INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Route2.asm", ROMX
	map_attributes Route2, ROUTE_2, WEST | EAST
	connection west, West, WEST, -3, 2, 15
	connection east, OldCity, OLD_CITY, -3, 2, 15

Route2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 6, 5, 3, ROUTE_2_GATE_1F, wOverworldMapBlocks + 67
	warp_event 15, 4, 1, ROUTE_2_HOUSE, wOverworldMapBlocks + 71

	db 3 ; bg events
	bg_event 15, 4, 0, 3
	bg_event 14, 5, 0, 1
	bg_event 24, 10, 0, 2

	db 3 ; person events
	object_event 19, 11, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 15, 7, SPRITE_YOUNGSTER, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 8, SPRITE_YOUNGSTER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0

Route2_Blocks:: INCBIN "maps/placeholder/blk/Route2.blk"
