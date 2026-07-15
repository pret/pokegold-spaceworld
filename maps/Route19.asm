	map_attributes Route19, ROUTE_19
	connection south, Route18, ROUTE_18, 0
	connection east, BlueForest, BLUE_FOREST, -9

Route19_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 12, ROUTE_17_GATE, 3, 222
	warp_event  9, 12, ROUTE_17_GATE, 4, 222
	warp_event  9,  5, ROUTE_19_HOUSE, 1, 98

	def_bg_events

	def_object_events

Route19_Blocks::
INCBIN "maps/Route19.blk"

Route19_ScriptLoader::
	ret

	db "@"
