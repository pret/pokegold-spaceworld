INCLUDE "constants.asm"

SECTION "data/maps/objects/PowerPlant3.asm", ROMX

	map_attributes PowerPlant3, POWER_PLANT_3, 0

PowerPlant3_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PowerPlant3_Blocks::
INCBIN "maps/PowerPlant3.blk"
