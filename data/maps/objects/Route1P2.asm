INCLUDE "constants.asm"

SECTION "data/maps/objects/Route1P2.asm", ROMX

	map_attributes Route1P2, ROUTE_1_P2, NORTH | EAST
	connection north, OldCity, OLD_CITY, -5
	connection east, Route1P1, ROUTE_1_P1, 9

Route1P2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8,  5, ROUTE_1_GATE_1F, 1, 53
	warp_event  9,  5, ROUTE_1_GATE_1F, 2, 53
	warp_event  8, 25, SHIZUKANA_OKA, 6, 213
	warp_event  9, 25, SHIZUKANA_OKA, 9, 213

	def_bg_events
	bg_event 10, 20, 1

	def_object_events
	object_event  8,  6, SPRITE_SILVER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7, 15, SPRITE_TEACHER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0

Route1P2_Blocks::
INCBIN "maps/Route1P2.blk"
