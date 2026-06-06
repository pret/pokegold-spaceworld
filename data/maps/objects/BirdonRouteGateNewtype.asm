INCLUDE "constants.asm"

SECTION "data/maps/objects/BirdonRouteGateNewtype.asm", ROMX

	map_attributes BirdonRouteGateNewtype, BIRDON_ROUTE_GATE_NEWTYPE, 0

BirdonRouteGateNewtype_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_15, 1, 47
	warp_event  5,  7, ROUTE_15, 2, 47
	warp_event  4,  0, BIRDON_ROUTE_3, 1, 14
	warp_event  5,  0, BIRDON_ROUTE_3, 2, 14

	def_bg_events

	def_object_events

BirdonRouteGateNewtype_Blocks::
INCBIN "maps/BirdonRouteGateNewtype.blk"
