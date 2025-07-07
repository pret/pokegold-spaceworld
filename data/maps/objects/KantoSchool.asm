INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoSchool.asm", ROMX

	map_attributes KantoSchool, KANTO_SCHOOL, 0

KantoSchool_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3, 15, KANTO, 17, 82
	warp_event  4, 15, KANTO, 18, 83

	def_bg_events

	def_object_events
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  7, SPRITE_LASS, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  9, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  1, SPRITE_24, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

KantoSchool_Blocks::
INCBIN "maps/KantoSchool.blk"
