INCLUDE "constants.asm"

SECTION "data/maps/objects/NorthPokecenter1F.asm", ROMX

	map_attributes NorthPokecenter1F, NORTH_POKECENTER_1F, 0

NorthPokecenter1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, NORTH, 4, 59
	warp_event  6,  7, NORTH, 4, 60
	warp_event  0,  7, NORTH_POKECENTER_2F, 1, 57

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_24, SPRITEMOVEFN_RANDOM_WALK_Y, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthPokecenter1F_Blocks::
INCBIN "maps/NorthPokecenter1F.blk"
