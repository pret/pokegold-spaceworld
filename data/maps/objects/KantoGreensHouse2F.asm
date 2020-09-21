INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGreensHouse2F.asm", ROMX

	map_attributes KantoGreensHouse2F, KANTO_GREENS_HOUSE_2F, 0

KantoGreensHouse2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 1, 3, KANTO_GREENS_HOUSE_1F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

KantoGreensHouse2F_Blocks::
INCBIN "maps/KantoGreensHouse2F.blk"
