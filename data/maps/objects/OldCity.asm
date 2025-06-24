INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCity.asm", ROMX

	map_attributes OldCity, OLD_CITY, SOUTH | WEST
	connection south, Route1P2, ROUTE_1_P2, 5
	connection west, Route2, ROUTE_2, 5

OldCity_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4, 14, OLD_CITY_MUSEUM, 1, 211
	warp_event  5, 14, OLD_CITY_MUSEUM, 2, 211
	warp_event 26, 14, OLD_CITY_GYM, 1, 222
	warp_event 27, 14, OLD_CITY_GYM, 2, 222
	warp_event 11, 17, OLD_CITY_TOWER_1F, 1, 240
	warp_event 12, 17, OLD_CITY_TOWER_1F, 2, 241
	warp_event 30, 22, OLD_CITY_BILLS_HOUSE, 1, 328
	warp_event  3, 26, OLD_CITY_MART, 1, 366
	warp_event 10, 26, OLD_CITY_HOUSE, 1, 370
	warp_event 27, 28, OLD_CITY_POKECENTER_1F, 1, 404
	warp_event  3, 31, OLD_CITY_KURTS_HOUSE, 1, 418
	warp_event 18, 30, ROUTE_1_GATE_1F, 3, 426
	warp_event 19, 30, ROUTE_1_GATE_1F, 4, 426
	warp_event 22, 26, OLD_CITY_SCHOOL, 1, 376

	def_bg_events
	bg_event  8, 14, 1
	bg_event  8, 16, 2
	bg_event 28, 16, 3
	bg_event 20, 22, 4
	bg_event 26, 22, 5
	bg_event  8, 26, 6
	bg_event 28, 28, 7
	bg_event 20, 29, 8
	bg_event  4, 32, 9
	bg_event 30, 22, 10
	bg_event  4, 14, 11
	bg_event  5, 14, 11

	def_object_events
	object_event  8, 30, SPRITE_TWIN, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2, 20, SPRITE_SUPER_NERD, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 26, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 21, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 17, 19, SPRITE_POKE_BALL, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCity_Blocks::
INCBIN "maps/OldCity.blk"
