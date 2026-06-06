INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueForest.asm", ROMX

	map_attributes BlueForest, BLUE_FOREST, NORTH | SOUTH | WEST
	connection north, BlueForestRoute3, BLUE_FOREST_ROUTE_3, 5
	connection south, BlueForestRoute2, BLUE_FOREST_ROUTE_2, 5
	connection west, BlueForestRoute1, BLUE_FOREST_ROUTE_1, 9

BlueForest_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 25,  6, BLUE_MART, 1, 117
	warp_event  9,  9, BLUE_HOUSE_1, 1, 135
	warp_event 27, 11, BLUE_HOUSE_2, 1, 170
	warp_event 19, 13, BLUE_HOUSE_3, 1, 192
	warp_event 13, 18, BLUE_POKECENTER_1F, 1, 267
	warp_event 26, 21, BLUE_LEAGUE_1F, 1, 300
	warp_event 27, 21, BLUE_LEAGUE_1F, 2, 300
	warp_event  3, 22, BLUE_HOUSE_4, 1, 314

	def_bg_events
	bg_event 26,  6, 1
	bg_event  2, 16, 2
	bg_event 14, 18, 3

	def_object_events
	object_event 21,  9, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_WALK_X, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11, 12, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7, 16, SPRITE_GRANNY, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 20, 19, SPRITE_TEACHER, SPRITEMOVEFN_RANDOM_WALK_XY, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 20, 29, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

BlueForest_Blocks::
INCBIN "maps/BlueForest.blk"
