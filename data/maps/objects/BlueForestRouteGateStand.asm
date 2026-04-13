INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueForestRouteGateStand.asm", ROMX

	map_attributes BlueForestRouteGateStand, BLUE_FOREST_ROUTE_GATE_STAND, 0

BlueForestRouteGateStand_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, STAND, 9, 47
	warp_event  5,  7, STAND, 10, 47
	warp_event  4,  0, BLUE_FOREST_ROUTE_2, 1, 14
	warp_event  5,  0, BLUE_FOREST_ROUTE_2, 2, 14

	def_bg_events

	def_object_events

BlueForestRouteGateStand_Blocks::
INCBIN "maps/BlueForestRouteGateStand.blk"
