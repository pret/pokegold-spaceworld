INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueForestRoute3.asm", ROMX

	map_attributes BlueForestRoute3, BLUE_FOREST_ROUTE_3, NORTH | SOUTH
	connection north, North, NORTH, 0
	connection south, BlueForest, BLUE_FOREST, -5

BlueForestRoute3_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

BlueForestRoute3_Blocks::
INCBIN "maps/BlueForestRoute3.blk"
