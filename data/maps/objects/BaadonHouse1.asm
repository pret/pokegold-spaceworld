INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonHouse1.asm", ROMX

	map_attributes BaadonHouse1, BAADON_HOUSE_1, 0

BaadonHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, BAADON, 3, 42
	warp_event  4,  7, BAADON, 3, 43

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_ELDER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonHouse1_Blocks::
INCBIN "maps/BaadonHouse1.blk"
