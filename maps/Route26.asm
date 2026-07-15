	map_attributes Route26, ROUTE_26
	connection north, North, NORTH, 0
	connection south, BlueForest, BLUE_FOREST, -5

Route26_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route26_Blocks::
INCBIN "maps/Route26.blk"

	map_dummy_script_bank27
