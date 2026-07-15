	map_attributes Route17Gate, ROUTE_17_GATE

Route17Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_18, 1, 47
	warp_event  5,  7, ROUTE_18, 2, 47
	warp_event  4,  0, ROUTE_19, 1, 14
	warp_event  5,  0, ROUTE_19, 2, 14

	def_bg_events

	def_object_events

Route17Gate_Blocks::
INCBIN "maps/Route17Gate.blk"

	map_dummy_text_pointers
