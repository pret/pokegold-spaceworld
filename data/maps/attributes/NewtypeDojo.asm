INCLUDE "constants.asm"

SECTION "data/maps/attributes/NewtypeDojo.asm", ROMX
	map_attributes NewtypeDojo, NEWTYPE_DOJO, 0

NewtypeDojo_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 15, 6, NEWTYPE, wOverworldMapBlocks + 82
	warp_event 4, 15, 7, NEWTYPE, wOverworldMapBlocks + 83

	db 0 ; bg events

	db 5 ; person events
	object_event 3, 2, SPRITE_BLACKBELT, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 6, SPRITE_BLACKBELT, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 6, SPRITE_BLACKBELT, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 10, SPRITE_BLACKBELT, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 10, SPRITE_BLACKBELT, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeDojo_Blocks:: INCBIN "maps/blk/NewtypeDojo.blk"
