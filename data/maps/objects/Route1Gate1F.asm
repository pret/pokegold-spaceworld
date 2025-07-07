INCLUDE "constants.asm"

SECTION "data/maps/objects/Route1Gate1F.asm", ROMX

	map_attributes Route1Gate1F, ROUTE_1_GATE_1F, 0

Route1Gate1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_1_P2, 1, 47
	warp_event  5,  7, ROUTE_1_P2, 2, 47
	warp_event  4,  0, OLD_CITY, 12, 14
	warp_event  5,  0, OLD_CITY, 13, 14
	warp_event  1,  0, ROUTE_1_GATE_2F, 1, 12

	def_bg_events

	def_object_events
	object_event  6,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route1Gate1F_Blocks::
INCBIN "maps/Route1Gate1F.blk"
