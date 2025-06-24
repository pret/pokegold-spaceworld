INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonHouse2.asm", ROMX

	map_attributes BaadonHouse2, BAADON_HOUSE_2, 0

BaadonHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BAADON, 5, 47
	warp_event  5,  7, BAADON, 5, 47

	def_bg_events

	def_object_events
	object_event  7,  5, SPRITE_GRANNY, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonHouse2_Blocks::
INCBIN "maps/BaadonHouse2.blk"
