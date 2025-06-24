INCLUDE "constants.asm"

SECTION "data/maps/objects/WestPokecenter2F.asm", ROMX

	map_attributes WestPokecenter2F, WEST_POKECENTER_2F, 0

WestPokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, WEST_POKECENTER_1F, 3, 57

	def_bg_events
	bg_event  1,  1, 1

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  3, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestPokecenter2F_Blocks::
INCBIN "maps/WestPokecenter2F.blk"
