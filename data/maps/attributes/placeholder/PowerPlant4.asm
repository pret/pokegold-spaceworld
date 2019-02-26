INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/PowerPlant4.asm", ROMX
	map_attributes PowerPlant4, POWER_PLANT_4, 0

PowerPlant4_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PowerPlant4_Blocks:: INCBIN "maps/placeholder/blk/PowerPlant4.blk"