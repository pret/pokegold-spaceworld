INCLUDE "constants.asm"

SECTION "data/maps/attributes/BaadonPokecenter1F.asm", ROMX
	map_attributes BaadonPokecenter1F, BAADON_POKECENTER_1F, 0

BaadonPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 2, BAADON, wOverworldMapBlocks + 59
	warp_event 6, 7, 2, BAADON, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, BAADON_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 14, 6, SPRITE_FISHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_GENTLEMAN, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_POKEFAN_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonPokecenter1F_Blocks:: INCBIN "maps/blk/BaadonPokecenter1F.blk"
