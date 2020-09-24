INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCitySchool.asm", ROMX

	map_attributes OldCitySchool, OLD_CITY_SCHOOL, 0

OldCitySchool_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3, 15, OLD_CITY, 14, 82
	warp_event  4, 15, OLD_CITY, 14, 83

	def_bg_events
	bg_event  0,  1, 1
	bg_event  1,  1, 1
	bg_event  3,  0, 2
	bg_event  4,  0, 2

	def_object_events
	object_event  2,  5, SPRITE_GIRL, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  7, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  9, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  1, SPRITE_ROCKER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  6, SPRITE_TEACHER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2, 11, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCitySchool_Blocks::
INCBIN "maps/OldCitySchool.blk"
