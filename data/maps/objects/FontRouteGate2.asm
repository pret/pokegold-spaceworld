INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRouteGate2.asm", ROMX

	map_attributes FontRouteGate2, FONT_ROUTE_GATE_2, 0

FontRouteGate2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BIRDON, 8, 47
	warp_event  5,  7, BIRDON, 9, 47
	warp_event  4,  0, FONT_ROUTE_4, 1, 14
	warp_event  5,  0, FONT_ROUTE_4, 2, 14

	def_bg_events

	def_object_events

FontRouteGate2_Blocks::
INCBIN "maps/FontRouteGate2.blk"
