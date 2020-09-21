INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuHouse2.asm", ROMX

	map_attributes HaitekuHouse2, HAITEKU_HOUSE_2, 0

HaitekuHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 6, HAITEKU, wOverworldMapBlocks + 47
	warp_event 5, 7, 6, HAITEKU, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 3, SPRITE_SAILOR, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuHouse2_Blocks::
INCBIN "maps/HaitekuHouse2.blk"
