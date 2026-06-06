INCLUDE "constants.asm"

SECTION "data/maps/objects/BirdonRouteGateWest.asm", ROMX

	map_attributes BirdonRouteGateWest, BIRDON_ROUTE_GATE_WEST, 0

BirdonRouteGateWest_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, WEST, 11, 47
	warp_event  5,  7, WEST, 12, 47
	warp_event  4,  0, BIRDON_ROUTE_1, 1, 14
	warp_event  5,  0, BIRDON_ROUTE_1, 2, 14

	def_bg_events

	def_object_events

BirdonRouteGateWest_Blocks::
INCBIN "maps/BirdonRouteGateWest.blk"
