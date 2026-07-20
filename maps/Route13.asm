	map_attributes Route13, ROUTE_13
	connection west, Birdon, BIRDON, 0
	connection east, Route14, ROUTE_14, 0

Route13_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route13_Blocks::
INCBIN "maps/Route13.blk"

	map_dummy_script_bank27
