INCLUDE "constants.asm"

SECTION "data/maps/objects/RouteSilentEastGate.asm", ROMX

	map_attributes RouteSilentEastGate, ROUTE_SILENT_EAST_GATE, 0

RouteSilentEastGate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, ROUTE_SILENT_EAST, 1, 45
	warp_event  1,  7, ROUTE_SILENT_EAST, 1, 45
	warp_event  8,  7, KANTO, 29, 49
	warp_event  9,  7, KANTO, 29, 49

	def_bg_events

	def_object_events

RouteSilentEastGate_Blocks::
INCBIN "maps/RouteSilentEastGate.blk"
