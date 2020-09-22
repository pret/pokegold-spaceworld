INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuWestRoute.asm", ROMX

	map_attributes HaitekuWestRoute, HAITEKU_WEST_ROUTE, WEST | EAST
	connection west, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, -18
	connection east, Haiteku, HAITEKU, 0

HaitekuWestRoute_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

HaitekuWestRoute_Blocks::
INCBIN "maps/HaitekuWestRoute.blk"
