INCLUDE "constants.asm"

SECTION "data/maps/objects/Newtype.asm", ROMX

	map_attributes Newtype, NEWTYPE, NORTH | WEST | EAST
	connection north, SugarRoute, SUGAR_ROUTE, 5
	connection west, Route15, ROUTE_15, 0
	connection east, NewtypeRoute, NEWTYPE_ROUTE, 9

Newtype_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7,  8, NEWTYPE_POKECENTER_1F, 1, 134
	warp_event 30,  9, NEWTYPE_LEAGUE_1F, 1, 146
	warp_event 31,  9, NEWTYPE_LEAGUE_1F, 2, 146
	warp_event 23, 13, NEWTYPE_SAILOR_HOUSE, 1, 194
	warp_event  7, 14, NEWTYPE_MART, 1, 212
	warp_event 33, 15, NEWTYPE_DOJO, 1, 225
	warp_event 34, 15, NEWTYPE_DOJO, 2, 226
	warp_event 23, 22, NEWTYPE_HOUSE_1, 1, 324
	warp_event  5, 23, NEWTYPE_DINER, 1, 315
	warp_event 11, 28, NEWTYPE_HOUSE_2, 1, 396
	warp_event 35, 30, NEWTYPE_HOUSE_3, 1, 434
	warp_event 18,  5, SUGAR_ROUTE_GATE, 1, 88
	warp_event 19,  5, SUGAR_ROUTE_GATE, 2, 88

	def_bg_events
	bg_event  0,  8, 1
	bg_event  8,  8, 2
	bg_event  8, 14, 3
	bg_event 30, 15, 4
	bg_event 30, 21, 5

	def_object_events
	object_event  5, 10, SPRITE_SILVER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24, 26, SPRITE_FISHER, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24,  9, SPRITE_ROCKER, SPRITEMOVEFN_RANDOM_WALK_XY, 2, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6, 30, SPRITE_GIRL, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

Newtype_Blocks::
INCBIN "maps/Newtype.blk"
