INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuLeague2F.asm", ROMX

	map_attributes HaitekuLeague2F, HAITEKU_LEAGUE_2F, 0

HaitekuLeague2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7, 15, HAITEKU_LEAGUE_1F, 3, 92

	def_bg_events

	def_object_events
	object_event  4,  1, SPRITE_LASS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  6, SPRITE_24, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8, 12, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2, 10, SPRITE_24, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  7, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuLeague2F_Blocks::
INCBIN "maps/HaitekuLeague2F.blk"
