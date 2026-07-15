	map_attributes Route23, ROUTE_23
	connection west, SilentHill, SILENT_HILL, 0
	connection east, Kanto, KANTO, -9

Route23_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 55,  9, ROUTE_23_GATE, 1, 208

	def_bg_events

	def_object_events

Route23_Blocks::
INCBIN "maps/Route23.blk"

	map_dummy_script_bank27