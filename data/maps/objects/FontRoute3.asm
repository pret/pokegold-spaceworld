INCLUDE "constants.asm"

SECTION "data/maps/objects/FontRoute3.asm", ROMX

	map_attributes FontRoute3, FONT_ROUTE_3, WEST | EAST
	connection west, Font, FONT, 0
	connection east, FontRoute4, FONT_ROUTE_4, 0

FontRoute3_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

FontRoute3_Blocks::
INCBIN "maps/FontRoute3.blk"
