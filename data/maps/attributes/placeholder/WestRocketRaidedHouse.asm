INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/WestRocketRaidedHouse.asm", ROMX
	map_attributes WestRocketRaidedHouse, WEST_ROCKET_RAIDED_HOUSE, 0

WestRocketRaidedHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, WEST, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, WEST, wOverworldMapBlocks + 47

	db 7 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 2, 1, 0, 3
	bg_event 4, 1, 0, 4
	bg_event 5, 1, 0, 4
	bg_event 7, 1, 0, 5
	bg_event 8, 0, 0, 6

	db 5 ; person events
	object_event 8, 1, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 5, SPRITE_36, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 4, SPRITE_POKEFAN_M, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 3, SPRITE_POKEFAN_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRocketRaidedHouse_Blocks:: INCBIN "maps/placeholder/blk/WestRocketRaidedHouse.blk"