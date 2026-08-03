	map_attributes Route16Gate, ROUTE_16_GATE

Route16Gate_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NEWTYPE, 12, 47
	warp_event  5,  7, NEWTYPE, 13, 47
	warp_event  4,  0, ROUTE_16, 1, 14
	warp_event  5,  0, ROUTE_16, 2, 14

	def_bg_events

	def_object_events

Route16Gate_Blocks::
INCBIN "maps/Route16Gate.blk"

	map_dummy_text_pointers
