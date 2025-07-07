INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityGym.asm", ROMX

	map_attributes OldCityGym, OLD_CITY_GYM, 0

OldCityGym_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4, 17, OLD_CITY, 3, 102
	warp_event  5, 17, OLD_CITY, 4, 102

	def_bg_events
	bg_event  3, 15, 1
	bg_event  6, 15, 1

	def_object_events
	object_event  4,  5, SPRITE_HAYATO, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8,  9, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event  8,  1, SPRITE_LASS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event  1,  1, SPRITE_SUPER_NERD, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event  1,  9, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event  7, 15, SPRITE_GYM_GUY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0

OldCityGym_Blocks::
INCBIN "maps/OldCityGym.blk"
