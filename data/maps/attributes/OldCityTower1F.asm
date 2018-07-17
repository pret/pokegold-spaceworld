INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityTower1F.asm", ROMX
	map_attributes OldCityTower1F, OLD_CITY_TOWER_1F, 0

OldCityTower1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 7, 5, OLD_CITY, wOverworldMapBlocks + 42
	warp_event 4, 7, 6, OLD_CITY, wOverworldMapBlocks + 43
	warp_event 0, 1, 1, OLD_CITY_TOWER_2F, wOverworldMapBlocks + 11

	db 3 ; bg events
	bg_event 2, 6, 0, 1
	bg_event 5, 6, 0, 2
	bg_event 4, 1, 0, 3

	db 4 ; person events
	object_event 0, 2, SPRITE_SAGE, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 1, 5, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 5, 1, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 6, 4, SPRITE_SAGE, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

OldCityTower1F_Blocks:: INCBIN "maps/blk/OldCityTower1F.blk"
