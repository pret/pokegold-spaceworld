INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCity.asm", ROMX

	map_attributes OldCity, OLD_CITY, SOUTH | WEST
	connection south, Route1P2, ROUTE_1_P2, 5, 0, 10
	connection west, Route2, ROUTE_2, 5, 0, 9

OldCity_MapEvents::
	dw $4000 ; unknown

	db 14 ; warp events
	warp_event 4, 14, 1, OLD_CITY_MUSEUM, wOverworldMapBlocks + 211
	warp_event 5, 14, 2, OLD_CITY_MUSEUM, wOverworldMapBlocks + 211
	warp_event 26, 14, 1, OLD_CITY_GYM, wOverworldMapBlocks + 222
	warp_event 27, 14, 2, OLD_CITY_GYM, wOverworldMapBlocks + 222
	warp_event 11, 17, 1, OLD_CITY_TOWER_1F, wOverworldMapBlocks + 240
	warp_event 12, 17, 2, OLD_CITY_TOWER_1F, wOverworldMapBlocks + 241
	warp_event 30, 22, 1, OLD_CITY_BILLS_HOUSE, wOverworldMapBlocks + 328
	warp_event 3, 26, 1, OLD_CITY_MART, wOverworldMapBlocks + 366
	warp_event 10, 26, 1, OLD_CITY_HOUSE, wOverworldMapBlocks + 370
	warp_event 27, 28, 1, OLD_CITY_POKECENTER_1F, wOverworldMapBlocks + 404
	warp_event 3, 31, 1, OLD_CITY_KURTS_HOUSE, wOverworldMapBlocks + 418
	warp_event 18, 30, 3, ROUTE_1_GATE_1F, wOverworldMapBlocks + 426
	warp_event 19, 30, 4, ROUTE_1_GATE_1F, wOverworldMapBlocks + 426
	warp_event 22, 26, 1, OLD_CITY_SCHOOL, wOverworldMapBlocks + 376

	db 12 ; bg events
	bg_event 8, 14, 0, 1
	bg_event 8, 16, 0, 2
	bg_event 28, 16, 0, 3
	bg_event 20, 22, 0, 4
	bg_event 26, 22, 0, 5
	bg_event 8, 26, 0, 6
	bg_event 28, 28, 0, 7
	bg_event 20, 29, 0, 8
	bg_event 4, 32, 0, 9
	bg_event 30, 22, 0, 10
	bg_event 4, 14, 0, 11
	bg_event 5, 14, 0, 11

	db 5 ; person events
	object_event 8, 30, SPRITE_TWIN, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 20, SPRITE_SUPER_NERD, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 26, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 21, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 17, 19, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCity_Blocks::
INCBIN "maps/OldCity.blk"
