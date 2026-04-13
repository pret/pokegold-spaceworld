INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRoute2.asm", ROMX

	map_attributes FontRoute2, FONT_ROUTE_2, SOUTH | WEST
	connection south, Font, FONT, 0
	connection west, FontRoute6, FONT_ROUTE_6, 0

FontRoute2_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

FontRoute2_Blocks::
INCBIN "maps/FontRoute2.blk"
