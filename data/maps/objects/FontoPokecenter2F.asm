INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoPokecenter2F.asm", ROMX

	map_attributes FontoPokecenter2F, FONTO_POKECENTER_2F, 0

FontoPokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, FONTO_POKECENTER_1F, 3, 57

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoPokecenter2F_Blocks::
INCBIN "maps/FontoPokecenter2F.blk"
