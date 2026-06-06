INCLUDE "constants.asm"

SECTION "data/maps/objects/BirdonRoute2.asm", ROMX

	map_attributes BirdonRoute2, BIRDON_ROUTE_2, WEST | EAST
	connection west, Birdon, BIRDON, 0
	connection east, BirdonRoute3, BIRDON_ROUTE_3, 0

BirdonRoute2_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

BirdonRoute2_Blocks::
INCBIN "maps/BirdonRoute2.blk"
