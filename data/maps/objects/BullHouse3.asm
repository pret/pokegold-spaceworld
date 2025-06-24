INCLUDE "constants.asm"

SECTION "data/maps/objects/BullHouse3.asm", ROMX

	map_attributes BullHouse3, BULL_HOUSE_3, 0

BullHouse3_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BULL_FOREST, 4, 47
	warp_event  5,  7, BULL_FOREST, 4, 47

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_GRAMPS, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse3_Blocks::
INCBIN "maps/BullHouse3.blk"
