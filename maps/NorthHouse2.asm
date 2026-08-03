	map_attributes NorthHouse2, NORTH_HOUSE_2

NorthHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NORTH, 3, 47
	warp_event  5,  7, NORTH, 3, 47

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_TWIN, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthHouse2_Blocks::
INCBIN "maps/NorthHouse2.blk"

	map_dummy_text_pointers
