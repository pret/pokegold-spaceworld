INCLUDE "constants.asm"

SECTION "data/maps/objects/WestMart6F.asm", ROMX

	map_attributes WestMart6F, WEST_MART_6F, 0

WestMart6F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 15,  0, WEST_MART_5F, 2, 22

	def_bg_events
	bg_event  8,  1, 1
	bg_event  9,  1, 2
	bg_event 10,  1, 3
	bg_event 11,  1, 4
	bg_event 14,  0, 5

	def_object_events
	object_event 12,  3, SPRITE_OFFICER, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  4, SPRITE_RHYDON, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  6, SPRITE_PIDGEY, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart6F_Blocks::
INCBIN "maps/WestMart6F.blk"
