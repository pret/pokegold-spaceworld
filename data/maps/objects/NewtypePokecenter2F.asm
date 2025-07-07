INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypePokecenter2F.asm", ROMX

	map_attributes NewtypePokecenter2F, NEWTYPE_POKECENTER_2F, 0

NewtypePokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, NEWTYPE_POKECENTER_1F, 3, 57

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  7, SPRITE_FISHING_GURU, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypePokecenter2F_Blocks::
INCBIN "maps/NewtypePokecenter2F.blk"
