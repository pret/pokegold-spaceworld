	map_attributes Route4Gate, ROUTE_4_GATE

Route4Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, WEST, 11, 47
	warp_event  5,  7, WEST, 12, 47
	warp_event  4,  0, ROUTE_4, 1, 14
	warp_event  5,  0, ROUTE_4, 2, 14

	def_bg_events

	def_object_events

Route4Gate_Blocks::
INCBIN "maps/Route4Gate.blk"

	map_dummy_text_pointers
