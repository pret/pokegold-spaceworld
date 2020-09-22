INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonRoute2.asm", ROMX

	map_attributes BaadonRoute2, BAADON_ROUTE_2, WEST | EAST
	connection west, Baadon, BAADON, 0
	connection east, BaadonRoute3, BAADON_ROUTE_3, 0

BaadonRoute2_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

BaadonRoute2_Blocks::
INCBIN "maps/BaadonRoute2.blk"
