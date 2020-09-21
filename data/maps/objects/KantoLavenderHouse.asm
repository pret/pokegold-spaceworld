INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoLavenderHouse.asm", ROMX

	map_attributes KantoLavenderHouse, KANTO_LAVENDER_HOUSE, 0

KantoLavenderHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_POKEFAN_M, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_POKEFAN_F, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoLavenderHouse_Blocks::
INCBIN "maps/KantoLavenderHouse.blk"
