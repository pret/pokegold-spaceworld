INCLUDE "constants.asm"

SECTION "data/maps/objects/WestMart3F.asm", ROMX

	map_attributes WestMart3F, WEST_MART_3F, 0

WestMart3F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  0, WEST_MART_2F, 1, 21
	warp_event 15,  0, WEST_MART_4F, 2, 22
	warp_event  2,  0, WEST_MART_ELEVATOR, 1, 16

	def_bg_events
	bg_event 14,  0, 1
	bg_event  3,  0, 2
	bg_event  1,  4, 3
	bg_event  1,  5, 3
	bg_event  1,  6, 3
	bg_event  1,  7, 3
	bg_event  5,  4, 3
	bg_event  5,  5, 3
	bg_event  5,  6, 3
	bg_event  5,  7, 3
	bg_event  9,  4, 3
	bg_event  9,  5, 3
	bg_event  9,  6, 3
	bg_event  9,  7, 3

	def_object_events
	object_event  6,  1, SPRITE_CLERK, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  4, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_WALK_XY, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  5, SPRITE_SUPER_NERD, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart3F_Blocks::
INCBIN "maps/WestMart3F.blk"
