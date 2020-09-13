INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/OldCityTower2F.asm", ROMX
	map_attributes OldCityTower2F, OLD_CITY_TOWER_2F, 0

OldCityTower2F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 1, 3, OLD_CITY_TOWER_1F, wOverworldMapBlocks + 11
	warp_event 7, 7, 2, OLD_CITY_TOWER_3F, wOverworldMapBlocks + 44

	db 2 ; bg events
	bg_event 3, 0, 0, 1
	bg_event 4, 1, 0, 2

	db 4 ; person events
	object_event 2, 3, SPRITE_MEDIUM, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 5, 3, SPRITE_MEDIUM, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 2, 6, SPRITE_MEDIUM, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 5, 6, SPRITE_MEDIUM, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0

OldCityTower2F_Blocks:: INCBIN "maps/placeholder/blk/OldCityTower2F.blk"
