INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRoute2.asm", ROMX

	map_attributes FontoRoute2, FONTO_ROUTE_2, SOUTH | WEST
	connection south, Fonto, FONTO, 0
	connection west, FontoRoute6, FONTO_ROUTE_6, 0

FontoRoute2_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

FontoRoute2_Blocks::
INCBIN "maps/FontoRoute2.blk"
