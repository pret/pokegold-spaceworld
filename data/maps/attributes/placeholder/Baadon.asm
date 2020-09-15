INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Baadon.asm", ROMX
	map_attributes Baadon, BAADON, NORTH | SOUTH | EAST
	connection north, FontoRoute4, FONTO_ROUTE_4, 0, 0, 10
	connection south, BaadonRoute1, BAADON_ROUTE_1, 0, 0, 10
	connection east, BaadonRoute2, BAADON_ROUTE_2, 0, 0, 9

Baadon_MapEvents::
	dw $4000 ; unknown

	db 9 ; warp events
	warp_event 3, 4, 1, BAADON_MART, wOverworldMapBlocks + 50
	warp_event 15, 4, 1, BAADON_POKECENTER_1F, wOverworldMapBlocks + 56
	warp_event 4, 9, 1, BAADON_HOUSE_1, wOverworldMapBlocks + 83
	warp_event 3, 13, 1, BAADON_WALLPAPER_HOUSE, wOverworldMapBlocks + 114
	warp_event 9, 13, 1, BAADON_HOUSE_2, wOverworldMapBlocks + 117
	warp_event 14, 15, 1, BAADON_LEAGUE_1F, wOverworldMapBlocks + 136
	warp_event 15, 15, 2, BAADON_LEAGUE_1F, wOverworldMapBlocks + 136
	warp_event 8, 5, 1, FONTO_ROUTE_GATE_2, wOverworldMapBlocks + 53
	warp_event 9, 5, 2, FONTO_ROUTE_GATE_2, wOverworldMapBlocks + 53

	db 4 ; bg events
	bg_event 4, 4, 0, 1
	bg_event 16, 4, 0, 2
	bg_event 11, 10, 0, 3
	bg_event 6, 14, 0, 4

	db 3 ; person events
	object_event 14, 8, SPRITE_SUPER_NERD, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 9, SPRITE_YOUNGSTER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 14, SPRITE_TWIN, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Baadon_Blocks:: INCBIN "maps/placeholder/blk/Baadon.blk"
