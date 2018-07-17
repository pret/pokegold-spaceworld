INCLUDE "constants.asm"

SECTION "data/maps/attributes/NewtypeHouse3.asm", ROMX
	map_attributes NewtypeHouse3, NEWTYPE_HOUSE_3, 0

NewtypeHouse3_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 11, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 11, NEWTYPE, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 4, 3, SPRITE_GRAMPS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse3_Blocks:: INCBIN "maps/blk/NewtypeHouse3.blk"
