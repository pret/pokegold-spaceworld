INCLUDE "constants.asm"

SECTION "data/maps/objects/StandRoute.asm", ROMX

	map_attributes StandRoute, STAND_ROUTE, NORTH | SOUTH
	connection north, Stand, STAND, -10
	connection south, KantoEastRoute, KANTO_EAST_ROUTE, -10

StandRoute_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 48, STAND_ROUTE_GATE_KANTO, 3, 405
	warp_event  9, 48, STAND_ROUTE_GATE_KANTO, 4, 405

	def_bg_events

	def_object_events

StandRoute_Blocks::
INCBIN "maps/StandRoute.blk"
