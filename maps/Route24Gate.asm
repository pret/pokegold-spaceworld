	map_attributes Route24Gate, ROUTE_24_GATE

Route24Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, SOUTH, 5, 47
	warp_event  5,  7, SOUTH, 6, 47
	warp_event  4,  0, ROUTE_24, 1, 14
	warp_event  5,  0, ROUTE_24, 2, 14

	def_bg_events

	def_object_events

Route24Gate_Blocks::
INCBIN "maps/Route24Gate.blk"

	map_dummy_text_pointers
