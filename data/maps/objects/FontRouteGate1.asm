INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRouteGate1.asm", ROMX

	map_attributes FontRouteGate1, FONT_ROUTE_GATE_1, 0

FontRouteGate1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, SOUTH, 7, 45
	warp_event  1,  7, SOUTH, 7, 45
	warp_event  8,  7, FONT_ROUTE_1, 1, 49
	warp_event  9,  7, FONT_ROUTE_1, 1, 49

	def_bg_events

	def_object_events

FontRouteGate1_Blocks::
INCBIN "maps/FontRouteGate1.blk"
