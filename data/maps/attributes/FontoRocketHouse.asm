INCLUDE "constants.asm"

SECTION "data/maps/attributes/FontoRocketHouse.asm", ROMX
	map_attributes FontoRocketHouse, FONTO_ROCKET_HOUSE, 0

FontoRocketHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 12, 7, 1, FONTO, wOverworldMapBlocks + 63
	warp_event 13, 7, 1, FONTO, wOverworldMapBlocks + 63

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 4, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 2, SPRITE_ROCKET_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 2, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12, 2, SPRITE_POPPO, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoRocketHouse_Blocks:: INCBIN "maps/blk/FontoRocketHouse.blk"