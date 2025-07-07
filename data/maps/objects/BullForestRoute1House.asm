INCLUDE "constants.asm"

SECTION "data/maps/objects/BullForestRoute1House.asm", ROMX

	map_attributes BullForestRoute1House, BULL_FOREST_ROUTE_1_HOUSE, 0

BullForestRoute1House_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BULL_FOREST_ROUTE_1, 3, 47
	warp_event  5,  7, BULL_FOREST_ROUTE_1, 3, 47

	def_bg_events

	def_object_events
	object_event  1,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullForestRoute1House_Blocks::
INCBIN "maps/BullForestRoute1House.blk"
