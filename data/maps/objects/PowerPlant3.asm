INCLUDE "constants.asm"

SECTION "data/maps/objects/PowerPlant3.asm", ROMX

	map_attributes PowerPlant3, POWER_PLANT_3, 0

PowerPlant3_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

PowerPlant3_Blocks::
INCBIN "maps/PowerPlant3.blk"
