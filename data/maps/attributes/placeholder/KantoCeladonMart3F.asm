INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoCeladonMart3F.asm", ROMX
	map_attributes KantoCeladonMart3F, KANTO_CELADON_MART_3F, 0

KantoCeladonMart3F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, KANTO_CELADON_MART_2F, wOverworldMapBlocks + 21
	warp_event 15, 0, 2, KANTO_CELADON_MART_4F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 2 ; person events
	object_event 6, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 5, SPRITE_GIRL, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart3F_Blocks:: INCBIN "maps/placeholder/blk/KantoCeladonMart3F.blk"