INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/OldCityTower3F.asm", ROMX
	map_attributes OldCityTower3F, OLD_CITY_TOWER_3F, 0

OldCityTower3F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 1, 1, OLD_CITY_TOWER_4F, wOverworldMapBlocks + 11
	warp_event 7, 7, 2, OLD_CITY_TOWER_2F, wOverworldMapBlocks + 44

	db 2 ; bg events
	bg_event 3, 0, 0, 1
	bg_event 4, 1, 0, 2

	db 4 ; person events
	object_event 2, 3, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 3, 4, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 4, 4, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 5, 5, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0

OldCityTower3F_Blocks:: INCBIN "maps/placeholder/blk/OldCityTower3F.blk"