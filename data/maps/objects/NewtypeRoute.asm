INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeRoute.asm", ROMX

	map_attributes NewtypeRoute, NEWTYPE_ROUTE, WEST | EAST
	connection west, Newtype, NEWTYPE, -9
	connection east, Route18, ROUTE_18, -36

NewtypeRoute_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

NewtypeRoute_Blocks::
INCBIN "maps/NewtypeRoute.blk"
