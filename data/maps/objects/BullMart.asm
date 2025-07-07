INCLUDE "constants.asm"

SECTION "data/maps/objects/BullMart.asm", ROMX

	map_attributes BullMart, BULL_MART, 0

BullMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BULL_FOREST, 1, 59
	warp_event  5,  7, BULL_FOREST, 1, 59

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_FISHER, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullMart_Blocks::
INCBIN "maps/BullMart.blk"
