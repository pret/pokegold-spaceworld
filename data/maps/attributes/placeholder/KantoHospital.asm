INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoHospital.asm", ROMX
	map_attributes KantoHospital, KANTO_HOSPITAL, 0

KantoHospital_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 1, 7, 19, KANTO, wOverworldMapBlocks + 57
	warp_event 2, 7, 19, KANTO, wOverworldMapBlocks + 58

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 6, SPRITE_ROCKER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12, 6, SPRITE_GIRL, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoHospital_Blocks:: INCBIN "maps/placeholder/blk/KantoHospital.blk"
