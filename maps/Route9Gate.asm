	map_attributes Route9Gate, ROUTE_9_GATE

Route9Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, SOUTH, 7, 45
	warp_event  1,  7, SOUTH, 7, 45
	warp_event  8,  7, ROUTE_9, 1, 49
	warp_event  9,  7, ROUTE_9, 1, 49

	def_bg_events

	def_object_events

Route9Gate_Blocks::
INCBIN "maps/Route9Gate.blk"

	map_dummy_text_pointers
