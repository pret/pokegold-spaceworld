INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGamefreakHQ5.asm", ROMX

	map_attributes KantoGamefreakHQ5, KANTO_GAMEFREAK_HQ_5, 0

KantoGamefreakHQ5_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, KANTO_GAMEFREAK_HQ_4, 1, 42
	warp_event  4,  7, KANTO_GAMEFREAK_HQ_4, 1, 43

	def_bg_events

	def_object_events

KantoGamefreakHQ5_Blocks::
INCBIN "maps/KantoGamefreakHQ5.blk"
