INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonRouteGateWest.asm", ROMX

	map_attributes BaadonRouteGateWest, BAADON_ROUTE_GATE_WEST, 0

BaadonRouteGateWest_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, WEST, 11, 47
	warp_event  5,  7, WEST, 12, 47
	warp_event  4,  0, BAADON_ROUTE_1, 1, 14
	warp_event  5,  0, BAADON_ROUTE_1, 2, 14

	def_bg_events

	def_object_events

BaadonRouteGateWest_Blocks::
INCBIN "maps/BaadonRouteGateWest.blk"
