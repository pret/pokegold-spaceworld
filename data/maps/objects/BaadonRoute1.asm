INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonRoute1.asm", ROMX

	map_attributes BaadonRoute1, BAADON_ROUTE_1, NORTH | SOUTH
	connection north, Baadon, BAADON, 0
	connection south, West, WEST, -5

BaadonRoute1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12, 48, BAADON_ROUTE_GATE_WEST, 3, 407
	warp_event 13, 48, BAADON_ROUTE_GATE_WEST, 4, 407

	def_bg_events

	def_object_events

BaadonRoute1_Blocks::
INCBIN "maps/BaadonRoute1.blk"
