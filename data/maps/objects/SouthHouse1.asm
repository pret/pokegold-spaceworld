INCLUDE "constants.asm"

SECTION "data/maps/objects/SouthHouse1.asm", ROMX

	map_attributes SouthHouse1, SOUTH_HOUSE_1, 0

SouthHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, SOUTH, 1, 47
	warp_event  5,  7, SOUTH, 1, 47

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GRANNY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthHouse1_Blocks::
INCBIN "maps/SouthHouse1.blk"
