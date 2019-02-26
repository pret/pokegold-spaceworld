INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Kanto.asm", ROMX
	map_attributes Kanto, KANTO, WEST | EAST
	connection west, RouteSilentEast, ROUTE_SILENT_EAST, 9, 0, 9
	connection east, KantoEastRoute, KANTO_EAST_ROUTE, 9, 0, 9

Kanto_MapEvents::
	dw $4000 ; unknown

	db 30 ; warp events
	warp_event 40, 3, 1, KANTO_CERULEAN_HOUSE, wOverworldMapBlocks + 93
	warp_event 13, 4, 1, KANTO_POKECENTER_1F, wOverworldMapBlocks + 115
	warp_event 4, 5, 1, KANTO_LEAGUE_1F, wOverworldMapBlocks + 111
	warp_event 5, 5, 2, KANTO_LEAGUE_1F, wOverworldMapBlocks + 111
	warp_event 51, 11, 1, KANTO_LAVENDER_HOUSE, wOverworldMapBlocks + 242
	warp_event 14, 17, 1, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 332
	warp_event 15, 17, 1, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 332
	warp_event 3, 18, 1, KANTO_MART, wOverworldMapBlocks + 362
	warp_event 22, 19, 1, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 372
	warp_event 23, 19, 2, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 372
	warp_event 30, 19, 1, KANTO_SILPH_CO, wOverworldMapBlocks + 376
	warp_event 31, 19, 2, KANTO_SILPH_CO, wOverworldMapBlocks + 376
	warp_event 16, 23, 1, KANTO_VIRIDIAN_HOUSE, wOverworldMapBlocks + 441
	warp_event 29, 23, 1, KANTO_GAME_CORNER, wOverworldMapBlocks + 447
	warp_event 34, 23, 1, KANTO_GAME_CORNER_PRIZES, wOverworldMapBlocks + 450
	warp_event 40, 23, 1, KANTO_DINER, wOverworldMapBlocks + 453
	warp_event 52, 23, 1, KANTO_SCHOOL, wOverworldMapBlocks + 459
	warp_event 53, 23, 2, KANTO_SCHOOL, wOverworldMapBlocks + 459
	warp_event 38, 29, 1, KANTO_HOSPITAL, wOverworldMapBlocks + 560
	warp_event 49, 30, 1, KANTO_POKECENTER_2_1F, wOverworldMapBlocks + 601
	warp_event 5, 38, 1, KANTO_REDS_HOUSE, wOverworldMapBlocks + 723
	warp_event 13, 38, 1, KANTO_GREENS_HOUSE_1F, wOverworldMapBlocks + 727
	warp_event 39, 38, 1, KANTO_ELDERS_HOUSE, wOverworldMapBlocks + 740
	warp_event 12, 43, 1, KANTO_OAKS_LAB, wOverworldMapBlocks + 799
	warp_event 13, 43, 2, KANTO_OAKS_LAB, wOverworldMapBlocks + 799
	warp_event 52, 45, 1, KANTO_LEAGUE_2_1F, wOverworldMapBlocks + 855
	warp_event 53, 45, 2, KANTO_LEAGUE_2_1F, wOverworldMapBlocks + 855
	warp_event 45, 46, 1, KANTO_FISHING_GURU, wOverworldMapBlocks + 887
	warp_event 6, 27, 3, ROUTE_SILENT_EAST_GATE, wOverworldMapBlocks + 508
	warp_event 21, 13, 5, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 263

	db 12 ; bg events
	bg_event 14, 4, 0, 1
	bg_event 42, 4, 0, 2
	bg_event 54, 8, 0, 3
	bg_event 4, 18, 0, 4
	bg_event 18, 18, 0, 5
	bg_event 26, 19, 0, 6
	bg_event 46, 18, 0, 7
	bg_event 8, 38, 0, 8
	bg_event 16, 38, 0, 9
	bg_event 6, 41, 0, 10
	bg_event 12, 45, 0, 11
	bg_event 50, 30, 0, 12

	db 0 ; person events

Kanto_Blocks:: INCBIN "maps/placeholder/blk/Kanto.blk"