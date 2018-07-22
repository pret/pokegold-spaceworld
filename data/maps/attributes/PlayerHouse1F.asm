INCLUDE "constants.asm"

SECTION "data/maps/attributes/PlayerHouse1F.asm", ROMX
	map_attributes PlayerHouse1F, PLAYER_HOUSE_1F, 0

PlayerHouse1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 6, 7, 1, SILENT_HILL, wOverworldMapBlocks + 48
	warp_event 7, 7, 1, SILENT_HILL, wOverworldMapBlocks + 48
	warp_event 9, 0, 1, PLAYER_HOUSE_2F, wOverworldMapBlocks + 16

	db 5 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 2, 1, 0, 3
	bg_event 4, 1, 0, 4
	bg_event 5, 1, 0, 5

	db 1 ; person events
	object_event 7, 3, SPRITE_MOM, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

PlayerHouse1F_Blocks:: INCBIN "maps/blk/PlayerHouse1F.blk"