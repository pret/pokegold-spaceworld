INCLUDE "constants.asm"

SECTION "data/maps/objects/CaveMinecarts4.asm", ROMX

	map_attributes CaveMinecarts4, CAVE_MINECARTS_4, 0

CaveMinecarts4_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

CaveMinecarts4_Blocks::
INCBIN "maps/CaveMinecarts4.blk"
