INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeLeague2F.asm", ROMX

	map_attributes NewtypeLeague2F, NEWTYPE_LEAGUE_2F, 0

NewtypeLeague2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7, 15, NEWTYPE_LEAGUE_1F, 3, 92

	def_bg_events

	def_object_events
	object_event  5,  5, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  0, SPRITE_24, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  0, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0, 11, SPRITE_24, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeLeague2F_Blocks::
INCBIN "maps/NewtypeLeague2F.blk"
