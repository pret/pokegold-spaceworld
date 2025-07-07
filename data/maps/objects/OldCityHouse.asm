INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityHouse.asm", ROMX

	map_attributes OldCityHouse, OLD_CITY_HOUSE, 0

OldCityHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, OLD_CITY, 9, 42
	warp_event  4,  7, OLD_CITY, 9, 43

	def_bg_events
	bg_event  0,  1, 1
	bg_event  1,  1, 2
	bg_event  2,  1, 3
	bg_event  7,  1, 4

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  6, SPRITE_LASS, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityHouse_Blocks::
INCBIN "maps/OldCityHouse.blk"
