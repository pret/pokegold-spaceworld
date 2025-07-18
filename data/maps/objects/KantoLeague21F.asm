INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoLeague21F.asm", ROMX

	map_attributes KantoLeague21F, KANTO_LEAGUE_2_1F, 0

KantoLeague21F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3, 15, KANTO, 26, 82
	warp_event  4, 15, KANTO, 27, 83
	warp_event  7,  1, KANTO_LEAGUE_2_2F, 1, 14

	def_bg_events

	def_object_events
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  7, SPRITE_LASS, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  9, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  1, SPRITE_24, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

KantoLeague21F_Blocks::
INCBIN "maps/KantoLeague21F.blk"
