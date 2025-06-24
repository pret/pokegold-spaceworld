INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGameCornerPrizes.asm", ROMX

	map_attributes KantoGameCornerPrizes, KANTO_GAME_CORNER_PRIZES, 0

KantoGameCornerPrizes_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, KANTO, 15, 47
	warp_event  5,  7, KANTO, 15, 47

	def_bg_events

	def_object_events
	object_event  2,  1, SPRITE_CLERK, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_CLERK, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  1, SPRITE_CLERK, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGameCornerPrizes_Blocks::
INCBIN "maps/KantoGameCornerPrizes.blk"
