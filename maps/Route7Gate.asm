	map_attributes Route7Gate, ROUTE_7_GATE

Route7Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_7, 1, 47
	warp_event  5,  7, ROUTE_7, 2, 47
	warp_event  4,  0, SOUTH, 8, 14
	warp_event  5,  0, SOUTH, 9, 14

	def_bg_events

	def_object_events

Route7Gate_Blocks::
INCBIN "maps/Route7Gate.blk"

	map_dummy_text_pointers