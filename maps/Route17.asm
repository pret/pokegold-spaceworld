	map_attributes Route17, ROUTE_17
	connection west, Newtype, NEWTYPE, -9
	connection east, Route18, ROUTE_18, -36

Route17_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route17_Blocks::
INCBIN "maps/Route17.blk"

	map_dummy_script_bank27
