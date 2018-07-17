INCLUDE "constants.asm"

SECTION "data/maps/attributes/Office3.asm", ROMX
	map_attributes Office3, OFFICE_3, 0

Office3_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

Office3_Blocks:: INCBIN "maps/blk/Office3.blk"
