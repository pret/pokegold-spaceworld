INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Route2Gate1F.asm", ROMX
	map_attributes Route2Gate1F, ROUTE_2_GATE_1F, 0

Route2Gate1F_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 0, 7, 13, WEST, wOverworldMapBlocks + 45
	warp_event 1, 7, 13, WEST, wOverworldMapBlocks + 45
	warp_event 8, 7, 1, ROUTE_2, wOverworldMapBlocks + 49
	warp_event 9, 7, 1, ROUTE_2, wOverworldMapBlocks + 49
	warp_event 1, 0, 1, ROUTE_2_GATE_2F, wOverworldMapBlocks + 12

	db 0 ; bg events

	db 2 ; person events
	object_event 8, 3, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 1, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2Gate1F_Blocks:: INCBIN "maps/placeholder/blk/Route2Gate1F.blk"
