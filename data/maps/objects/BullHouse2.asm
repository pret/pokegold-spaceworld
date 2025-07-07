INCLUDE "constants.asm"

SECTION "data/maps/objects/BullHouse2.asm", ROMX

	map_attributes BullHouse2, BULL_HOUSE_2, 0

BullHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BULL_FOREST, 3, 47
	warp_event  5,  7, BULL_FOREST, 3, 47

	def_bg_events

	def_object_events
	object_event  8,  4, SPRITE_GRANNY, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse2_Blocks::
INCBIN "maps/BullHouse2.blk"
