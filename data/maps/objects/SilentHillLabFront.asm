INCLUDE "constants.asm"

SECTION "data/maps/objects/SilentHillLabFront.asm", ROMX

	map_attributes SilentHillLabFront, SILENT_HILL_LAB_FRONT, 0

SilentHillLabFront_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3, 15, SILENT_HILL, 4, 82
	warp_event  4, 15, SILENT_HILL, 5, 83
	warp_event  4,  0, SILENT_HILL_LAB_BACK, 2, 13

	def_bg_events
	bg_event  6,  1, 1
	bg_event  2,  0, 2
	bg_event  0,  7, 3
	bg_event  1,  7, 4
	bg_event  2,  7, 5
	bg_event  5,  7, 6
	bg_event  6,  7, 7
	bg_event  7,  7, 8
	bg_event  0, 11, 9
	bg_event  1, 11, 10
	bg_event  2, 11, 11
	bg_event  5, 11, 12
	bg_event  6, 11, 13
	bg_event  7, 11, 14
	bg_event  4,  0, 15

	def_object_events
	object_event  4,  2, SPRITE_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  0, SPRITE_OKIDO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  4, SPRITE_SILVER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  0, SPRITE_SILVER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4, 14, SPRITE_BLUE, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  3, SPRITE_BLUE, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1, 13, SPRITE_NANAMI, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  8, SPRITE_SCIENTIST, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6, 12, SPRITE_SCIENTIST, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  1, SPRITE_POKEDEX, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  1, SPRITE_POKEDEX, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillLabFront_Blocks::
INCBIN "maps/SilentHillLabFront.blk"
