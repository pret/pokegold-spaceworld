INCLUDE "constants.asm"

SECTION "data/maps/objects/WestHouse2.asm", ROMX

	map_attributes WestHouse2, WEST_HOUSE_2, 0

WestHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, WEST, 10, 47
	warp_event  5,  7, WEST, 10, 47

	def_bg_events
	bg_event  0,  1, 0, 1
	bg_event  1,  1, 0, 2
	bg_event  5,  1, 0, 3
	bg_event  8,  0, 0, 4

	def_object_events
	object_event  7,  3, SPRITE_GRAMPS, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8,  6, SPRITE_YOUNGSTER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_BUG_CATCHER_BOY, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0

WestHouse2_Blocks::
INCBIN "maps/WestHouse2.blk"
