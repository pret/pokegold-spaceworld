INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/KantoUnusedArea.asm", ROMX
	map_attributes KantoUnusedArea, KANTO_UNUSED_AREA, 0

KantoUnusedArea_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

KantoUnusedArea_Blocks:: INCBIN "maps/placeholder/blk/KantoUnusedArea.blk"