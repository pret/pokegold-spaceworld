INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/OldCityTower5F.asm", ROMX
	map_attributes OldCityTower5F, OLD_CITY_TOWER_5F, 0

OldCityTower5F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 5, 5, 2, OLD_CITY_TOWER_4F, wOverworldMapBlocks + 30

	db 3 ; bg events
	bg_event 2, 0, 0, 1
	bg_event 3, 0, 0, 2
	bg_event 4, 1, 0, 3

	db 1 ; person events
	object_event 2, 3, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityTower5F_Blocks:: INCBIN "maps/placeholder/blk/OldCityTower5F.blk"
