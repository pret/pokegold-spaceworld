INCLUDE "constants.asm"

SECTION "data/maps/objects/MtFuji.asm", ROMX

	map_attributes MtFuji, MT_FUJI, SOUTH
	connection south, MtFujiRoute, MT_FUJI_ROUTE, 0

MtFuji_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

MtFuji_Blocks::
INCBIN "maps/MtFuji.blk"
