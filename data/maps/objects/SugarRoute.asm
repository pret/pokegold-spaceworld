INCLUDE "constants.asm"

SECTION "data/maps/objects/SugarRoute.asm", ROMX

	map_attributes SugarRoute, SUGAR_ROUTE, NORTH | SOUTH
	connection north, Sugar, SUGAR, 0
	connection south, Newtype, NEWTYPE, -5

SugarRoute_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 48, SUGAR_ROUTE_GATE, 3, 405
	warp_event  9, 48, SUGAR_ROUTE_GATE, 4, 405

	def_bg_events

	def_object_events

SugarRoute_Blocks::
INCBIN "maps/SugarRoute.blk"
