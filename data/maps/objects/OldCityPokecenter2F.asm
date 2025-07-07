INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityPokecenter2F.asm", ROMX

	map_attributes OldCityPokecenter2F, OLD_CITY_POKECENTER_2F, 0

OldCityPokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, OLD_CITY_POKECENTER_1F, 3, 57
	warp_event  5,  0, OLD_CITY_POKECENTER_TRADE, 1, 17
	warp_event  9,  0, OLD_CITY_POKECENTER_BATTLE, 1, 19
	warp_event 13,  2, OLD_CITY_POKECENTER_TIME_MACHINE, 1, 35

	def_bg_events
	bg_event  1,  1, 1

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  3, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenter2F_Blocks::
INCBIN "maps/OldCityPokecenter2F.blk"
