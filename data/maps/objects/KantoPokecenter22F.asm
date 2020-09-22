INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoPokecenter22F.asm", ROMX

	map_attributes KantoPokecenter22F, KANTO_POKECENTER_2_2F, 0

KantoPokecenter22F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, KANTO_POKECENTER_2_1F, 3, 57

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoPokecenter22F_Blocks::
INCBIN "maps/KantoPokecenter22F.blk"
