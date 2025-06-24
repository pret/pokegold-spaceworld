INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityTower1F.asm", ROMX

	map_attributes OldCityTower1F, OLD_CITY_TOWER_1F, 0

OldCityTower1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, OLD_CITY, 5, 42
	warp_event  4,  7, OLD_CITY, 6, 43
	warp_event  0,  1, OLD_CITY_TOWER_2F, 1, 11

	def_bg_events
	bg_event  2,  6, 1
	bg_event  5,  6, 2
	bg_event  4,  1, 3

	def_object_events
	object_event  0,  2, SPRITE_SAGE, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event  1,  5, SPRITE_SAGE, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  5,  1, SPRITE_SAGE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  6,  4, SPRITE_SAGE, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

OldCityTower1F_Blocks::
INCBIN "maps/OldCityTower1F.blk"
