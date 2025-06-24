INCLUDE "constants.asm"

SECTION "data/maps/objects/West.asm", ROMX

	map_attributes West, WEST, NORTH | EAST
	connection north, BaadonRoute1, BAADON_ROUTE_1, 5
	connection east, Route2, ROUTE_2, 5

West_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 13,  5, WEST_MART_1F, 1, 85
	warp_event 14,  5, WEST_MART_1F, 2, 86
	warp_event 31,  7, WEST_RADIO_TOWER_1F, 1, 120
	warp_event 32,  7, WEST_RADIO_TOWER_1F, 2, 121
	warp_event 18, 12, WEST_ROCKET_RAIDED_HOUSE, 1, 192
	warp_event 25, 14, WEST_POKECENTER_1F, 1, 221
	warp_event 14, 19, WEST_GYM, 1, 268
	warp_event 15, 19, WEST_GYM, 2, 268
	warp_event 26, 19, WEST_HOUSE_1, 1, 274
	warp_event 32, 19, WEST_HOUSE_2, 1, 277
	warp_event 22,  5, BAADON_ROUTE_GATE_WEST, 1, 90
	warp_event 23,  5, BAADON_ROUTE_GATE_WEST, 2, 90
	warp_event 35, 15, ROUTE_2_GATE_1F, 1, 226

	def_bg_events
	bg_event 16,  7, 1
	bg_event 28,  9, 2
	bg_event 12, 10, 3
	bg_event 32, 12, 4
	bg_event 26, 14, 5
	bg_event 18, 20, 6

	def_object_events
	object_event  6,  8, SPRITE_SAILOR, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12,  7, SPRITE_ROCKER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 26, 10, SPRITE_ROCKER, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 30, 14, SPRITE_LASS, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 29, 14, SPRITE_CLEFAIRY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22, 19, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_XY, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 18, 13, SPRITE_36, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

West_Blocks::
INCBIN "maps/West.blk"
