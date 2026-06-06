INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRoute4.asm", ROMX

	map_attributes FontRoute4, FONT_ROUTE_4, SOUTH | WEST
	connection south, Birdon, BIRDON, 0
	connection west, FontRoute3, FONT_ROUTE_3, 0

FontRoute4_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, FONT_ROUTE_GATE_2, 3, 261
	warp_event  9, 30, FONT_ROUTE_GATE_2, 4, 261

	def_bg_events

	def_object_events

FontRoute4_Blocks::
INCBIN "maps/FontRoute4.blk"
