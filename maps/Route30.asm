	map_attributes Route30, ROUTE_30
	connection north, MtFuji, MT_FUJI, 0
	connection south, Prince, PRINCE, 0

Route30_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route30_Blocks::
INCBIN "maps/Route30.blk"

	map_dummy_script_bank27