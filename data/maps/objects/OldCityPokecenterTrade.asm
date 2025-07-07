INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityPokecenterTrade.asm", ROMX

	map_attributes OldCityPokecenterTrade, OLD_CITY_POKECENTER_TRADE, 0

OldCityPokecenterTrade_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, OLD_CITY_POKECENTER_2F, 2, 47
	warp_event  5,  7, OLD_CITY_POKECENTER_2F, 2, 47

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_GOLD, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenterTrade_Blocks::
INCBIN "maps/OldCityPokecenterTrade.blk"
