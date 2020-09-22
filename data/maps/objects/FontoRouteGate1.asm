INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRouteGate1.asm", ROMX

	map_attributes FontoRouteGate1, FONTO_ROUTE_GATE_1, 0

FontoRouteGate1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, SOUTH, 7, 45
	warp_event  1,  7, SOUTH, 7, 45
	warp_event  8,  7, FONTO_ROUTE_1, 1, 49
	warp_event  9,  7, FONTO_ROUTE_1, 1, 49

	def_bg_events

	def_object_events

FontoRouteGate1_Blocks::
INCBIN "maps/FontoRouteGate1.blk"
