INCLUDE "constants.asm"

SECTION "data/maps/objects/Route2Gate1F.asm", ROMX

	map_attributes Route2Gate1F, ROUTE_2_GATE_1F, 0

Route2Gate1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, WEST, 13, 45
	warp_event  1,  7, WEST, 13, 45
	warp_event  8,  7, ROUTE_2, 1, 49
	warp_event  9,  7, ROUTE_2, 1, 49
	warp_event  1,  0, ROUTE_2_GATE_2F, 1, 12

	def_bg_events

	def_object_events
	object_event  8,  3, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2Gate1F_Blocks::
INCBIN "maps/Route2Gate1F.blk"
