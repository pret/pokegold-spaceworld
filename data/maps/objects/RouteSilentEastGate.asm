INCLUDE "constants.asm"

SECTION "data/maps/objects/RouteSilentEastGate.asm", ROMX

	map_attributes RouteSilentEastGate, ROUTE_SILENT_EAST_GATE, 0

RouteSilentEastGate_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 0, 7, 1, ROUTE_SILENT_EAST, wOverworldMapBlocks + 45
	warp_event 1, 7, 1, ROUTE_SILENT_EAST, wOverworldMapBlocks + 45
	warp_event 8, 7, 29, KANTO, wOverworldMapBlocks + 49
	warp_event 9, 7, 29, KANTO, wOverworldMapBlocks + 49

	db 0 ; bg events

	db 0 ; person events

RouteSilentEastGate_Blocks::
INCBIN "maps/RouteSilentEastGate.blk"
