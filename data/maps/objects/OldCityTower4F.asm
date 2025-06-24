INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityTower4F.asm", ROMX

	map_attributes OldCityTower4F, OLD_CITY_TOWER_4F, 0

OldCityTower4F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  1, OLD_CITY_TOWER_3F, 1, 11
	warp_event  7,  7, OLD_CITY_TOWER_5F, 1, 44

	def_bg_events
	bg_event  3,  0, 1
	bg_event  4,  1, 2

	def_object_events
	object_event  3,  2, SPRITE_SAGE, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event  4,  7, SPRITE_SAGE, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event  6,  7, SPRITE_SAGE, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event  7,  1, SPRITE_SAGE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

OldCityTower4F_Blocks::
INCBIN "maps/OldCityTower4F.blk"
