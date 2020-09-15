INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Fonto.asm", ROMX
	map_attributes Fonto, FONTO, NORTH | WEST | EAST
	connection north, FontoRoute2, FONTO_ROUTE_2, 0, 0, 10
	connection west, FontoRoute1, FONTO_ROUTE_1, 0, 0, 9
	connection east, FontoRoute3, FONTO_ROUTE_3, 0, 0, 9

Fonto_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 4, 3, 1, FONTO_ROCKET_HOUSE, wOverworldMapBlocks + 35
	warp_event 15, 4, 1, FONTO_MART, wOverworldMapBlocks + 56
	warp_event 3, 7, 1, FONTO_HOUSE, wOverworldMapBlocks + 66
	warp_event 3, 12, 1, FONTO_POKECENTER_1F, wOverworldMapBlocks + 114
	warp_event 16, 13, 1, FONTO_LAB, wOverworldMapBlocks + 121

	db 5 ; bg events
	bg_event 15, 4, 0, 1
	bg_event 14, 6, 0, 2
	bg_event 4, 12, 0, 3
	bg_event 6, 12, 0, 4
	bg_event 10, 12, 0, 5

	db 4 ; person events
	object_event 2, 4, SPRITE_36, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_SIDON, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 14, SPRITE_YOUNGSTER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 16, 8, SPRITE_TWIN, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Fonto_Blocks:: INCBIN "maps/placeholder/blk/Fonto.blk"
