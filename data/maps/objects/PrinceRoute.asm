INCLUDE "constants.asm"

SECTION "data/maps/objects/PrinceRoute.asm", ROMX

	map_attributes PrinceRoute, PRINCE_ROUTE, NORTH | SOUTH
	connection north, Prince, PRINCE, 0
	connection south, SilentHill, SILENT_HILL, 0

PrinceRoute_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

PrinceRoute_Blocks::
INCBIN "maps/PrinceRoute.blk"
