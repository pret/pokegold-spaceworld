	map_attributes Route18, ROUTE_18
	connection north, Route19, ROUTE_19, 0
	connection west, Route17, ROUTE_17, 36

Route18_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8,  5, ROUTE_18_GATE, 1, 53
	warp_event  9,  5, ROUTE_18_GATE, 2, 53
	warp_event 13, 28, ROUTE_18_POKECENTER_1F, 1, 247

	def_bg_events

	def_object_events

Route18_Blocks::
INCBIN "maps/Route18.blk"

	map_dummy_script_bank27
