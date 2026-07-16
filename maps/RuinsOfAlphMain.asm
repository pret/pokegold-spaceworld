	map_attributes RuinsOfAlphMain, RUINS_OF_ALPH_MAIN

RuinsOfAlphMain_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

RuinsOfAlphMain_Blocks::
INCBIN "maps/RuinsOfAlphMain.blk"

	map_dummy_text_pointers_old
