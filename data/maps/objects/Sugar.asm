INCLUDE "constants.asm"

SECTION "data/maps/objects/Sugar.asm", ROMX

	map_attributes Sugar, SUGAR, SOUTH
	connection south, SugarRoute, SUGAR_ROUTE, 0

Sugar_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  5, SUGAR_HOUSE, 1, 51
	warp_event 15,  9, SUGAR_HOUSE_2, 1, 88
	warp_event  5, 10, SUGAR_MART, 1, 99
	warp_event  9, 10, SUGAR_POKECENTER_1F, 1, 101

	def_bg_events
	bg_event 14,  6, 1
	bg_event  6, 10, 2
	bg_event 10, 10, 3
	bg_event 10, 14, 4

	def_object_events
	object_event  8, 12, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  6, SPRITE_GRANNY, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 11, SPRITE_GRAMPS, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Sugar_Blocks::
INCBIN "maps/Sugar.blk"
