INCLUDE "constants.asm"

SECTION "data/maps/objects/StandRouteGateKanto.asm", ROMX

	map_attributes StandRouteGateKanto, STAND_ROUTE_GATE_KANTO, 0

StandRouteGateKanto_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, KANTO_EAST_ROUTE, 1, 47
	warp_event  5,  7, KANTO_EAST_ROUTE, 2, 47
	warp_event  4,  0, STAND_ROUTE, 1, 14
	warp_event  5,  0, STAND_ROUTE, 2, 14

	def_bg_events

	def_object_events

StandRouteGateKanto_Blocks::
INCBIN "maps/StandRouteGateKanto.blk"
