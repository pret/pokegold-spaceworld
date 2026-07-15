	map_attributes Route4, BIRDON_ROUTE_1
	connection north, Birdon, BIRDON, 0
	connection south, West, WEST, -5

Route4_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12, 48, BIRDON_ROUTE_GATE_WEST, 3, 407
	warp_event 13, 48, BIRDON_ROUTE_GATE_WEST, 4, 407

	def_bg_events

	def_object_events

Route4_Blocks::
INCBIN "maps/Route4.blk"

	map_dummy_script_bank27
