INCLUDE "constants.asm"

SECTION "data/maps/objects/NorthMart.asm", ROMX

	map_attributes NorthMart, NORTH_MART, 0

NorthMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NORTH, 2, 51
	warp_event  5,  7, NORTH, 2, 51

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_GIRL, FACE_RIGHT, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthMart_Blocks::
INCBIN "maps/NorthMart.blk"
