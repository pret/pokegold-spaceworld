	map_attributes RouteSilentEastGate, ROUTE_SILENT_EAST_GATE

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

RouteSilentEastGate_ScriptLoader::
	ret

RouteSilentEastGate_TextPointers::
	db "@"
