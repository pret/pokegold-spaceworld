INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeRouteGate.asm", ROMX

	map_attributes NewtypeRouteGate, NEWTYPE_ROUTE_GATE, 0

NewtypeRouteGate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_18, 1, 47
	warp_event  5,  7, ROUTE_18, 2, 47
	warp_event  4,  0, BULL_FOREST_ROUTE_1, 1, 14
	warp_event  5,  0, BULL_FOREST_ROUTE_1, 2, 14

	def_bg_events

	def_object_events

NewtypeRouteGate_Blocks::
INCBIN "maps/NewtypeRouteGate.blk"
