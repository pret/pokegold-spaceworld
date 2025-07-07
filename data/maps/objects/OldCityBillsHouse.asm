INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityBillsHouse.asm", ROMX

	map_attributes OldCityBillsHouse, OLD_CITY_BILLS_HOUSE, 0

OldCityBillsHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, OLD_CITY, 7, 42
	warp_event  4,  7, OLD_CITY, 7, 43

	def_bg_events
	bg_event  2,  1, 1
	bg_event  3,  1, 2
	bg_event  4,  1, 3
	bg_event  6,  1, 4
	bg_event  7,  1, 5
	bg_event  1,  1, 6

	def_object_events
	object_event  5,  4, SPRITE_MASAKI, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityBillsHouse_Blocks::
INCBIN "maps/OldCityBillsHouse.blk"
