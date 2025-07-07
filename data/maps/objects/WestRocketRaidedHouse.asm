INCLUDE "constants.asm"

SECTION "data/maps/objects/WestRocketRaidedHouse.asm", ROMX

	map_attributes WestRocketRaidedHouse, WEST_ROCKET_RAIDED_HOUSE, 0

WestRocketRaidedHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, WEST, 5, 47
	warp_event  5,  7, WEST, 5, 47

	def_bg_events
	bg_event  0,  1, 1
	bg_event  1,  1, 2
	bg_event  2,  1, 3
	bg_event  4,  1, 4
	bg_event  5,  1, 4
	bg_event  7,  1, 5
	bg_event  8,  0, 6

	def_object_events
	object_event  8,  1, SPRITE_36, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  5, SPRITE_36, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  4, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  3, SPRITE_POKEFAN_F, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  2, SPRITE_POKE_BALL, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRocketRaidedHouse_Blocks::
INCBIN "maps/WestRocketRaidedHouse.blk"
