INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityPokecenter1F.asm", ROMX

	map_attributes OldCityPokecenter1F, OLD_CITY_POKECENTER_1F, 0

OldCityPokecenter1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, OLD_CITY, 10, 59
	warp_event  6,  7, OLD_CITY, 10, 60
	warp_event  0,  7, OLD_CITY_POKECENTER_2F, 1, 57

	def_bg_events
	bg_event 13,  1, 1

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_YOUNGSTER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_35, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenter1F_Blocks::
INCBIN "maps/OldCityPokecenter1F.blk"
