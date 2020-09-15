INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoCeruleanHouse.asm", ROMX
	map_attributes KantoCeruleanHouse, KANTO_CERULEAN_HOUSE, 0

KantoCeruleanHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 1, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 1, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 3, 3, SPRITE_FISHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeruleanHouse_Blocks:: INCBIN "maps/placeholder/blk/KantoCeruleanHouse.blk"
