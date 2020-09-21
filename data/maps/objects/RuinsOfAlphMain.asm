INCLUDE "constants.asm"

SECTION "data/maps/objects/RuinsOfAlphMain.asm", ROMX

	map_attributes RuinsOfAlphMain, RUINS_OF_ALPH_MAIN, 0

RuinsOfAlphMain_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

RuinsOfAlphMain_Blocks::
INCBIN "maps/RuinsOfAlphMain.blk"
