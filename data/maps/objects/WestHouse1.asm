INCLUDE "constants.asm"

SECTION "data/maps/objects/WestHouse1.asm", ROMX

	map_attributes WestHouse1, WEST_HOUSE_1, 0

WestHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, WEST, 9, 47
	warp_event  5,  7, WEST, 9, 47

	def_bg_events
	bg_event  0,  1, 1
	bg_event  1,  1, 2
	bg_event  5,  1, 3
	bg_event  8,  0, 4

	def_object_events
	object_event  7,  3, SPRITE_GRAMPS, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  6, SPRITE_YOUNGSTER, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  4, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestHouse1_Blocks::
INCBIN "maps/WestHouse1.blk"
