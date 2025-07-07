INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityKurtsHouse.asm", ROMX

	map_attributes OldCityKurtsHouse, OLD_CITY_KURTS_HOUSE, 0

OldCityKurtsHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, OLD_CITY, 11, 58
	warp_event  4,  7, OLD_CITY, 11, 59

	def_bg_events
	bg_event  4,  1, 1
	bg_event  5,  1, 2
	bg_event 12,  1, 3
	bg_event 14,  0, 4
	bg_event 15,  0, 4

	def_object_events
	object_event  2,  2, SPRITE_GANTETSU, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityKurtsHouse_Blocks::
INCBIN "maps/OldCityKurtsHouse.blk"
