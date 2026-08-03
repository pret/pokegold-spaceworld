	map_attributes Route6, ROUTE_6
	connection west, Route7, ROUTE_7, -18
	connection east, HighTech, HIGHTECH, 0

Route6_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route6_Blocks::
INCBIN "maps/Route6.blk"

	map_dummy_script_bank27
