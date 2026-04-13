INCLUDE "constants.asm"

SECTION "data/maps/objects/BluePokecenter1F.asm", ROMX

	map_attributes BluePokecenter1F, BLUE_POKECENTER_1F, 0

BluePokecenter1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, BLUE_FOREST, 5, 59
	warp_event  6,  7, BLUE_FOREST, 5, 60
	warp_event  0,  7, BLUE_POKECENTER_2F, 1, 57

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_COOLTRAINER_M, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_GRANNY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BluePokecenter1F_Blocks::
INCBIN "maps/BluePokecenter1F.blk"
