INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityMart.asm", ROMX

	map_attributes OldCityMart, OLD_CITY_MART, 0

OldCityMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, OLD_CITY, 8, 51
	warp_event  5,  7, OLD_CITY, 8, 51

	def_bg_events
	bg_event  0,  7, 1

	def_object_events
	object_event  1,  3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_YOUNGSTER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityMart_Blocks::
INCBIN "maps/OldCityMart.blk"
