	map_attributes Route29, ROUTE_29
	connection north, Prince, PRINCE, 0
	connection south, SilentHill, SILENT_HILL, 0

Route29_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Route29_Blocks::
INCBIN "maps/Route29.blk"

	map_dummy_script_bank27