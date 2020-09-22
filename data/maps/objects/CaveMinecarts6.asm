INCLUDE "constants.asm"

SECTION "data/maps/objects/CaveMinecarts6.asm", ROMX

	map_attributes CaveMinecarts6, CAVE_MINECARTS_6, 0

CaveMinecarts6_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

CaveMinecarts6_Blocks::
INCBIN "maps/CaveMinecarts6.blk"
