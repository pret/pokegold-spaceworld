INCLUDE "constants.asm"

SECTION "data/maps/objects/BullForestRoute3.asm", ROMX

	map_attributes BullForestRoute3, BULL_FOREST_ROUTE_3, NORTH | SOUTH
	connection north, North, NORTH, 0
	connection south, BullForest, BULL_FOREST, -5

BullForestRoute3_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

BullForestRoute3_Blocks::
INCBIN "maps/BullForestRoute3.blk"
