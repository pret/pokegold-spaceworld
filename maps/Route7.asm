	map_attributes Route7, ROUTE_7
	connection north, South, SOUTH, -10
	connection east, Route6, ROUTE_6, 18

Route7_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 10,  9, ROUTE_7_GATE, 1, 86
	warp_event 11,  9, ROUTE_7_GATE, 2, 86

	def_bg_events

	def_object_events

Route7_Blocks::
INCBIN "maps/Route7.blk"

	map_dummy_script_bank27
