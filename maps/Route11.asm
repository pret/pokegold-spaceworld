	map_attributes Route11, ROUTE_11
	connection west, Font, FONT, 0
	connection east, Route12, ROUTE_12, 0

Route11_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route11_Blocks::
INCBIN "maps/Route11.blk"

	map_dummy_script_bank27