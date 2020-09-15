INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoCeladonElevator.asm", ROMX
	map_attributes KantoCeladonElevator, KANTO_CELADON_ELEVATOR, 0

KantoCeladonElevator_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 1, 3, 4, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 17
	warp_event 2, 3, 4, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 18

	db 0 ; bg events

	db 0 ; person events

KantoCeladonElevator_Blocks:: INCBIN "maps/placeholder/blk/KantoCeladonElevator.blk"
