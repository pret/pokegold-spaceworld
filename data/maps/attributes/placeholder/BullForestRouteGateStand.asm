INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/BullForestRouteGateStand.asm", ROMX
	map_attributes BullForestRouteGateStand, BULL_FOREST_ROUTE_GATE_STAND, 0

BullForestRouteGateStand_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 9, STAND, wOverworldMapBlocks + 47
	warp_event 5, 7, 10, STAND, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, BULL_FOREST_ROUTE_2, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, BULL_FOREST_ROUTE_2, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

BullForestRouteGateStand_Blocks:: INCBIN "maps/placeholder/blk/BullForestRouteGateStand.blk"
