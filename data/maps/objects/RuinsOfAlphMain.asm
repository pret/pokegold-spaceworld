INCLUDE "constants.asm"

SECTION "data/maps/objects/RuinsOfAlphMain.asm", ROMX

	map_attributes RuinsOfAlphMain, RUINS_OF_ALPH_MAIN, 0

RuinsOfAlphMain_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

RuinsOfAlphMain_Blocks::
INCBIN "maps/RuinsOfAlphMain.blk"
