INCLUDE "constants.asm"

SECTION "data/maps/objects/Route15.asm", ROMX

	map_attributes Route15, ROUTE_15, NORTH | EAST
	connection north, BaadonRoute3, BAADON_ROUTE_3, 0
	connection east, Newtype, NEWTYPE, 0

Route15_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8,  5, BAADON_ROUTE_GATE_NEWTYPE, 1, 68
	warp_event  9,  5, BAADON_ROUTE_GATE_NEWTYPE, 2, 68
	warp_event  9, 10, ROUTE_15_POKECENTER_1F, 1, 131
	warp_event 14, 12, ROUTE_15, 6, 155
	warp_event 14, 13, ROUTE_15, 7, 155
	warp_event 21,  8, ROUTE_15, 4, 116
	warp_event 21,  9, ROUTE_15, 5, 116

	def_bg_events

	def_object_events

Route15_Blocks::
INCBIN "maps/Route15.blk"
