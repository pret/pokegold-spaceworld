INCLUDE "constants.asm"

SECTION "data/maps/objects/SilentHillLabBack.asm", ROMX

	map_attributes SilentHillLabBack, SILENT_HILL_LAB_BACK, 0

SilentHillLabBack_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 3, SILENT_HILL_LAB_FRONT, wOverworldMapBlocks + 42
	warp_event 4, 7, 3, SILENT_HILL_LAB_FRONT, wOverworldMapBlocks + 43

	db 5 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 2, 1, 0, 3
	bg_event 3, 1, 0, 4
	bg_event 6, 0, 0, 5

	db 5 ; person events
	object_event 4, 2, SPRITE_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 4, SPRITE_SILVER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillLabBack_Blocks::
INCBIN "maps/SilentHillLabBack.blk"
