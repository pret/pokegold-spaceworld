INCLUDE "constants.asm"

SECTION "data/maps/objects/PrinceRoute.asm", ROMX

	map_attributes PrinceRoute, PRINCE_ROUTE, NORTH | SOUTH
	connection north, Prince, PRINCE, 0
	connection south, SilentHill, SILENT_HILL, 0

PrinceRoute_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PrinceRoute_Blocks::
INCBIN "maps/PrinceRoute.blk"
