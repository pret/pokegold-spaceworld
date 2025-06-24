INCLUDE "constants.asm"

SECTION "data/maps/objects/StandMart.asm", ROMX

	map_attributes StandMart, STAND_MART, 0

StandMart_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, STAND, 4, 59
	warp_event  5,  7, STAND, 4, 59

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  5, SPRITE_GIRL, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandMart_Blocks::
INCBIN "maps/StandMart.blk"
