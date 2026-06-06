INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueForestRoute1.asm", ROMX

	map_attributes BlueForestRoute1, BLUE_FOREST_ROUTE_1, SOUTH | EAST
	connection south, Route18, ROUTE_18, 0
	connection east, BlueForest, BLUE_FOREST, -9

BlueForestRoute1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 12, NEWTYPE_ROUTE_GATE, 3, 222
	warp_event  9, 12, NEWTYPE_ROUTE_GATE, 4, 222
	warp_event  9,  5, BLUE_FOREST_ROUTE_1_HOUSE, 1, 98

	def_bg_events

	def_object_events

BlueForestRoute1_Blocks::
INCBIN "maps/BlueForestRoute1.blk"
