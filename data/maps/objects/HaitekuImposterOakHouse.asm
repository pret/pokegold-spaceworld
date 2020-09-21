INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuImposterOakHouse.asm", ROMX

	map_attributes HaitekuImposterOakHouse, HAITEKU_IMPOSTER_OAK_HOUSE, 0

HaitekuImposterOakHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 7, HAITEKU, wOverworldMapBlocks + 47
	warp_event 5, 7, 7, HAITEKU, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_EVIL_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 2, SPRITE_POKEFAN_F, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuImposterOakHouse_Blocks::
INCBIN "maps/HaitekuImposterOakHouse.blk"
