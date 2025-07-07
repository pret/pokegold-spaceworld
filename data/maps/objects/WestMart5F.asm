INCLUDE "constants.asm"

SECTION "data/maps/objects/WestMart5F.asm", ROMX

	map_attributes WestMart5F, WEST_MART_5F, 0

WestMart5F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  0, WEST_MART_4F, 1, 21
	warp_event 15,  0, WEST_MART_6F, 1, 22
	warp_event  2,  0, WEST_MART_ELEVATOR, 1, 16

	def_bg_events
	bg_event 14,  0, 1
	bg_event  3,  0, 2

	def_object_events
	object_event  8,  5, SPRITE_GYM_GUY, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  5, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  4, SPRITE_POLIWRATH, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart5F_Blocks::
INCBIN "maps/WestMart5F.blk"
