INCLUDE "constants.asm"

SECTION "data/maps/attributes/PlayerHouse2F.asm", ROMX
	map_attributes PlayerHouse2F, PLAYER_HOUSE_2F, 0

PlayerHouse2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 9, 0, 3, PLAYER_HOUSE_1F, wOverworldMapBlocks + 16

	db 5 ; bg events
	bg_event 1, 1, 0, 1
	bg_event 2, 1, 0, 2
	bg_event 3, 1, 0, 3
	bg_event 5, 1, 0, 4
	bg_event 7, 2, 0, 5

	db 2 ; person events
	object_event 8, 1, SPRITE_ROCKER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 1, SPRITE_PIPPI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

PlayerHouse2F_Blocks:: INCBIN "maps/blk/PlayerHouse2F.blk"
