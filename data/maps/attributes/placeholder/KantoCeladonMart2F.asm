INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoCeladonMart2F.asm", ROMX
	map_attributes KantoCeladonMart2F, KANTO_CELADON_MART_2F, 0

KantoCeladonMart2F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, KANTO_CELADON_MART_3F, wOverworldMapBlocks + 21
	warp_event 15, 0, 3, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 2 ; person events
	object_event 14, 5, SPRITE_CLERK, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 5, SPRITE_LASS, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart2F_Blocks:: INCBIN "maps/placeholder/blk/KantoCeladonMart2F.blk"