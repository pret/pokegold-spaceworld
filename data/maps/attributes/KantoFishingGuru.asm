INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoFishingGuru.asm", ROMX
	map_attributes KantoFishingGuru, KANTO_FISHING_GURU, 0

KantoFishingGuru_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 28, KANTO, wOverworldMapBlocks + 46
	warp_event 4, 7, 28, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 4, 3, SPRITE_FISHING_GURU, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoFishingGuru_Blocks:: INCBIN "maps/blk/KantoFishingGuru.blk"
