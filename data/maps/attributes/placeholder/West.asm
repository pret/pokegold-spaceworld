INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/West.asm", ROMX
	map_attributes West, WEST, NORTH | EAST
	connection north, BaadonRoute1, BAADON_ROUTE_1, 5, 0, 10
	connection east, Route2, ROUTE_2, 5, 0, 9

West_MapEvents::
	dw $4000 ; unknown

	db 13 ; warp events
	warp_event 13, 5, 1, WEST_MART_1F, wOverworldMapBlocks + 85
	warp_event 14, 5, 2, WEST_MART_1F, wOverworldMapBlocks + 86
	warp_event 31, 7, 1, WEST_RADIO_TOWER_1F, wOverworldMapBlocks + 120
	warp_event 32, 7, 2, WEST_RADIO_TOWER_1F, wOverworldMapBlocks + 121
	warp_event 18, 12, 1, WEST_ROCKET_RAIDED_HOUSE, wOverworldMapBlocks + 192
	warp_event 25, 14, 1, WEST_POKECENTER_1F, wOverworldMapBlocks + 221
	warp_event 14, 19, 1, WEST_GYM, wOverworldMapBlocks + 268
	warp_event 15, 19, 2, WEST_GYM, wOverworldMapBlocks + 268
	warp_event 26, 19, 1, WEST_HOUSE_1, wOverworldMapBlocks + 274
	warp_event 32, 19, 1, WEST_HOUSE_2, wOverworldMapBlocks + 277
	warp_event 22, 5, 1, BAADON_ROUTE_GATE_WEST, wOverworldMapBlocks + 90
	warp_event 23, 5, 2, BAADON_ROUTE_GATE_WEST, wOverworldMapBlocks + 90
	warp_event 35, 15, 1, ROUTE_2_GATE_1F, wOverworldMapBlocks + 226

	db 6 ; bg events
	bg_event 16, 7, 0, 1
	bg_event 28, 9, 0, 2
	bg_event 12, 10, 0, 3
	bg_event 32, 12, 0, 4
	bg_event 26, 14, 0, 5
	bg_event 18, 20, 0, 6

	db 7 ; person events
	object_event 6, 8, SPRITE_SAILOR, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12, 7, SPRITE_ROCKER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 26, 10, SPRITE_ROCKER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 30, 14, SPRITE_LASS, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 29, 14, SPRITE_PIPPI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22, 19, SPRITE_COOLTRAINER_F, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 18, 13, SPRITE_36, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

West_Blocks:: INCBIN "maps/placeholder/blk/West.blk"