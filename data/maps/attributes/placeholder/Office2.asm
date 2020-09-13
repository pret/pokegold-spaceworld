INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Office2.asm", ROMX
	map_attributes Office2, OFFICE_2, 0

Office2_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

Office2_Blocks:: INCBIN "maps/placeholder/blk/Office2.blk"
