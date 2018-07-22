INCLUDE "constants.asm"

SECTION "data/maps/attributes/HaitekuLeague2F.asm", ROMX
	map_attributes HaitekuLeague2F, HAITEKU_LEAGUE_2F, 0

HaitekuLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, HAITEKU_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 1, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 6, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 12, SPRITE_COOLTRAINER_F, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 10, SPRITE_24, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 7, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuLeague2F_Blocks:: INCBIN "maps/blk/HaitekuLeague2F.blk"