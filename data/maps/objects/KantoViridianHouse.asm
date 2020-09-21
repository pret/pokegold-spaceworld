INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoViridianHouse.asm", ROMX

	map_attributes KantoViridianHouse, KANTO_VIRIDIAN_HOUSE, 0

KantoViridianHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 13, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 13, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_TWIN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoViridianHouse_Blocks::
INCBIN "maps/KantoViridianHouse.blk"
