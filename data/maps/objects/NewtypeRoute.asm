INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeRoute.asm", ROMX

	map_attributes NewtypeRoute, NEWTYPE_ROUTE, WEST | EAST
	connection west, Newtype, NEWTYPE, -9
	connection east, Route18, ROUTE_18, -36

NewtypeRoute_MapEvents::
	dw $4000 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

NewtypeRoute_Blocks::
INCBIN "maps/NewtypeRoute.blk"
