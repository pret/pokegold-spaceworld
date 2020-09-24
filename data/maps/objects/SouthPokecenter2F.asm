INCLUDE "constants.asm"

SECTION "data/maps/objects/SouthPokecenter2F.asm", ROMX

	map_attributes SouthPokecenter2F, SOUTH_POKECENTER_2F, 0

SouthPokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, SOUTH_POKECENTER_1F, 3, 57

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthPokecenter2F_Blocks::
INCBIN "maps/SouthPokecenter2F.blk"
