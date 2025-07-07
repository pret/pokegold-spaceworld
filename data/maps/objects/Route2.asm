INCLUDE "constants.asm"

SECTION "data/maps/objects/Route2.asm", ROMX

	map_attributes Route2, ROUTE_2, WEST | EAST
	connection west, West, WEST, -5
	connection east, OldCity, OLD_CITY, -5

Route2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6,  5, ROUTE_2_GATE_1F, 3, 67
	warp_event 15,  4, ROUTE_2_HOUSE, 1, 71

	def_bg_events
	bg_event 15,  4, 3
	bg_event 14,  5, 1
	bg_event 24, 10, 2

	def_object_events
	object_event 19, 11, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 15,  7, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  8, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0

Route2_Blocks::
INCBIN "maps/Route2.blk"
