INCLUDE "constants.asm"

SECTION "data/maps/objects/Fonto.asm", ROMX

	map_attributes Fonto, FONTO, NORTH | WEST | EAST
	connection north, FontoRoute2, FONTO_ROUTE_2, 0
	connection west, FontoRoute1, FONTO_ROUTE_1, 0
	connection east, FontoRoute3, FONTO_ROUTE_3, 0

Fonto_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  3, FONTO_ROCKET_HOUSE, 1, 35
	warp_event 15,  4, FONTO_MART, 1, 56
	warp_event  3,  7, FONTO_HOUSE, 1, 66
	warp_event  3, 12, FONTO_POKECENTER_1F, 1, 114
	warp_event 16, 13, FONTO_LAB, 1, 121

	def_bg_events
	bg_event 15,  4, 1
	bg_event 14,  6, 2
	bg_event  4, 12, 3
	bg_event  6, 12, 4
	bg_event 10, 12, 5

	def_object_events
	object_event  2,  4, SPRITE_36, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_RHYDON, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5, 14, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 16,  8, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Fonto_Blocks::
INCBIN "maps/Fonto.blk"
