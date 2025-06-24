INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGamefreakHQ2.asm", ROMX

	map_attributes KantoGamefreakHQ2, KANTO_GAMEFREAK_HQ_2, 0

KantoGamefreakHQ2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6,  1, KANTO_GAMEFREAK_HQ_3, 1, 14
	warp_event  7,  1, KANTO_GAMEFREAK_HQ_1, 3, 14
	warp_event  2,  1, KANTO_GAMEFREAK_HQ_1, 4, 12
	warp_event  4,  1, KANTO_GAMEFREAK_HQ_3, 4, 13

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_CLERK, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ2_Blocks::
INCBIN "maps/KantoGamefreakHQ2.blk"
