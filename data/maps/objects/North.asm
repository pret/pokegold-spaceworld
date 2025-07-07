INCLUDE "constants.asm"

SECTION "data/maps/objects/North.asm", ROMX

	map_attributes North, NORTH, SOUTH
	connection south, BullForestRoute3, BULL_FOREST_ROUTE_3, 0

North_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  5, NORTH_HOUSE_1, 1, 51
	warp_event 15,  6, NORTH_MART, 1, 72
	warp_event  5,  9, NORTH_HOUSE_2, 1, 83
	warp_event 13, 10, NORTH_POKECENTER_1F, 1, 103

	def_bg_events
	bg_event 12,  4, 1
	bg_event 16,  6, 2
	bg_event 14, 10, 3
	bg_event  8, 12, 4

	def_object_events
	object_event  9,  6, SPRITE_GRANNY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  9, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  9, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

North_Blocks::
INCBIN "maps/North.blk"
