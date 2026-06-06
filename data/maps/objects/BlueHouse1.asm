INCLUDE "constants.asm"

SECTION "data/maps/objects/BlueHouse1.asm", ROMX

	map_attributes BlueHouse1, BLUE_HOUSE_1, 0

BlueHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, BLUE_FOREST, 2, 42
	warp_event  4,  7, BLUE_FOREST, 2, 43

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_KIKUKO, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BlueHouse1_Blocks::
INCBIN "maps/BlueHouse1.blk"
