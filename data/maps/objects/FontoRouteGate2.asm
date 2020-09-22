INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRouteGate2.asm", ROMX

	map_attributes FontoRouteGate2, FONTO_ROUTE_GATE_2, 0

FontoRouteGate2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BAADON, 8, 47
	warp_event  5,  7, BAADON, 9, 47
	warp_event  4,  0, FONTO_ROUTE_4, 1, 14
	warp_event  5,  0, FONTO_ROUTE_4, 2, 14

	def_bg_events

	def_object_events

FontoRouteGate2_Blocks::
INCBIN "maps/FontoRouteGate2.blk"
