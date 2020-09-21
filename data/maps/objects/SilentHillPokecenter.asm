INCLUDE "constants.asm"

SECTION "data/maps/objects/SilentHillPokecenter.asm", ROMX

	map_attributes SilentHillPokecenter, SILENT_HILL_POKECENTER, 0

SilentHillPokecenter_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 5, 7, 2, SILENT_HILL, wOverworldMapBlocks + 59
	warp_event 6, 7, 2, SILENT_HILL, wOverworldMapBlocks + 60

	db 1 ; bg events
	bg_event 13, 1, 0, 1

	db 5 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 4, SPRITE_24, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_SIDON, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillPokecenter_Blocks::
INCBIN "maps/SilentHillPokecenter.blk"
