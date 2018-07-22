INCLUDE "constants.asm"

SECTION "data/maps/attributes/Route1Gate1F.asm", ROMX
	map_attributes Route1Gate1F, ROUTE_1_GATE_1F, 0

Route1Gate1F_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 4, 7, 1, ROUTE_1_P2, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, ROUTE_1_P2, wOverworldMapBlocks + 47
	warp_event 4, 0, 12, OLD_CITY, wOverworldMapBlocks + 14
	warp_event 5, 0, 13, OLD_CITY, wOverworldMapBlocks + 14
	warp_event 1, 0, 1, ROUTE_1_GATE_2F, wOverworldMapBlocks + 12

	db 0 ; bg events

	db 2 ; person events
	object_event 6, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 6, SPRITE_COOLTRAINER_F, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route1Gate1F_Blocks:: INCBIN "maps/blk/Route1Gate1F.blk"