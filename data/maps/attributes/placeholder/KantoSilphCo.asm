INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoSilphCo.asm", ROMX
	map_attributes KantoSilphCo, KANTO_SILPH_CO, 0

KantoSilphCo_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 6, 15, 11, KANTO, wOverworldMapBlocks + 148
	warp_event 7, 15, 12, KANTO, wOverworldMapBlocks + 148

	db 0 ; bg events

	db 2 ; person events
	object_event 2, 2, SPRITE_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22, 1, SPRITE_OFFICER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoSilphCo_Blocks:: INCBIN "maps/placeholder/blk/KantoSilphCo.blk"