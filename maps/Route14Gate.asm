	map_attributes Route14Gate, ROUTE_14_GATE

Route14Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_15, 1, 47
	warp_event  5,  7, ROUTE_15, 2, 47
	warp_event  4,  0, ROUTE_14, 1, 14
	warp_event  5,  0, ROUTE_14, 2, 14

	def_bg_events

	def_object_events

Route14Gate_Blocks::
INCBIN "maps/Route14Gate.blk"

	map_dummy_text_pointers
