INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonLeague2F.asm", ROMX

	map_attributes BaadonLeague2F, BAADON_LEAGUE_2F, 0

BaadonLeague2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7, 15, BAADON_LEAGUE_1F, 3, 92

	def_bg_events

	def_object_events
	object_event  4,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  2, SPRITE_24, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  1, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  9, SPRITE_24, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonLeague2F_Blocks::
INCBIN "maps/BaadonLeague2F.blk"
