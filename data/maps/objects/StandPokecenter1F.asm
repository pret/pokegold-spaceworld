INCLUDE "constants.asm"

SECTION "data/maps/objects/StandPokecenter1F.asm", ROMX

	map_attributes StandPokecenter1F, STAND_POKECENTER_1F, 0

StandPokecenter1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, STAND, 2, 59
	warp_event  6,  7, STAND, 2, 60
	warp_event  0,  7, STAND_POKECENTER_2F, 1, 57

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_GIRL, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_LASS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandPokecenter1F_Blocks::
INCBIN "maps/StandPokecenter1F.blk"
