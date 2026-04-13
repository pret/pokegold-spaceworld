INCLUDE "constants.asm"

SECTION "data/maps/objects/BirdonHouse2.asm", ROMX

	map_attributes BirdonHouse2, BIRDON_HOUSE_2, 0

BirdonHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BIRDON, 5, 47
	warp_event  5,  7, BIRDON, 5, 47

	def_bg_events

	def_object_events
	object_event  7,  5, SPRITE_GRANNY, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BirdonHouse2_Blocks::
INCBIN "maps/BirdonHouse2.blk"
