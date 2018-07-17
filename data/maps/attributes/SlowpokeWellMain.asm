INCLUDE "constants.asm"

SECTION "data/maps/attributes/SlowpokeWellMain.asm", ROMX
	map_attributes SlowpokeWellMain, SLOWPOKE_WELL_MAIN, 0

SlowpokeWellMain_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

SlowpokeWellMain_Blocks:: INCBIN "maps/blk/SlowpokeWellMain.blk"