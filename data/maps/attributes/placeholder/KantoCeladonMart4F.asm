INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoCeladonMart4F.asm", ROMX
	map_attributes KantoCeladonMart4F, KANTO_CELADON_MART_4F, 0

KantoCeladonMart4F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, KANTO_CELADON_MART_5F, wOverworldMapBlocks + 21
	warp_event 15, 0, 2, KANTO_CELADON_MART_3F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 3 ; person events
	object_event 14, 5, SPRITE_MEDIUM, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 5, SPRITE_MEDIUM, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_MEDIUM, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart4F_Blocks:: INCBIN "maps/placeholder/blk/KantoCeladonMart4F.blk"