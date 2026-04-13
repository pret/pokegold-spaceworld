INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueHouse3.asm", ROMX

	map_attributes BlueHouse3, BLUE_HOUSE_3, 0

BlueHouse3_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, BLUE_FOREST, 4, 47
	warp_event  5,  7, BLUE_FOREST, 4, 47

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_GRAMPS, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BlueHouse3_Blocks::
INCBIN "maps/BlueHouse3.blk"
