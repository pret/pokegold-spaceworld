INCLUDE "constants.asm"

SECTION "data/maps/attributes/HaitekuWestRoute.asm", ROMX
	map_attributes HaitekuWestRoute, HAITEKU_WEST_ROUTE, WEST | EAST
	connection west, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, -3, 15, 12
	connection east, Haiteku, HAITEKU, 0, 0, 12

HaitekuWestRoute_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

HaitekuWestRoute_Blocks:: INCBIN "maps/blk/HaitekuWestRoute.blk"