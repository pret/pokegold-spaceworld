INCLUDE "constants.asm"

SECTION "data/maps/attributes/StandRocketHouse2F.asm", ROMX
	map_attributes StandRocketHouse2F, STAND_ROCKET_HOUSE_2F, 0

StandRocketHouse2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 15, 1, 3, STAND_ROCKET_HOUSE_1F, wOverworldMapBlocks + 22

	db 0 ; bg events

	db 1 ; person events
	object_event 5, 4, SPRITE_ROCKET_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

StandRocketHouse2F_Blocks:: INCBIN "maps/blk/StandRocketHouse2F.blk"
