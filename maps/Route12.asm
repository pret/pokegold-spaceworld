	map_attributes Route12, ROUTE_12
	connection south, Birdon, BIRDON, 0
	connection west, Route11, ROUTE_11, 0

Route12_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, ROUTE_12_GATE, 3, 261
	warp_event  9, 30, ROUTE_12_GATE, 4, 261

	def_bg_events

	def_object_events

Route12_Blocks::
INCBIN "maps/Route12.blk"

	map_dummy_script_bank27
