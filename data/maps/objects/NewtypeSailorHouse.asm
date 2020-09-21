INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeSailorHouse.asm", ROMX

	map_attributes NewtypeSailorHouse, NEWTYPE_SAILOR_HOUSE, 0

NewtypeSailorHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 4, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 4, NEWTYPE, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 6, 3, SPRITE_47, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeSailorHouse_Blocks::
INCBIN "maps/NewtypeSailorHouse.blk"
