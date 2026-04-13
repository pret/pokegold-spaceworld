INCLUDE "constants.asm"

SECTION "data/maps/objects/BirdonRoute1.asm", ROMX

	map_attributes BirdonRoute1, BIRDON_ROUTE_1, NORTH | SOUTH
	connection north, Birdon, BIRDON, 0
	connection south, West, WEST, -5

BirdonRoute1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12, 48, BIRDON_ROUTE_GATE_WEST, 3, 407
	warp_event 13, 48, BIRDON_ROUTE_GATE_WEST, 4, 407

	def_bg_events

	def_object_events

BirdonRoute1_Blocks::
INCBIN "maps/BirdonRoute1.blk"
