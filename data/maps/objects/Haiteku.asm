INCLUDE "constants.asm"

SECTION "data/maps/objects/Haiteku.asm", ROMX

	map_attributes Haiteku, HAITEKU, WEST
	connection west, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 0, 0, 9

Haiteku_MapEvents::
	dw $4000 ; unknown

	db 9 ; warp events
	warp_event 31, 10, 1, HAITEKU_POKECENTER_1F, wOverworldMapBlocks + 172
	warp_event 10, 11, 1, HAITEKU_LEAGUE_1F, wOverworldMapBlocks + 162
	warp_event 11, 11, 2, HAITEKU_LEAGUE_1F, wOverworldMapBlocks + 162
	warp_event 31, 16, 1, HAITEKU_MART, wOverworldMapBlocks + 250
	warp_event 7, 17, 1, HAITEKU_HOUSE_1, wOverworldMapBlocks + 238
	warp_event 15, 17, 1, HAITEKU_HOUSE_2, wOverworldMapBlocks + 242
	warp_event 33, 20, 1, HAITEKU_IMPOSTER_OAK_HOUSE, wOverworldMapBlocks + 303
	warp_event 6, 27, 1, HAITEKU_AQUARIUM_1F, wOverworldMapBlocks + 368
	warp_event 7, 27, 2, HAITEKU_AQUARIUM_1F, wOverworldMapBlocks + 368

	db 8 ; bg events
	bg_event 24, 7, 0, 1
	bg_event 12, 12, 0, 2
	bg_event 32, 10, 0, 3
	bg_event 10, 17, 0, 4
	bg_event 32, 16, 0, 5
	bg_event 10, 27, 0, 6
	bg_event 30, 25, 0, 7
	bg_event 24, 28, 0, 8

	db 5 ; person events
	object_event 22, 15, SPRITE_TWIN, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 23, 14, SPRITE_PIPPI, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 23, 24, SPRITE_SAILOR, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 26, 10, SPRITE_SAILOR, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 14, SPRITE_GENTLEMAN, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

Haiteku_Blocks::
INCBIN "maps/Haiteku.blk"
