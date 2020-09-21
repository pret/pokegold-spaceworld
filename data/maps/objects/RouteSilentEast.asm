INCLUDE "constants.asm"

SECTION "data/maps/objects/RouteSilentEast.asm", ROMX

	map_attributes RouteSilentEast, ROUTE_SILENT_EAST, WEST | EAST
	connection west, SilentHill, SILENT_HILL, 0, 0, 9
	connection east, Kanto, KANTO, -3, 6, 15

RouteSilentEast_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 55, 9, 1, ROUTE_SILENT_EAST_GATE, wOverworldMapBlocks + 208

	db 0 ; bg events

	db 0 ; person events

RouteSilentEast_Blocks::
INCBIN "maps/RouteSilentEast.blk"
