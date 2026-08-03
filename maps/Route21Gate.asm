	map_attributes Route21Gate, ROUTE_21_GATE

Route21Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_22, 1, 47
	warp_event  5,  7, ROUTE_22, 2, 47
	warp_event  4,  0, ROUTE_21, 1, 14
	warp_event  5,  0, ROUTE_21, 2, 14

	def_bg_events

	def_object_events

Route21Gate_Blocks::
INCBIN "maps/Route21Gate.blk"

	map_dummy_text_pointers
