INCLUDE "constants.asm"

SECTION "data/maps/attributes/Office1.asm", ROMX
	map_attributes Office1, OFFICE_1, 0

Office1_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

Office1_Blocks:: INCBIN "maps/blk/Office1.blk"