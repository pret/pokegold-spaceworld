INCLUDE "constants.asm"

SECTION "data/maps/objects/CaveMinecarts3.asm", ROMX

	map_attributes CaveMinecarts3, CAVE_MINECARTS_3, 0

CaveMinecarts3_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

CaveMinecarts3_Blocks::
INCBIN "maps/CaveMinecarts3.blk"
