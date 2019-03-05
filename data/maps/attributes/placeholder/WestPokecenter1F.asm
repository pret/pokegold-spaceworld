INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/WestPokecenter1F.asm", ROMX
	map_attributes WestPokecenter1F, WEST_POKECENTER_1F, 0

WestPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 6, WEST, wOverworldMapBlocks + 59
	warp_event 6, 7, 6, WEST, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, WEST_POKECENTER_2F, wOverworldMapBlocks + 57

	db 1 ; bg events
	bg_event 13, 1, 0, 1

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_LASS, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_ROCKET_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestPokecenter1F_Blocks:: INCBIN "maps/placeholder/blk/WestPokecenter1F.blk"