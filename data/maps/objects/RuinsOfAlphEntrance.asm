INCLUDE "constants.asm"

SECTION "data/maps/objects/RuinsOfAlphEntrance.asm", ROMX

	map_attributes RuinsOfAlphEntrance, RUINS_OF_ALPH_ENTRANCE, 0

RuinsOfAlphEntrance_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

RuinsOfAlphEntrance_Blocks::
INCBIN "maps/RuinsOfAlphEntrance.blk"
