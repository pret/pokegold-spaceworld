INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/HaitekuAquarium2F.asm", ROMX
	map_attributes HaitekuAquarium2F, HAITEKU_AQUARIUM_2F, 0

HaitekuAquarium2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, HAITEKU_AQUARIUM_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 6, SPRITE_POKEFAN_M, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 4, SPRITE_TEACHER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuAquarium2F_Blocks:: INCBIN "maps/placeholder/blk/HaitekuAquarium2F.blk"
