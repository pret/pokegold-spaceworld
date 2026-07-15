	map_attributes Route24, ROUTE_24
	connection south, South, SOUTH, -10
	connection east, Route25, ROUTE_25, 0

Route24_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, FONT_ROUTE_GATE_3, 3, 261
	warp_event  9, 30, FONT_ROUTE_GATE_3, 4, 261

	def_bg_events

	def_object_events

Route24_Blocks::
INCBIN "maps/Route24.blk"

	map_dummy_script_bank27
