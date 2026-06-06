INCLUDE "constants.asm"

SECTION "data/maps/objects/HighTechWestRouteOcean.asm", ROMX

	map_attributes HighTechWestRouteOcean, HIGHTECH_WEST_ROUTE_OCEAN, NORTH | EAST
	connection north, South, SOUTH, -10
	connection east, HighTechWestRoute, HIGHTECH_WEST_ROUTE, 18

HighTechWestRouteOcean_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 10,  9, HIGHTECH_WEST_ROUTE_GATE, 1, 86
	warp_event 11,  9, HIGHTECH_WEST_ROUTE_GATE, 2, 86

	def_bg_events

	def_object_events

HighTechWestRouteOcean_Blocks::
INCBIN "maps/HighTechWestRouteOcean.blk"
