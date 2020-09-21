INCLUDE "constants.asm"

SECTION "data/maps/objects/StandLab.asm", ROMX

	map_attributes StandLab, STAND_LAB, 0

StandLab_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 1, STAND, wOverworldMapBlocks + 42
	warp_event 4, 7, 1, STAND, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandLab_Blocks::
INCBIN "maps/StandLab.blk"
