INCLUDE "constants.asm"

SECTION "data/maps/attributes/FontoLab.asm", ROMX
	map_attributes FontoLab, FONTO_LAB, 0

FontoLab_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 5, FONTO, wOverworldMapBlocks + 46
	warp_event 4, 7, 5, FONTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 2, 2, SPRITE_SCIENTIST, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 5, SPRITE_SCIENTIST, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoLab_Blocks:: INCBIN "maps/blk/FontoLab.blk"
