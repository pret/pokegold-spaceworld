	map_attributes Route20Gate, ROUTE_20_GATE

Route20Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, STAND, 9, 47
	warp_event  5,  7, STAND, 10, 47
	warp_event  4,  0, ROUTE_20, 1, 14
	warp_event  5,  0, ROUTE_20, 2, 14

	def_bg_events

	def_object_events

Route20Gate_Blocks::
INCBIN "maps/Route20Gate.blk"

	map_dummy_text_pointers
