INCLUDE "constants.asm"

SECTION "data/maps/objects/HighTechMart.asm", ROMX

	map_attributes HighTechMart, HIGHTECH_MART, 0

HighTechMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, HIGHTECH, 4, 51
	warp_event  5,  7, HIGHTECH, 4, 51

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_POKEFAN_M, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_SAILOR, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HighTechMart_Blocks::
INCBIN "maps/HighTechMart.blk"
