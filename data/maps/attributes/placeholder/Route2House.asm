INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Route2House.asm", ROMX
	map_attributes Route2House, ROUTE_2_HOUSE, 0

Route2House_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 2, ROUTE_2, wOverworldMapBlocks + 43
	warp_event 5, 7, 2, ROUTE_2, wOverworldMapBlocks + 43

	db 6 ; bg events
	bg_event 0, 0, 0, 1
	bg_event 2, 0, 0, 1
	bg_event 4, 0, 0, 1
	bg_event 6, 0, 0, 1
	bg_event 0, 3, 0, 2
	bg_event 4, 3, 0, 3

	db 1 ; person events
	object_event 6, 6, SPRITE_SCIENTIST, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2House_Blocks:: INCBIN "maps/placeholder/blk/Route2House.blk"
