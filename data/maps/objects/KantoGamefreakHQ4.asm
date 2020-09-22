INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGamefreakHQ4.asm", ROMX

	map_attributes KantoGamefreakHQ4, KANTO_GAMEFREAK_HQ_4, 0

KantoGamefreakHQ4_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, KANTO_GAMEFREAK_HQ_5, 1, 42
	warp_event  6,  1, KANTO_GAMEFREAK_HQ_3, 2, 14
	warp_event  2,  1, KANTO_GAMEFREAK_HQ_3, 3, 12

	def_bg_events

	def_object_events

KantoGamefreakHQ4_Blocks::
INCBIN "maps/KantoGamefreakHQ4.blk"
