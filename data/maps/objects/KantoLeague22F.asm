INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoLeague22F.asm", ROMX

	map_attributes KantoLeague22F, KANTO_LEAGUE_2_2F, 0

KantoLeague22F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7, 15, KANTO_LEAGUE_2_1F, 3, 92

	def_bg_events

	def_object_events
	object_event  4,  7, SPRITE_POKEFAN_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_24, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  6, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  6, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  1, SPRITE_COOLTRAINER_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoLeague22F_Blocks::
INCBIN "maps/KantoLeague22F.blk"
