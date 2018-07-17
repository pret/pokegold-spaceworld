INCLUDE "constants.asm"

SECTION "data/maps/attributes/RuinsOfAlphEntrance.asm", ROMX
	map_attributes RuinsOfAlphEntrance, RUINS_OF_ALPH_ENTRANCE, 0

RuinsOfAlphEntrance_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

RuinsOfAlphEntrance_Blocks:: INCBIN "maps/blk/RuinsOfAlphEntrance.blk"