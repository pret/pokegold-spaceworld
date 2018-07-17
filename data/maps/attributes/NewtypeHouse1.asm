INCLUDE "constants.asm"

SECTION "data/maps/attributes/NewtypeHouse1.asm", ROMX
	map_attributes NewtypeHouse1, NEWTYPE_HOUSE_1, 0

NewtypeHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 8, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 8, NEWTYPE, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 3, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse1_Blocks:: INCBIN "maps/blk/NewtypeHouse1.blk"
