INCLUDE "constants.asm"

SECTION "data/maps/objects/FontMart.asm", ROMX

	map_attributes FontMart, FONT_MART, 0

FontMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, FONT, 2, 59
	warp_event  5,  7, FONT, 2, 59

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_GIRL, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontMart_Blocks::
INCBIN "maps/FontMart.blk"
