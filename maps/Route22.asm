	map_attributes Route22, ROUTE_22
	connection north, Route21, ROUTE_21, 10
	connection west, Kanto, KANTO, -9

Route22_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 28,  5, ROUTE_21_GATE, 1, 93
	warp_event 29,  5, ROUTE_21_GATE, 2, 93

	def_bg_events

	def_object_events

Route22_Blocks::
INCBIN "maps/Route22.blk"

	map_dummy_script_bank27
