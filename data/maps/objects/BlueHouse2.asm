INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueHouse2.asm", ROMX

	map_attributes BlueHouse2, BLUE_HOUSE_2, 0

BlueHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BLUE_FOREST, 3, 47
	warp_event  5,  7, BLUE_FOREST, 3, 47

	def_bg_events

	def_object_events
	object_event  8,  4, SPRITE_GRANNY, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

BlueHouse2_Blocks::
INCBIN "maps/BlueHouse2.blk"
