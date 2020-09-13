INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/NewtypeLeague2F.asm", ROMX
	map_attributes NewtypeLeague2F, NEWTYPE_LEAGUE_2F, 0

NewtypeLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, NEWTYPE_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 5, 5, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 0, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 0, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 11, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 11, SPRITE_COOLTRAINER_F, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeLeague2F_Blocks:: INCBIN "maps/placeholder/blk/NewtypeLeague2F.blk"
