INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoRedsHouse.asm", ROMX
	map_attributes KantoRedsHouse, KANTO_REDS_HOUSE, 0

KantoRedsHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 21, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 21, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_SUPER_NERD, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_TEACHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoRedsHouse_Blocks:: INCBIN "maps/blk/KantoRedsHouse.blk"
