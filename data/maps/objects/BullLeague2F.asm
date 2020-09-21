INCLUDE "constants.asm"

SECTION "data/maps/objects/BullLeague2F.asm", ROMX

	map_attributes BullLeague2F, BULL_LEAGUE_2F, 0

BullLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, BULL_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 4, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 9, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 9, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 11, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 11, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullLeague2F_Blocks::
INCBIN "maps/BullLeague2F.blk"
