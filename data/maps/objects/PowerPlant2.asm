INCLUDE "constants.asm"

SECTION "data/maps/objects/PowerPlant2.asm", ROMX

	map_attributes PowerPlant2, POWER_PLANT_2, 0

PowerPlant2_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

PowerPlant2_Blocks::
INCBIN "maps/PowerPlant2.blk"
