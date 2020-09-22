INCLUDE "constants.asm"

SECTION "data/maps/objects/CaveMinecarts1.asm", ROMX

	map_attributes CaveMinecarts1, CAVE_MINECARTS_1, 0

CaveMinecarts1_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

CaveMinecarts1_Blocks::
INCBIN "maps/CaveMinecarts1.blk"
