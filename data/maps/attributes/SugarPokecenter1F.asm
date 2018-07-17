INCLUDE "constants.asm"

SECTION "data/maps/attributes/SugarPokecenter1F.asm", ROMX
	map_attributes SugarPokecenter1F, SUGAR_POKECENTER_1F, 0

SugarPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 4, SUGAR, wOverworldMapBlocks + 59
	warp_event 6, 7, 4, SUGAR, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, SUGAR_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_24, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarPokecenter1F_Blocks:: INCBIN "maps/blk/SugarPokecenter1F.blk"
