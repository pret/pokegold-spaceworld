INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/SugarHouse.asm", ROMX
	map_attributes SugarHouse, SUGAR_HOUSE, 0

SugarHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 15, 1, SUGAR, wOverworldMapBlocks + 82
	warp_event 4, 15, 1, SUGAR, wOverworldMapBlocks + 83

	db 0 ; bg events

	db 3 ; person events
	object_event 3, 5, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 5, SPRITE_TWIN, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_GRAMPS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarHouse_Blocks:: INCBIN "maps/placeholder/blk/SugarHouse.blk"