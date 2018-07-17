INCLUDE "constants.asm"

SECTION "data/maps/attributes/KantoCeladonMart1F.asm", ROMX
	map_attributes KantoCeladonMart1F, KANTO_CELADON_MART_1F, 0

KantoCeladonMart1F_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 13, 7, 6, KANTO, wOverworldMapBlocks + 63
	warp_event 14, 7, 7, KANTO, wOverworldMapBlocks + 64
	warp_event 15, 0, 2, KANTO_CELADON_MART_2F, wOverworldMapBlocks + 22
	warp_event 2, 0, 2, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 1, SPRITE_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart1F_Blocks:: INCBIN "maps/blk/KantoCeladonMart1F.blk"
