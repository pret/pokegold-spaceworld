INCLUDE "constants.asm"

SECTION "data/maps/objects/BirdonRoute3.asm", ROMX

	map_attributes BirdonRoute3, BIRDON_ROUTE_3, SOUTH | WEST
	connection south, Route15, ROUTE_15, 0
	connection west, BirdonRoute2, BIRDON_ROUTE_2, 0

BirdonRoute3_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, BIRDON_ROUTE_GATE_NEWTYPE, 3, 261
	warp_event  9, 30, BIRDON_ROUTE_GATE_NEWTYPE, 4, 261

	def_bg_events

	def_object_events

BirdonRoute3_Blocks::
INCBIN "maps/BirdonRoute3.blk"
