INCLUDE "constants.asm"

SECTION "data/maps/objects/ShizukanaOka.asm", ROMX

	map_attributes ShizukanaOka, SHIZUKANA_OKA, 0

ShizukanaOka_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 49, 28, ROUTE_1_P1, 1, 490
	warp_event 49, 29, ROUTE_1_P1, 1, 490
	warp_event 49, 30, ROUTE_1_P1, 2, 521
	warp_event 49, 31, ROUTE_1_P1, 2, 521
	warp_event  4,  0, ROUTE_1_P2, 3, 34
	warp_event  5,  0, ROUTE_1_P2, 3, 34
	warp_event  6,  0, ROUTE_1_P2, 3, 35
	warp_event  7,  0, ROUTE_1_P2, 4, 35
	warp_event  8,  0, ROUTE_1_P2, 4, 36
	warp_event  9,  0, ROUTE_1_P2, 4, 36

	def_bg_events
	bg_event  9,  2, 1
	bg_event 47, 28, 2

	def_object_events
	object_event 41, 28, SPRITE_ROCKER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  7, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 41, 19, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0
	object_event 27, 14, SPRITE_FISHER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 36, 16, SPRITE_TEACHER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event  9, 25, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

ShizukanaOka_Blocks::
INCBIN "maps/ShizukanaOka.blk"
