INCLUDE "constants.asm"

SECTION "data/maps/objects/Route18Pokecenter2F.asm", ROMX

	map_attributes Route18Pokecenter2F, ROUTE_18_POKECENTER_2F, 0

Route18Pokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, ROUTE_18_POKECENTER_1F, 3, 57

	def_bg_events

	def_object_events

Route18Pokecenter2F_Blocks::
INCBIN "maps/Route18Pokecenter2F.blk"
