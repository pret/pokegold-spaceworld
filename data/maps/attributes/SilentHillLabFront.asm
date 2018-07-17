INCLUDE "constants.asm"

SECTION "data/maps/attributes/SilentHillLabFront.asm", ROMX
	map_attributes SilentHillLabFront, SILENT_HILL_LAB_FRONT, 0

SilentHillLabFront_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 4, SILENT_HILL, wOverworldMapBlocks + 82
	warp_event 4, 15, 5, SILENT_HILL, wOverworldMapBlocks + 83
	warp_event 4, 0, 2, SILENT_HILL_LAB_BACK, wOverworldMapBlocks + 13

	db 15 ; bg events
	bg_event 6, 1, 0, 1
	bg_event 2, 0, 0, 2
	bg_event 0, 7, 0, 3
	bg_event 1, 7, 0, 4
	bg_event 2, 7, 0, 5
	bg_event 5, 7, 0, 6
	bg_event 6, 7, 0, 7
	bg_event 7, 7, 0, 8
	bg_event 0, 11, 0, 9
	bg_event 1, 11, 0, 10
	bg_event 2, 11, 0, 11
	bg_event 5, 11, 0, 12
	bg_event 6, 11, 0, 13
	bg_event 7, 11, 0, 14
	bg_event 4, 0, 0, 15

	db 11 ; person events
	object_event 4, 2, SPRITE_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 0, SPRITE_OKIDO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 4, SPRITE_SILVER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 0, SPRITE_SILVER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 14, SPRITE_BLUE, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 3, SPRITE_BLUE, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 13, SPRITE_NANAMI, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 8, SPRITE_SCIENTIST, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 12, SPRITE_SCIENTIST, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 1, SPRITE_POKEDEX, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 1, SPRITE_POKEDEX, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillLabFront_Blocks:: INCBIN "maps/blk/SilentHillLabFront.blk"