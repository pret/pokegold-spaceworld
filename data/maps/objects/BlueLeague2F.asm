INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueLeague2F.asm", ROMX

	map_attributes BlueLeague2F, BLUE_LEAGUE_2F, 0

BlueLeague2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7, 15, BLUE_LEAGUE_1F, 3, 92

	def_bg_events

	def_object_events
	object_event  4,  4, SPRITE_LASS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BlueLeague2F_Blocks::
INCBIN "maps/BlueLeague2F.blk"
