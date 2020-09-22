INCLUDE "constants.asm"

SECTION "data/maps/objects/WestGym.asm", ROMX

	map_attributes WestGym, WEST_GYM, 0

WestGym_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4, 17, WEST, 7, 102
	warp_event  5, 17, WEST, 8, 102

	def_bg_events
	bg_event  3, 15, 0, 1
	bg_event  6, 15, 0, 1

	def_object_events
	object_event  4,  4, SPRITE_TSUKUSHI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  7, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event  3, 11, SPRITE_COOLTRAINER_F, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event  5,  9, SPRITE_LASS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  4,  6, SPRITE_TWIN, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  7, 15, SPRITE_GYM_GUY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestGym_Blocks::
INCBIN "maps/WestGym.blk"
