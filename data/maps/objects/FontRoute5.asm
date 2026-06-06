INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRoute5.asm", ROMX

	map_attributes FontRoute5, FONT_ROUTE_5, SOUTH | EAST
	connection south, South, SOUTH, -10
	connection east, FontRoute6, FONT_ROUTE_6, 0

FontRoute5_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, FONT_ROUTE_GATE_3, 3, 261
	warp_event  9, 30, FONT_ROUTE_GATE_3, 4, 261

	def_bg_events

	def_object_events

FontRoute5_Blocks::
INCBIN "maps/FontRoute5.blk"
