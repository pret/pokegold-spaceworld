INCLUDE "constants.asm"

SECTION "data/maps/objects/HighTechLeague2F.asm", ROMX

	map_attributes HighTechLeague2F, HIGHTECH_LEAGUE_2F, 0

HighTechLeague2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7, 15, HIGHTECH_LEAGUE_1F, 3, 92

	def_bg_events

	def_object_events
	object_event  4,  1, SPRITE_LASS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8, 12, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2, 10, SPRITE_COOLTRAINER_M, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  7, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HighTechLeague2F_Blocks::
INCBIN "maps/HighTechLeague2F.blk"
