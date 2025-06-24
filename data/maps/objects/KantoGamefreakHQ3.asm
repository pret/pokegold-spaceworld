INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGamefreakHQ3.asm", ROMX

	map_attributes KantoGamefreakHQ3, KANTO_GAMEFREAK_HQ_3, 0

KantoGamefreakHQ3_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6,  1, KANTO_GAMEFREAK_HQ_2, 1, 14
	warp_event  7,  1, KANTO_GAMEFREAK_HQ_4, 2, 14
	warp_event  2,  1, KANTO_GAMEFREAK_HQ_4, 3, 12
	warp_event  4,  1, KANTO_GAMEFREAK_HQ_2, 4, 13

	def_bg_events

	def_object_events
	object_event  0,  5, SPRITE_GYM_GUY, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  7, SPRITE_BURGLAR, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  7, SPRITE_FISHER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ3_Blocks::
INCBIN "maps/KantoGamefreakHQ3.blk"
