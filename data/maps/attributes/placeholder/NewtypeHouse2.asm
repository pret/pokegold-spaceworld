INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/NewtypeHouse2.asm", ROMX
	map_attributes NewtypeHouse2, NEWTYPE_HOUSE_2, 0

NewtypeHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 10, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 10, NEWTYPE, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 4, 3, SPRITE_GENTLEMAN, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse2_Blocks:: INCBIN "maps/placeholder/blk/NewtypeHouse2.blk"