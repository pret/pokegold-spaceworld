INCLUDE "constants.asm"

SECTION "data/maps/attributes/Route1Gate2F.asm", ROMX
	map_attributes Route1Gate2F, ROUTE_1_GATE_2F, 0

Route1Gate2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 5, 0, 5, ROUTE_1_GATE_1F, wOverworldMapBlocks + 13

	db 2 ; bg events
	bg_event 1, 0, 0, 1
	bg_event 3, 0, 0, 2

	db 2 ; person events
	object_event 3, 3, SPRITE_LASS, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 4, SPRITE_TWIN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route1Gate2F_Blocks:: INCBIN "maps/blk/Route1Gate2F.blk"