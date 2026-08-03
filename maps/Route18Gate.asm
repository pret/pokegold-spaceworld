	map_attributes Route18Gate, ROUTE_18_GATE

Route18Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_18, 1, 47
	warp_event  5,  7, ROUTE_18, 2, 47
	warp_event  4,  0, ROUTE_19, 1, 14
	warp_event  5,  0, ROUTE_19, 2, 14

	def_bg_events

	def_object_events

Route18Gate_Blocks::
INCBIN "maps/Route18Gate.blk"

	map_dummy_text_pointers
