INCLUDE "constants.asm"

SECTION "data/maps/objects/Route15Pokecenter2F.asm", ROMX

	map_attributes Route15Pokecenter2F, ROUTE_15_POKECENTER_2F, 0

Route15Pokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, ROUTE_15_POKECENTER_1F, 3, 57

	def_bg_events

	def_object_events

Route15Pokecenter2F_Blocks::
INCBIN "maps/Route15Pokecenter2F.blk"
