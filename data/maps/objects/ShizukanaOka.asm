INCLUDE "constants.asm"

SECTION "data/maps/objects/ShizukanaOka.asm", ROMX

	map_attributes ShizukanaOka, SHIZUKANA_OKA, 0

ShizukanaOka_MapEvents::
	dw $4000 ; unknown

	db 10 ; warp events
	warp_event 49, 28, 1, ROUTE_1_P1, wOverworldMapBlocks + 490
	warp_event 49, 29, 1, ROUTE_1_P1, wOverworldMapBlocks + 490
	warp_event 49, 30, 2, ROUTE_1_P1, wOverworldMapBlocks + 521
	warp_event 49, 31, 2, ROUTE_1_P1, wOverworldMapBlocks + 521
	warp_event 4, 0, 3, ROUTE_1_P2, wOverworldMapBlocks + 34
	warp_event 5, 0, 3, ROUTE_1_P2, wOverworldMapBlocks + 34
	warp_event 6, 0, 3, ROUTE_1_P2, wOverworldMapBlocks + 35
	warp_event 7, 0, 4, ROUTE_1_P2, wOverworldMapBlocks + 35
	warp_event 8, 0, 4, ROUTE_1_P2, wOverworldMapBlocks + 36
	warp_event 9, 0, 4, ROUTE_1_P2, wOverworldMapBlocks + 36

	db 2 ; bg events
	bg_event 9, 2, 0, 1
	bg_event 47, 28, 0, 2

	db 6 ; person events
	object_event 41, 28, SPRITE_ROCKER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 7, SPRITE_YOUNGSTER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 41, 19, SPRITE_YOUNGSTER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0
	object_event 27, 14, SPRITE_FISHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 36, 16, SPRITE_TEACHER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 9, 25, SPRITE_YOUNGSTER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

ShizukanaOka_Blocks::
INCBIN "maps/ShizukanaOka.blk"
