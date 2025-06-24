INCLUDE "constants.asm"

SECTION "data/maps/objects/BullLeague2F.asm", ROMX

	map_attributes BullLeague2F, BULL_LEAGUE_2F, 0

BullLeague2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7, 15, BULL_LEAGUE_1F, 3, 92

	def_bg_events

	def_object_events
	object_event  4,  4, SPRITE_LASS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullLeague2F_Blocks::
INCBIN "maps/BullLeague2F.blk"
