INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoEastRoute.asm", ROMX

	map_attributes KantoEastRoute, KANTO_EAST_ROUTE, NORTH | WEST
	connection north, StandRoute, STAND_ROUTE, 10
	connection west, Kanto, KANTO, -9

KantoEastRoute_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 28,  5, STAND_ROUTE_GATE_KANTO, 1, 93
	warp_event 29,  5, STAND_ROUTE_GATE_KANTO, 2, 93

	def_bg_events

	def_object_events

KantoEastRoute_Blocks::
INCBIN "maps/KantoEastRoute.blk"
