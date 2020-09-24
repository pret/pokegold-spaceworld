INCLUDE "constants.asm"

SECTION "data/maps/objects/SugarMart.asm", ROMX

	map_attributes SugarMart, SUGAR_MART, 0

SugarMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, SUGAR, 3, 59
	warp_event  5,  7, SUGAR, 3, 59

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarMart_Blocks::
INCBIN "maps/SugarMart.blk"
