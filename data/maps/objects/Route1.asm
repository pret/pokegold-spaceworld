	map_attributes Route1, ROUTE_1
	connection west, Route2, ROUTE_2, -9
	connection east, SilentHill, SILENT_HILL, 0

Route1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8,  8, QUIET_HILLS, 2, 110
	warp_event  8,  9, QUIET_HILLS, 3, 110

	def_bg_events
	bg_event 12,  7, 1
	bg_event 20,  8, 2

	def_object_events
	object_event 20,  5, SPRITE_SUPER_NERD, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 18, 12, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Route1_Blocks::
INCBIN "maps/Route1.blk"
