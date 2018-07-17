INCLUDE "constants.asm"

SECTION "data/maps/attributes/StandOffice.asm", ROMX
	map_attributes StandOffice, STAND_OFFICE, 0

StandOffice_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 2, 7, 3, STAND, wOverworldMapBlocks + 58
	warp_event 3, 7, 3, STAND, wOverworldMapBlocks + 58

	db 0 ; bg events

	db 3 ; person events
	object_event 13, 4, SPRITE_ROCKER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 6, SPRITE_SUPER_NERD, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 7, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandOffice_Blocks:: INCBIN "maps/blk/StandOffice.blk"
