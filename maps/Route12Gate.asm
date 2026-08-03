	map_attributes Route12Gate, ROUTE_12_GATE

Route12Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BIRDON, 8, 47
	warp_event  5,  7, BIRDON, 9, 47
	warp_event  4,  0, ROUTE_12, 1, 14
	warp_event  5,  0, ROUTE_12, 2, 14

	def_bg_events

	def_object_events

Route12Gate_Blocks::
INCBIN "maps/Route12Gate.blk"

	map_dummy_text_pointers
