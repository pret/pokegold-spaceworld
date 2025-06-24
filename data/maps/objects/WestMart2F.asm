INCLUDE "constants.asm"

SECTION "data/maps/objects/WestMart2F.asm", ROMX

	map_attributes WestMart2F, WEST_MART_2F, 0

WestMart2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  0, WEST_MART_3F, 1, 21
	warp_event 15,  0, WEST_MART_1F, 3, 22
	warp_event  2,  0, WEST_MART_ELEVATOR, 1, 16

	def_bg_events
	bg_event 14,  0, 1
	bg_event  3,  0, 2
	bg_event  3,  4, 3
	bg_event  3,  5, 3
	bg_event  3,  6, 3
	bg_event  3,  7, 3
	bg_event  7,  4, 3
	bg_event  7,  5, 3
	bg_event  7,  6, 3
	bg_event  7,  7, 3
	bg_event  4,  1, 3
	bg_event  5,  1, 3
	bg_event  6,  1, 3
	bg_event  7,  1, 3
	bg_event  8,  1, 3
	bg_event  9,  1, 3

	def_object_events
	object_event 14,  5, SPRITE_CLERK, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  6, SPRITE_LASS, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_BURGLAR, SPRITEMOVEFN_RANDOM_WALK_XY, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_ROCKET_M, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart2F_Blocks::
INCBIN "maps/WestMart2F.blk"
