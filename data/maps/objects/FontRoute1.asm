INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRoute1.asm", ROMX

	map_attributes FontRoute1, FONT_ROUTE_1, WEST | EAST
	connection west, South, SOUTH, 0
	connection east, Font, FONT, 0

FontRoute1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6,  9, FONT_ROUTE_GATE_1, 3, 209

	def_bg_events

	def_object_events

FontRoute1_Blocks::
INCBIN "maps/FontRoute1.blk"
