INCLUDE "constants.asm"

SECTION "data/maps/objects/PowerPlant1.asm", ROMX

	map_attributes PowerPlant1, POWER_PLANT_1, 0

PowerPlant1_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

PowerPlant1_Blocks::
INCBIN "maps/PowerPlant1.blk"
