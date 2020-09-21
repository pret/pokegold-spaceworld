INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGreensHouse1F.asm", ROMX

	map_attributes KantoGreensHouse1F, KANTO_GREENS_HOUSE_1F, 0

KantoGreensHouse1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 2, 7, 22, KANTO, wOverworldMapBlocks + 42
	warp_event 3, 7, 22, KANTO, wOverworldMapBlocks + 42
	warp_event 7, 1, 1, KANTO_GREENS_HOUSE_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 1 ; person events
	object_event 5, 3, SPRITE_0F, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGreensHouse1F_Blocks::
INCBIN "maps/KantoGreensHouse1F.blk"
