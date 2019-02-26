INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityTower4F.asm", ROMX
	map_attributes OldCityTower4F, OLD_CITY_TOWER_4F, 0

OldCityTower4F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 1, 1, OLD_CITY_TOWER_3F, wOverworldMapBlocks + 11
	warp_event 7, 7, 1, OLD_CITY_TOWER_5F, wOverworldMapBlocks + 44

	db 2 ; bg events
	bg_event 3, 0, 0, 1
	bg_event 4, 1, 0, 2

	db 4 ; person events
	object_event 3, 2, SPRITE_SAGE, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 4, 7, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 6, 7, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 7, 1, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

OldCityTower4F_Blocks:: INCBIN "maps/blk/OldCityTower4F.blk"