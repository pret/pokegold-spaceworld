	map_attributes Route16, ROUTE_16
	connection north, Sugar, SUGAR, 0
	connection south, Newtype, NEWTYPE, -5

Route16_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 48, ROUTE_16_GATE, 3, 405
	warp_event  9, 48, ROUTE_16_GATE, 4, 405

	def_bg_events

	def_object_events

Route16_Blocks::
INCBIN "maps/Route16.blk"

	map_dummy_script_bank27
