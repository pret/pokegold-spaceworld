	map_attributes Route2, ROUTE_2
	connection north, OldCity, OLD_CITY, -5
	connection east, Route1, ROUTE_1, 9

Route2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8,  5, ROUTE_1_GATE_1F, 1, 53
	warp_event  9,  5, ROUTE_1_GATE_1F, 2, 53
	warp_event  8, 25, QUIET_HILLS, 6, 213
	warp_event  9, 25, QUIET_HILLS, 9, 213

	def_bg_events
	bg_event 10, 20, 1

	def_object_events
	object_event  8,  6, SPRITE_SILVER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7, 15, SPRITE_TEACHER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0

Route2_Blocks::
INCBIN "maps/Route2.blk"
