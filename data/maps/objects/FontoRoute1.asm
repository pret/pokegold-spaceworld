INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRoute1.asm", ROMX

	map_attributes FontoRoute1, FONTO_ROUTE_1, WEST | EAST
	connection west, South, SOUTH, 0
	connection east, Fonto, FONTO, 0

FontoRoute1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6,  9, FONTO_ROUTE_GATE_1, 3, 209

	def_bg_events

	def_object_events

FontoRoute1_Blocks::
INCBIN "maps/FontoRoute1.blk"
