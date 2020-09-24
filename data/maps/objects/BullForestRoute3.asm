INCLUDE "constants.asm"

SECTION "data/maps/objects/BullForestRoute3.asm", ROMX

	map_attributes BullForestRoute3, BULL_FOREST_ROUTE_3, NORTH | SOUTH
	connection north, North, NORTH, 0
	connection south, BullForest, BULL_FOREST, -5

BullForestRoute3_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

BullForestRoute3_Blocks::
INCBIN "maps/BullForestRoute3.blk"
