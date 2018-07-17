INCLUDE "constants.asm"

SECTION "data/maps/attributes/Newtype.asm", ROMX
	map_attributes Newtype, NEWTYPE, NORTH | WEST | EAST
	connection north, SugarRoute, SUGAR_ROUTE, 5, 0, 10
	connection west, Route15, ROUTE_15, 0, 0, 9
	connection east, NewtypeRoute, NEWTYPE_ROUTE, 9, 0, 9

Newtype_MapEvents::
	dw $4000 ; unknown

	db 13 ; warp events
	warp_event 7, 8, 1, NEWTYPE_POKECENTER_1F, wOverworldMapBlocks + 134
	warp_event 30, 9, 1, NEWTYPE_LEAGUE_1F, wOverworldMapBlocks + 146
	warp_event 31, 9, 2, NEWTYPE_LEAGUE_1F, wOverworldMapBlocks + 146
	warp_event 23, 13, 1, NEWTYPE_SAILOR_HOUSE, wOverworldMapBlocks + 194
	warp_event 7, 14, 1, NEWTYPE_MART, wOverworldMapBlocks + 212
	warp_event 33, 15, 1, NEWTYPE_DOJO, wOverworldMapBlocks + 225
	warp_event 34, 15, 2, NEWTYPE_DOJO, wOverworldMapBlocks + 226
	warp_event 23, 22, 1, NEWTYPE_HOUSE_1, wOverworldMapBlocks + 324
	warp_event 5, 23, 1, NEWTYPE_DINER, wOverworldMapBlocks + 315
	warp_event 11, 28, 1, NEWTYPE_HOUSE_2, wOverworldMapBlocks + 396
	warp_event 35, 30, 1, NEWTYPE_HOUSE_3, wOverworldMapBlocks + 434
	warp_event 18, 5, 1, SUGAR_ROUTE_GATE, wOverworldMapBlocks + 88
	warp_event 19, 5, 2, SUGAR_ROUTE_GATE, wOverworldMapBlocks + 88

	db 5 ; bg events
	bg_event 0, 8, 0, 1
	bg_event 8, 8, 0, 2
	bg_event 8, 14, 0, 3
	bg_event 30, 15, 0, 4
	bg_event 30, 21, 0, 5

	db 4 ; person events
	object_event 5, 10, SPRITE_SILVER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24, 26, SPRITE_FISHER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24, 9, SPRITE_ROCKER, FACE_UP, 2, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 30, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

Newtype_Blocks:: INCBIN "maps/blk/Newtype.blk"
