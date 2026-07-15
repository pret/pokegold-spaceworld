	map_attributes Route9, ROUTE_9
	connection west, South, SOUTH, 0
	connection east, Font, FONT, 0

Route9_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6,  9, ROUTE_9_GATE, 3, 209

	def_bg_events

	def_object_events

Route9_Blocks::
INCBIN "maps/Route9.blk"

	map_dummy_script_bank27