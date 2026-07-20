	map_attributes Route10, ROUTE_10
	connection south, Font, FONT, 0
	connection west, Route25, ROUTE_25, 0

Route10_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route10_Blocks::
INCBIN "maps/Route10.blk"

	map_dummy_script_bank27
