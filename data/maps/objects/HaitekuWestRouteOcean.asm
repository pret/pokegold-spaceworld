INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuWestRouteOcean.asm", ROMX

	map_attributes HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, NORTH | EAST
	connection north, South, SOUTH, -10
	connection east, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 18

HaitekuWestRouteOcean_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 10, 9, 1, HAITEKU_WEST_ROUTE_GATE, wOverworldMapBlocks + 86
	warp_event 11, 9, 2, HAITEKU_WEST_ROUTE_GATE, wOverworldMapBlocks + 86

	db 0 ; bg events

	db 0 ; person events

HaitekuWestRouteOcean_Blocks::
INCBIN "maps/HaitekuWestRouteOcean.blk"
