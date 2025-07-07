INCLUDE "constants.asm"

SECTION "data/maps/objects/Route2House.asm", ROMX

	map_attributes Route2House, ROUTE_2_HOUSE, 0

Route2House_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_2, 2, 43
	warp_event  5,  7, ROUTE_2, 2, 43

	def_bg_events
	bg_event  0,  0, 1
	bg_event  2,  0, 1
	bg_event  4,  0, 1
	bg_event  6,  0, 1
	bg_event  0,  3, 2
	bg_event  4,  3, 3

	def_object_events
	object_event  6,  6, SPRITE_SCIENTIST, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2House_Blocks::
INCBIN "maps/Route2House.blk"
