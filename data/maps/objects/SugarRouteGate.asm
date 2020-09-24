INCLUDE "constants.asm"

SECTION "data/maps/objects/SugarRouteGate.asm", ROMX

	map_attributes SugarRouteGate, SUGAR_ROUTE_GATE, 0

SugarRouteGate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NEWTYPE, 12, 47
	warp_event  5,  7, NEWTYPE, 13, 47
	warp_event  4,  0, SUGAR_ROUTE, 1, 14
	warp_event  5,  0, SUGAR_ROUTE, 2, 14

	def_bg_events

	def_object_events

SugarRouteGate_Blocks::
INCBIN "maps/SugarRouteGate.blk"
