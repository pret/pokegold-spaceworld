INCLUDE "constants.asm"

SECTION "data/maps/objects/BullForestRouteGateStand.asm", ROMX

	map_attributes BullForestRouteGateStand, BULL_FOREST_ROUTE_GATE_STAND, 0

BullForestRouteGateStand_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, STAND, 9, 47
	warp_event  5,  7, STAND, 10, 47
	warp_event  4,  0, BULL_FOREST_ROUTE_2, 1, 14
	warp_event  5,  0, BULL_FOREST_ROUTE_2, 2, 14

	def_bg_events

	def_object_events

BullForestRouteGateStand_Blocks::
INCBIN "maps/BullForestRouteGateStand.blk"
