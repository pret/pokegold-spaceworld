	map_attributes Route20, ROUTE_20
	connection north, BlueForest, BLUE_FOREST, -5
	connection south, Stand, STAND, -10

Route20_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 48, BLUE_FOREST_ROUTE_GATE_STAND, 3, 405
	warp_event  9, 48, BLUE_FOREST_ROUTE_GATE_STAND, 4, 405

	def_bg_events

	def_object_events

Route20_Blocks::
INCBIN "maps/Route20.blk"

	map_dummy_script_bank27
