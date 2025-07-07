INCLUDE "constants.asm"

SECTION "data/maps/objects/Route1Gate2F.asm", ROMX

	map_attributes Route1Gate2F, ROUTE_1_GATE_2F, 0

Route1Gate2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  0, ROUTE_1_GATE_1F, 5, 13

	def_bg_events
	bg_event  1,  0, 1
	bg_event  3,  0, 2

	def_object_events
	object_event  3,  3, SPRITE_LASS, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  4, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route1Gate2F_Blocks::
INCBIN "maps/Route1Gate2F.blk"
