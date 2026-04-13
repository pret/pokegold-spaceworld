INCLUDE "constants.asm"

SECTION "data/maps/objects/BirdonHouse1.asm", ROMX

	map_attributes BirdonHouse1, BIRDON_HOUSE_1, 0

BirdonHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, BIRDON, 3, 42
	warp_event  4,  7, BIRDON, 3, 43

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_ELDER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BirdonHouse1_Blocks::
INCBIN "maps/BirdonHouse1.blk"
