INCLUDE "constants.asm"

SECTION "data/maps/attributes/FontoPokecenter2F.asm", ROMX
	map_attributes FontoPokecenter2F, FONTO_POKECENTER_2F, 0

FontoPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, FONTO_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoPokecenter2F_Blocks:: INCBIN "maps/blk/FontoPokecenter2F.blk"