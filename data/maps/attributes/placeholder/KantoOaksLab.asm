INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoOaksLab.asm", ROMX
	map_attributes KantoOaksLab, KANTO_OAKS_LAB, 0

KantoOaksLab_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 24, KANTO, wOverworldMapBlocks + 42
	warp_event 4, 7, 25, KANTO, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 3, 2, SPRITE_NANAMI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoOaksLab_Blocks:: INCBIN "maps/placeholder/blk/KantoOaksLab.blk"
