INCLUDE "constants.asm"

SECTION "data/maps/objects/BullForestRoute2.asm", ROMX

	map_attributes BullForestRoute2, BULL_FOREST_ROUTE_2, NORTH | SOUTH
	connection north, BullForest, BULL_FOREST, -3, 2, 16
	connection south, Stand, STAND, -3, 7, 13

BullForestRoute2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 48, 3, BULL_FOREST_ROUTE_GATE_STAND, wOverworldMapBlocks + 405
	warp_event 9, 48, 4, BULL_FOREST_ROUTE_GATE_STAND, wOverworldMapBlocks + 405

	db 0 ; bg events

	db 0 ; person events

BullForestRoute2_Blocks::
INCBIN "maps/BullForestRoute2.blk"
