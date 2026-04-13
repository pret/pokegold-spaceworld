INCLUDE "constants.asm"

SECTION "data/maps/objects/BirdonLeague1F.asm", ROMX

	map_attributes BirdonLeague1F, BIRDON_LEAGUE_1F, 0

BirdonLeague1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3, 15, BIRDON, 6, 82
	warp_event  4, 15, BIRDON, 7, 83
	warp_event  7,  1, BIRDON_LEAGUE_2F, 1, 14

	def_bg_events

	def_object_events
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  7, SPRITE_LASS, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  9, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  1, SPRITE_COOLTRAINER_M, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

BirdonLeague1F_Blocks::
INCBIN "maps/BirdonLeague1F.blk"
