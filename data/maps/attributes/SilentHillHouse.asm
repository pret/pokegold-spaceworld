INCLUDE "constants.asm"

SECTION "data/maps/attributes/SilentHillHouse.asm", ROMX
	map_attributes SilentHillHouse, SILENT_HILL_HOUSE, 0

SilentHillHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, SILENT_HILL, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, SILENT_HILL, wOverworldMapBlocks + 47

	db 6 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 4, 1, 0, 2
	bg_event 5, 1, 0, 3
	bg_event 9, 1, 0, 4
	bg_event 8, 1, 0, 5
	bg_event 2, 0, 0, 6

	db 2 ; person events
	object_event 5, 3, SPRITE_SILVERS_MOM, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 4, SPRITE_ROCKER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillHouse_Blocks:: INCBIN "maps/blk/SilentHillHouse.blk"