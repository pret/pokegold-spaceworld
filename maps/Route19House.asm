	map_attributes Route19House, ROUTE_19_HOUSE

Route19House_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_19, 3, 47
	warp_event  5,  7, ROUTE_19, 3, 47

	def_bg_events

	def_object_events
	object_event  1,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route19House_Blocks::
INCBIN "maps/Route19House.blk"

	map_dummy_text_pointers
