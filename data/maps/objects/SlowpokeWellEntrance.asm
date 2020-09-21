INCLUDE "constants.asm"

SECTION "data/maps/objects/SlowpokeWellEntrance.asm", ROMX

	map_attributes SlowpokeWellEntrance, SLOWPOKE_WELL_ENTRANCE, 0

SlowpokeWellEntrance_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

SlowpokeWellEntrance_Blocks::
INCBIN "maps/SlowpokeWellEntrance.blk"
