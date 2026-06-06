INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueForestRoute2.asm", ROMX

	map_attributes BlueForestRoute2, BLUE_FOREST_ROUTE_2, NORTH | SOUTH
	connection north, BlueForest, BLUE_FOREST, -5
	connection south, Stand, STAND, -10

BlueForestRoute2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 48, BLUE_FOREST_ROUTE_GATE_STAND, 3, 405
	warp_event  9, 48, BLUE_FOREST_ROUTE_GATE_STAND, 4, 405

	def_bg_events

	def_object_events

BlueForestRoute2_Blocks::
INCBIN "maps/BlueForestRoute2.blk"
