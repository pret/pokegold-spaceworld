	map_attributes Prince, PRINCE
	connection north, Route30, ROUTE_30, 0
	connection south, Route29, ROUTE_29, 0

Prince_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Prince_Blocks::
INCBIN "maps/Prince.blk"
