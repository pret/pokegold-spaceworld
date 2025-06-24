INCLUDE "constants.asm"

SECTION "data/maps/objects/SugarPokecenter2F.asm", ROMX

	map_attributes SugarPokecenter2F, SUGAR_POKECENTER_2F, 0

SugarPokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, SUGAR_POKECENTER_1F, 3, 57

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  7, SPRITE_FISHING_GURU, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarPokecenter2F_Blocks::
INCBIN "maps/SugarPokecenter2F.blk"
