INCLUDE "constants.asm"

SECTION "data/maps/objects/Route18.asm", ROMX

	map_attributes Route18, ROUTE_18, NORTH | WEST
	connection north, BullForestRoute1, BULL_FOREST_ROUTE_1, 0
	connection west, NewtypeRoute, NEWTYPE_ROUTE, 36

Route18_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8,  5, NEWTYPE_ROUTE_GATE, 1, 53
	warp_event  9,  5, NEWTYPE_ROUTE_GATE, 2, 53
	warp_event 13, 28, ROUTE_18_POKECENTER_1F, 1, 247

	def_bg_events

	def_object_events

Route18_Blocks::
INCBIN "maps/Route18.blk"
