INCLUDE "constants.asm"

SECTION "data/maps/objects/RouteSilentEast.asm", ROMX

	map_attributes RouteSilentEast, ROUTE_SILENT_EAST, WEST | EAST
	connection west, SilentHill, SILENT_HILL, 0
	connection east, Kanto, KANTO, -9

RouteSilentEast_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 55,  9, ROUTE_SILENT_EAST_GATE, 1, 208

	def_bg_events

	def_object_events

RouteSilentEast_Blocks::
INCBIN "maps/RouteSilentEast.blk"
