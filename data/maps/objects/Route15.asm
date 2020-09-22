INCLUDE "constants.asm"

SECTION "data/maps/objects/Route15.asm", ROMX

	map_attributes Route15, ROUTE_15, NORTH | EAST
	connection north, BaadonRoute3, BAADON_ROUTE_3, 0
	connection east, Newtype, NEWTYPE, 0

Route15_MapEvents::
	dw $4000 ; unknown

	db 7 ; warp events
	warp_event 8, 5, 1, BAADON_ROUTE_GATE_NEWTYPE, wOverworldMapBlocks + 68
	warp_event 9, 5, 2, BAADON_ROUTE_GATE_NEWTYPE, wOverworldMapBlocks + 68
	warp_event 9, 10, 1, ROUTE_15_POKECENTER_1F, wOverworldMapBlocks + 131
	warp_event 14, 12, 6, ROUTE_15, wOverworldMapBlocks + 155
	warp_event 14, 13, 7, ROUTE_15, wOverworldMapBlocks + 155
	warp_event 21, 8, 4, ROUTE_15, wOverworldMapBlocks + 116
	warp_event 21, 9, 5, ROUTE_15, wOverworldMapBlocks + 116

	db 0 ; bg events

	db 0 ; person events

Route15_Blocks::
INCBIN "maps/Route15.blk"
