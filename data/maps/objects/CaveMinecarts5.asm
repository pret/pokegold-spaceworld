INCLUDE "constants.asm"

SECTION "data/maps/objects/CaveMinecarts5.asm", ROMX

	map_attributes CaveMinecarts5, CAVE_MINECARTS_5, 0

CaveMinecarts5_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

CaveMinecarts5_Blocks::
INCBIN "maps/CaveMinecarts5.blk"
