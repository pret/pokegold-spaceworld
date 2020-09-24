INCLUDE "constants.asm"

SECTION "data/maps/objects/WestPokecenter1F.asm", ROMX

	map_attributes WestPokecenter1F, WEST_POKECENTER_1F, 0

WestPokecenter1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, WEST, 6, 59
	warp_event  6,  7, WEST, 6, 60
	warp_event  0,  7, WEST_POKECENTER_2F, 1, 57

	def_bg_events
	bg_event 13,  1, 1

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_LASS, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_ROCKET_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestPokecenter1F_Blocks::
INCBIN "maps/WestPokecenter1F.blk"
