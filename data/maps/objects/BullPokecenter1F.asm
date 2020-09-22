INCLUDE "constants.asm"

SECTION "data/maps/objects/BullPokecenter1F.asm", ROMX

	map_attributes BullPokecenter1F, BULL_POKECENTER_1F, 0

BullPokecenter1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, BULL_FOREST, 5, 59
	warp_event  6,  7, BULL_FOREST, 5, 60
	warp_event  0,  7, BULL_POKECENTER_2F, 1, 57

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_24, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullPokecenter1F_Blocks::
INCBIN "maps/BullPokecenter1F.blk"
