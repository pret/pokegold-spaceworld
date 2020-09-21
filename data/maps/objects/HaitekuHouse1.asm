INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuHouse1.asm", ROMX

	map_attributes HaitekuHouse1, HAITEKU_HOUSE_1, 0

HaitekuHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, HAITEKU, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, HAITEKU, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 3, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuHouse1_Blocks::
INCBIN "maps/HaitekuHouse1.blk"
