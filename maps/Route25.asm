	map_attributes Route25, ROUTE_25
	connection west, Route24, ROUTE_24, 0
	connection east, Route10, ROUTE_10, 0

Route25_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route25_Blocks::
INCBIN "maps/Route25.blk"

	map_dummy_script_bank27
