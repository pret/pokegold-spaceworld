	map_attributes Route23Gate, ROUTE_23_GATE

Route23Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, ROUTE_23, 1, 45
	warp_event  1,  7, ROUTE_23, 1, 45
	warp_event  8,  7, KANTO, 29, 49
	warp_event  9,  7, KANTO, 29, 49

	def_bg_events

	def_object_events

Route23Gate_Blocks::
INCBIN "maps/Route23Gate.blk"

Route23Gate_ScriptLoader::
	ret

Route23Gate_TextPointers::
	db "@"
