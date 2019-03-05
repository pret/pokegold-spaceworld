INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoLeague22F.asm", ROMX
	map_attributes KantoLeague22F, KANTO_LEAGUE_2_2F, 0

KantoLeague22F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, KANTO_LEAGUE_2_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 7, SPRITE_POKEFAN_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_24, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 6, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 6, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 1, SPRITE_COOLTRAINER_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoLeague22F_Blocks:: INCBIN "maps/placeholder/blk/KantoLeague22F.blk"