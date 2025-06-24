INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGameCorner.asm", ROMX

	map_attributes KantoGameCorner, KANTO_GAME_CORNER, 0

KantoGameCorner_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 13, KANTO, 14, 117
	warp_event  9, 13, KANTO, 14, 117
	warp_event 10, 13, KANTO, 14, 118
	warp_event 11, 13, KANTO, 14, 118

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_CLERK, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  6, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  7, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  8, SPRITE_ROCKER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11,  6, SPRITE_GIRL, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11,  8, SPRITE_GRAMPS, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_FISHER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 17,  9, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  2, SPRITE_ROCKER, SPRITEMOVEFN_RANDOM_WALK_X, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGameCorner_Blocks::
INCBIN "maps/KantoGameCorner.blk"
