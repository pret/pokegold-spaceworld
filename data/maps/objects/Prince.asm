INCLUDE "constants.asm"

SECTION "data/maps/objects/Prince.asm", ROMX

	map_attributes Prince, PRINCE, NORTH | SOUTH
	connection north, MtFujiRoute, MT_FUJI_ROUTE, 0
	connection south, PrinceRoute, PRINCE_ROUTE, 0

Prince_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Prince_Blocks::
INCBIN "maps/Prince.blk"
