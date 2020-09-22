INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRoute3.asm", ROMX

	map_attributes FontoRoute3, FONTO_ROUTE_3, WEST | EAST
	connection west, Fonto, FONTO, 0
	connection east, FontoRoute4, FONTO_ROUTE_4, 0

FontoRoute3_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

FontoRoute3_Blocks::
INCBIN "maps/FontoRoute3.blk"
