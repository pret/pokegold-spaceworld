INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonMart.asm", ROMX

	map_attributes BaadonMart, BAADON_MART, 0

BaadonMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BAADON, 1, 59
	warp_event  5,  7, BAADON, 1, 59

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_TEACHER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonMart_Blocks::
INCBIN "maps/BaadonMart.blk"
