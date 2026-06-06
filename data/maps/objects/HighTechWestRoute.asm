INCLUDE "constants.asm"

SECTION "data/maps/objects/HighTechWestRoute.asm", ROMX

	map_attributes HighTechWestRoute, HIGHTECH_WEST_ROUTE, WEST | EAST
	connection west, HighTechWestRouteOcean, HIGHTECH_WEST_ROUTE_OCEAN, -18
	connection east, HighTech, HIGHTECH, 0

HighTechWestRoute_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

HighTechWestRoute_Blocks::
INCBIN "maps/HighTechWestRoute.blk"
