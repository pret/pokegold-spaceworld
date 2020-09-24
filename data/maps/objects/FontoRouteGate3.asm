INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRouteGate3.asm", ROMX

	map_attributes FontoRouteGate3, FONTO_ROUTE_GATE_3, 0

FontoRouteGate3_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, SOUTH, 5, 47
	warp_event  5,  7, SOUTH, 6, 47
	warp_event  4,  0, FONTO_ROUTE_5, 1, 14
	warp_event  5,  0, FONTO_ROUTE_5, 2, 14

	def_bg_events

	def_object_events

FontoRouteGate3_Blocks::
INCBIN "maps/FontoRouteGate3.blk"
