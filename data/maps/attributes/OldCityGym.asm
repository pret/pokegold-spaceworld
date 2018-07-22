INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityGym.asm", ROMX
	map_attributes OldCityGym, OLD_CITY_GYM, 0

OldCityGym_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 17, 3, OLD_CITY, wOverworldMapBlocks + 102
	warp_event 5, 17, 4, OLD_CITY, wOverworldMapBlocks + 102

	db 2 ; bg events
	bg_event 3, 15, 0, 1
	bg_event 6, 15, 0, 1

	db 6 ; person events
	object_event 4, 5, SPRITE_HAYATO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 9, SPRITE_YOUNGSTER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event 8, 1, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event 1, 1, SPRITE_SUPER_NERD, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event 1, 9, SPRITE_YOUNGSTER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event 7, 15, SPRITE_GYM_GUY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0

OldCityGym_Blocks:: INCBIN "maps/blk/OldCityGym.blk"