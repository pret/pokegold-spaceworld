INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRoute4.asm", ROMX

	map_attributes FontoRoute4, FONTO_ROUTE_4, SOUTH | WEST
	connection south, Baadon, BAADON, 0
	connection west, FontoRoute3, FONTO_ROUTE_3, 0

FontoRoute4_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, FONTO_ROUTE_GATE_2, 3, 261
	warp_event  9, 30, FONTO_ROUTE_GATE_2, 4, 261

	def_bg_events

	def_object_events

FontoRoute4_Blocks::
INCBIN "maps/FontoRoute4.blk"
