INCLUDE "constants.asm"

SECTION "data/maps/objects/WestMart4F.asm", ROMX

	map_attributes WestMart4F, WEST_MART_4F, 0

WestMart4F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  0, WEST_MART_5F, 1, 21
	warp_event 15,  0, WEST_MART_3F, 2, 22
	warp_event  2,  0, WEST_MART_ELEVATOR, 1, 16

	def_bg_events
	bg_event 14,  0, 1
	bg_event  3,  0, 2
	bg_event  2,  5, 3
	bg_event  3,  5, 3
	bg_event  4,  5, 3
	bg_event  5,  5, 3
	bg_event  6,  5, 3
	bg_event  7,  5, 3
	bg_event  8,  5, 3
	bg_event  9,  5, 3
	bg_event  6,  1, 3
	bg_event  7,  1, 3
	bg_event  8,  1, 3
	bg_event  9,  1, 3

	def_object_events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8,  6, SPRITE_24, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  2, SPRITE_ROCKER, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart4F_Blocks::
INCBIN "maps/WestMart4F.blk"
