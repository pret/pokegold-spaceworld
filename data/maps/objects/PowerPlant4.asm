INCLUDE "constants.asm"

SECTION "data/maps/objects/PowerPlant4.asm", ROMX

	map_attributes PowerPlant4, POWER_PLANT_4, 0

PowerPlant4_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

PowerPlant4_Blocks::
INCBIN "maps/PowerPlant4.blk"
