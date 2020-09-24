INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuWestRouteOcean.asm", ROMX

	map_attributes HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, NORTH | EAST
	connection north, South, SOUTH, -10
	connection east, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 18

HaitekuWestRouteOcean_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 10,  9, HAITEKU_WEST_ROUTE_GATE, 1, 86
	warp_event 11,  9, HAITEKU_WEST_ROUTE_GATE, 2, 86

	def_bg_events

	def_object_events

HaitekuWestRouteOcean_Blocks::
INCBIN "maps/HaitekuWestRouteOcean.blk"
