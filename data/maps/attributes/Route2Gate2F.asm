INCLUDE "constants.asm"

SECTION "data/maps/attributes/Route2Gate2F.asm", ROMX
	map_attributes Route2Gate2F, ROUTE_2_GATE_2F, 0

Route2Gate2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 5, 0, 5, ROUTE_2_GATE_1F, wOverworldMapBlocks + 13

	db 2 ; bg events
	bg_event 1, 0, 0, 1
	bg_event 3, 0, 0, 2

	db 2 ; person events
	object_event 2, 2, SPRITE_LASS, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 4, SPRITE_TWIN, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2Gate2F_Blocks:: INCBIN "maps/blk/Route2Gate2F.blk"
