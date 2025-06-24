INCLUDE "constants.asm"

SECTION "data/maps/objects/SugarHouse2.asm", ROMX

	map_attributes SugarHouse2, SUGAR_HOUSE_2, 0

SugarHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, SUGAR, 2, 42
	warp_event  4,  7, SUGAR, 2, 43

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarHouse2_Blocks::
INCBIN "maps/SugarHouse2.blk"
