	map_attributes Route21, ROUTE_21
	connection north, Stand, STAND, -10
	connection south, Route22, ROUTE_22, -10

Route21_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 48, ROUTE_21_GATE, 3, 405
	warp_event  9, 48, ROUTE_21_GATE, 4, 405

	def_bg_events

	def_object_events

Route21_Blocks::
INCBIN "maps/Route21.blk"

	map_dummy_script_bank27
