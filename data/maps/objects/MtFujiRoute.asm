INCLUDE "constants.asm"

SECTION "data/maps/objects/MtFujiRoute.asm", ROMX

	map_attributes MtFujiRoute, MT_FUJI_ROUTE, NORTH | SOUTH
	connection north, MtFuji, MT_FUJI, 0
	connection south, Prince, PRINCE, 0

MtFujiRoute_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

MtFujiRoute_Blocks::
INCBIN "maps/MtFujiRoute.blk"
