INCLUDE "constants.asm"

SECTION "data/maps/attributes/PowerPlant1.asm", ROMX
	map_attributes PowerPlant1, POWER_PLANT_1, 0

PowerPlant1_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PowerPlant1_Blocks:: INCBIN "maps/blk/PowerPlant1.blk"