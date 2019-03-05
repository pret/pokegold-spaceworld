INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/StandHouse.asm", ROMX
	map_attributes StandHouse, STAND_HOUSE, 0

StandHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, STAND, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, STAND, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_SUPER_NERD, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

StandHouse_Blocks:: INCBIN "maps/placeholder/blk/StandHouse.blk"