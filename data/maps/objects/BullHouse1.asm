INCLUDE "constants.asm"

SECTION "data/maps/objects/BullHouse1.asm", ROMX

	map_attributes BullHouse1, BULL_HOUSE_1, 0

BullHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, BULL_FOREST, 2, 42
	warp_event  4,  7, BULL_FOREST, 2, 43

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_KIKUKO, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse1_Blocks::
INCBIN "maps/BullHouse1.blk"
