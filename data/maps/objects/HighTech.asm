INCLUDE "constants.asm"

SECTION "data/maps/objects/HighTech.asm", ROMX

	map_attributes HighTech, HIGHTECH, WEST
	connection west, HighTechWestRoute, HIGHTECH_WEST_ROUTE, 0

HighTech_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 31, 10, HIGHTECH_POKECENTER_1F, 1, 172
	warp_event 10, 11, HIGHTECH_LEAGUE_1F, 1, 162
	warp_event 11, 11, HIGHTECH_LEAGUE_1F, 2, 162
	warp_event 31, 16, HIGHTECH_MART, 1, 250
	warp_event  7, 17, HIGHTECH_HOUSE_1, 1, 238
	warp_event 15, 17, HIGHTECH_HOUSE_2, 1, 242
	warp_event 33, 20, HIGHTECH_IMPOSTER_OAK_HOUSE, 1, 303
	warp_event  6, 27, HIGHTECH_AQUARIUM_1F, 1, 368
	warp_event  7, 27, HIGHTECH_AQUARIUM_1F, 2, 368

	def_bg_events
	bg_event 24,  7, 1
	bg_event 12, 12, 2
	bg_event 32, 10, 3
	bg_event 10, 17, 4
	bg_event 32, 16, 5
	bg_event 10, 27, 6
	bg_event 30, 25, 7
	bg_event 24, 28, 8

	def_object_events
	object_event 22, 15, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 23, 14, SPRITE_CLEFAIRY, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 23, 24, SPRITE_SAILOR, SPRITEMOVEFN_RANDOM_WALK_XY, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 26, 10, SPRITE_SAILOR, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 14, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

HighTech_Blocks::
INCBIN "maps/HighTech.blk"
