INCLUDE "constants.asm"

SECTION "data/maps/objects/CaveMinecarts2.asm", ROMX

	map_attributes CaveMinecarts2, CAVE_MINECARTS_2, 0

CaveMinecarts2_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

CaveMinecarts2_Blocks::
INCBIN "maps/CaveMinecarts2.blk"
