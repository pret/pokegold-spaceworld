INCLUDE "constants.asm"

SECTION "data/maps/objects/SouthHouse2.asm", ROMX

	map_attributes SouthHouse2, SOUTH_HOUSE_2, 0

SouthHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, SOUTH, 4, 47
	warp_event  5,  7, SOUTH, 4, 47

	def_bg_events

	def_object_events
	object_event  1,  2, SPRITE_FISHER, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthHouse2_Blocks::
INCBIN "maps/SouthHouse2.blk"
