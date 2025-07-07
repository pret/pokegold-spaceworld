INCLUDE "constants.asm"

SECTION "data/maps/objects/South.asm", ROMX

	map_attributes South, SOUTH, NORTH | SOUTH | EAST
	connection north, FontoRoute5, FONTO_ROUTE_5, 10
	connection south, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, 10
	connection east, FontoRoute1, FONTO_ROUTE_1, 0

South_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 26, 10, SOUTH_HOUSE_1, 1, 170
	warp_event 33, 14, SOUTH_POKECENTER_1F, 1, 225
	warp_event 19, 22, SOUTH_MART, 1, 322
	warp_event 33, 23, SOUTH_HOUSE_2, 1, 329
	warp_event 30,  5, FONTO_ROUTE_GATE_3, 1, 94
	warp_event 31,  5, FONTO_ROUTE_GATE_3, 2, 94
	warp_event 35, 19, FONTO_ROUTE_GATE_1, 2, 278
	warp_event 30, 30, HAITEKU_WEST_ROUTE_GATE, 3, 432
	warp_event 31, 30, HAITEKU_WEST_ROUTE_GATE, 4, 432

	def_bg_events
	bg_event 30, 14, 1
	bg_event 34, 14, 2
	bg_event 28, 17, 3
	bg_event 16, 22, 4
	bg_event 20, 22, 5

	def_object_events
	object_event 25, 21, SPRITE_TWIN, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24, 21, SPRITE_CLEFAIRY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22, 16, SPRITE_ROCKER, SPRITEMOVEFN_RANDOM_WALK_X, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 30, 11, SPRITE_FISHING_GURU, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

South_Blocks::
INCBIN "maps/South.blk"
