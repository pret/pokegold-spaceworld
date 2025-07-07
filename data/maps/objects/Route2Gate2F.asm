INCLUDE "constants.asm"

SECTION "data/maps/objects/Route2Gate2F.asm", ROMX

	map_attributes Route2Gate2F, ROUTE_2_GATE_2F, 0

Route2Gate2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  0, ROUTE_2_GATE_1F, 5, 13

	def_bg_events
	bg_event  1,  0, 1
	bg_event  3,  0, 2

	def_object_events
	object_event  2,  2, SPRITE_LASS, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  4, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2Gate2F_Blocks::
INCBIN "maps/Route2Gate2F.blk"
