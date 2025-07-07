INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityMuseum.asm", ROMX

	map_attributes OldCityMuseum, OLD_CITY_MUSEUM, 0

OldCityMuseum_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, OLD_CITY, 1, 58
	warp_event  3,  7, OLD_CITY, 2, 58

	def_bg_events
	bg_event  2,  3, 1
	bg_event  5,  4, 2
	bg_event  9,  4, 3
	bg_event 13,  4, 4

	def_object_events
	object_event  1,  5, SPRITE_FISHER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  4, SPRITE_EGG, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityMuseum_Blocks::
INCBIN "maps/OldCityMuseum.blk"
