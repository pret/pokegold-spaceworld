INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityTower2F.asm", ROMX

	map_attributes OldCityTower2F, OLD_CITY_TOWER_2F, 0

OldCityTower2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  1, OLD_CITY_TOWER_1F, 3, 11
	warp_event  7,  7, OLD_CITY_TOWER_3F, 2, 44

	def_bg_events
	bg_event  3,  0, 1
	bg_event  4,  1, 2

	def_object_events
	object_event  2,  3, SPRITE_MEDIUM, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  5,  3, SPRITE_MEDIUM, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  2,  6, SPRITE_MEDIUM, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  5,  6, SPRITE_MEDIUM, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0

OldCityTower2F_Blocks::
INCBIN "maps/OldCityTower2F.blk"
