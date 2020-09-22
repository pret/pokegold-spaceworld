INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRoute5.asm", ROMX

	map_attributes FontoRoute5, FONTO_ROUTE_5, SOUTH | EAST
	connection south, South, SOUTH, -10
	connection east, FontoRoute6, FONTO_ROUTE_6, 0

FontoRoute5_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, FONTO_ROUTE_GATE_3, 3, 261
	warp_event  9, 30, FONTO_ROUTE_GATE_3, 4, 261

	def_bg_events

	def_object_events

FontoRoute5_Blocks::
INCBIN "maps/FontoRoute5.blk"
