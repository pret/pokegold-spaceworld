INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGamefreakHQ1.asm", ROMX

	map_attributes KantoGamefreakHQ1, KANTO_GAMEFREAK_HQ_1, 0

KantoGamefreakHQ1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4, 11, KANTO, 9, 63
	warp_event  5, 11, KANTO, 10, 63
	warp_event  7,  1, KANTO_GAMEFREAK_HQ_2, 2, 14
	warp_event  2,  1, KANTO_GAMEFREAK_HQ_2, 3, 12
	warp_event  4,  0, KANTO, 30, 13

	def_bg_events

	def_object_events
	object_event  1,  5, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  5, SPRITE_RHYDON, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  8, SPRITE_CLEFAIRY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  7, SPRITE_PIDGEY, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ1_Blocks::
INCBIN "maps/KantoGamefreakHQ1.blk"
