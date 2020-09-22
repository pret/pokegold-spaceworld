INCLUDE "constants.asm"

SECTION "data/maps/objects/BullHouse4.asm", ROMX

	map_attributes BullHouse4, BULL_HOUSE_4, 0

BullHouse4_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BULL_FOREST, 8, 47
	warp_event  5,  7, BULL_FOREST, 8, 47

	def_bg_events

	def_object_events

BullHouse4_Blocks::
INCBIN "maps/BullHouse4.blk"
