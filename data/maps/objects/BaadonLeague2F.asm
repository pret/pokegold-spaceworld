INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonLeague2F.asm", ROMX

	map_attributes BaadonLeague2F, BAADON_LEAGUE_2F, 0

BaadonLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, BAADON_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 2, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 1, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 9, SPRITE_24, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 11, SPRITE_COOLTRAINER_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonLeague2F_Blocks::
INCBIN "maps/BaadonLeague2F.blk"
