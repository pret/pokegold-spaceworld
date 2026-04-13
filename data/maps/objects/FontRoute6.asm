INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRoute6.asm", ROMX

	map_attributes FontRoute6, FONT_ROUTE_6, WEST | EAST
	connection west, FontRoute5, FONT_ROUTE_5, 0
	connection east, FontRoute2, FONT_ROUTE_2, 0

FontRoute6_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

FontRoute6_Blocks::
INCBIN "maps/FontRoute6.blk"
