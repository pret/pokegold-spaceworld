INCLUDE "constants.asm"

SECTION "data/maps/attributes/WestPokecenter2F.asm", ROMX
	map_attributes WestPokecenter2F, WEST_POKECENTER_2F, 0

WestPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, WEST_POKECENTER_1F, wOverworldMapBlocks + 57

	db 1 ; bg events
	bg_event 1, 1, 0, 1

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 3, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestPokecenter2F_Blocks:: INCBIN "maps/blk/WestPokecenter2F.blk"