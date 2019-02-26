INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityPokecenter1F.asm", ROMX
	map_attributes OldCityPokecenter1F, OLD_CITY_POKECENTER_1F, 0

OldCityPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 10, OLD_CITY, wOverworldMapBlocks + 59
	warp_event 6, 7, 10, OLD_CITY, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, OLD_CITY_POKECENTER_2F, wOverworldMapBlocks + 57

	db 1 ; bg events
	bg_event 13, 1, 0, 1

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_YOUNGSTER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_35, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenter1F_Blocks:: INCBIN "maps/blk/OldCityPokecenter1F.blk"