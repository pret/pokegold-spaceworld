INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuWestRoute.asm", ROMX

	map_attributes HaitekuWestRoute, HAITEKU_WEST_ROUTE, WEST | EAST
	connection west, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, -18
	connection east, Haiteku, HAITEKU, 0

HaitekuWestRoute_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

HaitekuWestRoute_Blocks::
INCBIN "maps/HaitekuWestRoute.blk"
