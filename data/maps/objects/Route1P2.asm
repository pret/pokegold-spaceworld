INCLUDE "constants.asm"

SECTION "data/maps/objects/Route1P2.asm", ROMX

	map_attributes Route1P2, ROUTE_1_P2, NORTH | EAST
	connection north, OldCity, OLD_CITY, -5
	connection east, Route1P1, ROUTE_1_P1, 9

Route1P2_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 8, 5, 1, ROUTE_1_GATE_1F, wOverworldMapBlocks + 53
	warp_event 9, 5, 2, ROUTE_1_GATE_1F, wOverworldMapBlocks + 53
	warp_event 8, 25, 6, SHIZUKANA_OKA, wOverworldMapBlocks + 213
	warp_event 9, 25, 9, SHIZUKANA_OKA, wOverworldMapBlocks + 213

	db 1 ; bg events
	bg_event 10, 20, 0, 1

	db 2 ; person events
	object_event 8, 6, SPRITE_SILVER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 15, SPRITE_TEACHER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0

Route1P2_Blocks::
INCBIN "maps/Route1P2.blk"
