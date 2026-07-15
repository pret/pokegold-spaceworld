	map_attributes Route14, ROUTE_14
	connection south, Route15, ROUTE_15, 0
	connection west, Route13, ROUTE_13, 0

Route14_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, BIRDON_ROUTE_GATE_NEWTYPE, 3, 261
	warp_event  9, 30, BIRDON_ROUTE_GATE_NEWTYPE, 4, 261

	def_bg_events

	def_object_events

Route14_Blocks::
INCBIN "maps/Route14.blk"

	map_dummy_script_bank27
