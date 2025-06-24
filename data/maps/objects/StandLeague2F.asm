INCLUDE "constants.asm"

SECTION "data/maps/objects/StandLeague2F.asm", ROMX

	map_attributes StandLeague2F, STAND_LEAGUE_2F, 0

StandLeague2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7, 15, STAND_LEAGUE_1F, 3, 92

	def_bg_events

	def_object_events
	object_event  4,  7, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_24, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  6, SPRITE_24, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  1, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandLeague2F_Blocks::
INCBIN "maps/StandLeague2F.blk"
