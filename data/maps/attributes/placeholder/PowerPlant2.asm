INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/PowerPlant2.asm", ROMX
	map_attributes PowerPlant2, POWER_PLANT_2, 0

PowerPlant2_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PowerPlant2_Blocks:: INCBIN "maps/placeholder/blk/PowerPlant2.blk"
