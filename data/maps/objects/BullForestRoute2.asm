INCLUDE "constants.asm"

SECTION "data/maps/objects/BullForestRoute2.asm", ROMX

	map_attributes BullForestRoute2, BULL_FOREST_ROUTE_2, NORTH | SOUTH
	connection north, BullForest, BULL_FOREST, -5
	connection south, Stand, STAND, -10

BullForestRoute2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 48, BULL_FOREST_ROUTE_GATE_STAND, 3, 405
	warp_event  9, 48, BULL_FOREST_ROUTE_GATE_STAND, 4, 405

	def_bg_events

	def_object_events

BullForestRoute2_Blocks::
INCBIN "maps/BullForestRoute2.blk"
