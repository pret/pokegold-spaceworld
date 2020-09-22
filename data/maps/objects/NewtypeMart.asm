INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeMart.asm", ROMX

	map_attributes NewtypeMart, NEWTYPE_MART, 0

NewtypeMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NEWTYPE, 5, 59
	warp_event  5,  7, NEWTYPE, 5, 59

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_POKEFAN_F, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeMart_Blocks::
INCBIN "maps/NewtypeMart.blk"
