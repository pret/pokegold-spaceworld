INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuWestRouteGate.asm", ROMX

	map_attributes HaitekuWestRouteGate, HAITEKU_WEST_ROUTE_GATE, 0

HaitekuWestRouteGate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, HAITEKU_WEST_ROUTE_OCEAN, 1, 47
	warp_event  5,  7, HAITEKU_WEST_ROUTE_OCEAN, 2, 47
	warp_event  4,  0, SOUTH, 8, 14
	warp_event  5,  0, SOUTH, 9, 14

	def_bg_events

	def_object_events

HaitekuWestRouteGate_Blocks::
INCBIN "maps/HaitekuWestRouteGate.blk"
