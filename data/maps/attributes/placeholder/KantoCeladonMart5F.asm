INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoCeladonMart5F.asm", ROMX
	map_attributes KantoCeladonMart5F, KANTO_CELADON_MART_5F, 0

KantoCeladonMart5F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 13, 0, 1, KANTO_CELADON_MART_4F, wOverworldMapBlocks + 21
	warp_event 2, 0, 1, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 3 ; person events
	object_event 14, 5, SPRITE_CLERK, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 3, SPRITE_SIDON, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart5F_Blocks:: INCBIN "maps/placeholder/blk/KantoCeladonMart5F.blk"
