	map_attributes MtFuji, MT_FUJI
	connection south, Route30, ROUTE_30, 0

MtFuji_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

MtFuji_Blocks::
INCBIN "maps/MtFuji.blk"

	map_dummy_script_bank27
