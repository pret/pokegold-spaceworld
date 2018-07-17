INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoDiner.asm", ROMX
	map_attributes KantoDiner, KANTO_DINER, 0

KantoDiner_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 16, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 16, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 0 ; person events

KantoDiner_Blocks:: INCBIN "maps/blk/KantoDiner.blk"
