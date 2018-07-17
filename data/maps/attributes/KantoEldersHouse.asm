INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoEldersHouse.asm", ROMX
	map_attributes KantoEldersHouse, KANTO_ELDERS_HOUSE, 0

KantoEldersHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 23, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 23, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_GRAMPS, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_GRANNY, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoEldersHouse_Blocks:: INCBIN "maps/blk/KantoEldersHouse.blk"
