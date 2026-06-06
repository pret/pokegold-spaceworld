INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueForestRoute1House.asm", ROMX

	map_attributes BlueForestRoute1House, BLUE_FOREST_ROUTE_1_HOUSE, 0

BlueForestRoute1House_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BLUE_FOREST_ROUTE_1, 3, 47
	warp_event  5,  7, BLUE_FOREST_ROUTE_1, 3, 47

	def_bg_events

	def_object_events
	object_event  1,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

BlueForestRoute1House_Blocks::
INCBIN "maps/BlueForestRoute1House.blk"
