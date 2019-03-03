INCLUDE "constants.asm"

SECTION "data/maps/attributes/StandRocketHouse1F.asm", ROMX
	map_attributes StandRocketHouse1F, STAND_ROCKET_HOUSE_1F, 0

StandRocketHouse1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 2, 7, 6, STAND, wOverworldMapBlocks + 58
	warp_event 3, 7, 6, STAND, wOverworldMapBlocks + 58
	warp_event 15, 1, 1, STAND_ROCKET_HOUSE_2F, wOverworldMapBlocks + 22

	db 0 ; bg events

	db 1 ; person events
	object_event 11, 4, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandRocketHouse1F_Blocks:: INCBIN "maps/blk/StandRocketHouse1F.blk"