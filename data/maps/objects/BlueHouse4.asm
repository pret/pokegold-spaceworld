	map_attributes BlueHouse4, BLUE_HOUSE_4

BlueHouse4_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BLUE_FOREST, 8, 47
	warp_event  5,  7, BLUE_FOREST, 8, 47

	def_bg_events

	def_object_events

BlueHouse4_Blocks::
INCBIN "maps/BlueHouse4.blk"
