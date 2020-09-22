INCLUDE "constants.asm"

SECTION "data/maps/objects/Kanto.asm", ROMX

	map_attributes Kanto, KANTO, WEST | EAST
	connection west, RouteSilentEast, ROUTE_SILENT_EAST, 9
	connection east, KantoEastRoute, KANTO_EAST_ROUTE, 9

Kanto_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 40,  3, KANTO_CERULEAN_HOUSE, 1, 93
	warp_event 13,  4, KANTO_POKECENTER_1F, 1, 115
	warp_event  4,  5, KANTO_LEAGUE_1F, 1, 111
	warp_event  5,  5, KANTO_LEAGUE_1F, 2, 111
	warp_event 51, 11, KANTO_LAVENDER_HOUSE, 1, 242
	warp_event 14, 17, KANTO_CELADON_MART_1F, 1, 332
	warp_event 15, 17, KANTO_CELADON_MART_1F, 1, 332
	warp_event  3, 18, KANTO_MART, 1, 362
	warp_event 22, 19, KANTO_GAMEFREAK_HQ_1, 1, 372
	warp_event 23, 19, KANTO_GAMEFREAK_HQ_1, 2, 372
	warp_event 30, 19, KANTO_SILPH_CO, 1, 376
	warp_event 31, 19, KANTO_SILPH_CO, 2, 376
	warp_event 16, 23, KANTO_VIRIDIAN_HOUSE, 1, 441
	warp_event 29, 23, KANTO_GAME_CORNER, 1, 447
	warp_event 34, 23, KANTO_GAME_CORNER_PRIZES, 1, 450
	warp_event 40, 23, KANTO_DINER, 1, 453
	warp_event 52, 23, KANTO_SCHOOL, 1, 459
	warp_event 53, 23, KANTO_SCHOOL, 2, 459
	warp_event 38, 29, KANTO_HOSPITAL, 1, 560
	warp_event 49, 30, KANTO_POKECENTER_2_1F, 1, 601
	warp_event  5, 38, KANTO_REDS_HOUSE, 1, 723
	warp_event 13, 38, KANTO_GREENS_HOUSE_1F, 1, 727
	warp_event 39, 38, KANTO_ELDERS_HOUSE, 1, 740
	warp_event 12, 43, KANTO_OAKS_LAB, 1, 799
	warp_event 13, 43, KANTO_OAKS_LAB, 2, 799
	warp_event 52, 45, KANTO_LEAGUE_2_1F, 1, 855
	warp_event 53, 45, KANTO_LEAGUE_2_1F, 2, 855
	warp_event 45, 46, KANTO_FISHING_GURU, 1, 887
	warp_event  6, 27, ROUTE_SILENT_EAST_GATE, 3, 508
	warp_event 21, 13, KANTO_GAMEFREAK_HQ_1, 5, 263

	def_bg_events
	bg_event 14,  4, 0, 1
	bg_event 42,  4, 0, 2
	bg_event 54,  8, 0, 3
	bg_event  4, 18, 0, 4
	bg_event 18, 18, 0, 5
	bg_event 26, 19, 0, 6
	bg_event 46, 18, 0, 7
	bg_event  8, 38, 0, 8
	bg_event 16, 38, 0, 9
	bg_event  6, 41, 0, 10
	bg_event 12, 45, 0, 11
	bg_event 50, 30, 0, 12

	def_object_events

Kanto_Blocks::
INCBIN "maps/Kanto.blk"
