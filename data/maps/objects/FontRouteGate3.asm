INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRouteGate3.asm", ROMX

	map_attributes FontRouteGate3, FONT_ROUTE_GATE_3, 0

FontRouteGate3_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, SOUTH, 5, 47
	warp_event  5,  7, SOUTH, 6, 47
	warp_event  4,  0, FONT_ROUTE_5, 1, 14
	warp_event  5,  0, FONT_ROUTE_5, 2, 14

	def_bg_events

	def_object_events

FontRouteGate3_Blocks::
INCBIN "maps/FontRouteGate3.blk"
