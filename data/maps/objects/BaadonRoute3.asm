INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonRoute3.asm", ROMX

	map_attributes BaadonRoute3, BAADON_ROUTE_3, SOUTH | WEST
	connection south, Route15, ROUTE_15, 0
	connection west, BaadonRoute2, BAADON_ROUTE_2, 0

BaadonRoute3_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8, 30, BAADON_ROUTE_GATE_NEWTYPE, 3, 261
	warp_event  9, 30, BAADON_ROUTE_GATE_NEWTYPE, 4, 261

	def_bg_events

	def_object_events

BaadonRoute3_Blocks::
INCBIN "maps/BaadonRoute3.blk"
