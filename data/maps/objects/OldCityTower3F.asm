INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityTower3F.asm", ROMX

	map_attributes OldCityTower3F, OLD_CITY_TOWER_3F, 0

OldCityTower3F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  1, OLD_CITY_TOWER_4F, 1, 11
	warp_event  7,  7, OLD_CITY_TOWER_2F, 2, 44

	def_bg_events
	bg_event  3,  0, 1
	bg_event  4,  1, 2

	def_object_events
	object_event  2,  3, SPRITE_SAGE, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  3,  4, SPRITE_SAGE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event  4,  4, SPRITE_SAGE, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event  5,  5, SPRITE_SAGE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0

OldCityTower3F_Blocks::
INCBIN "maps/OldCityTower3F.blk"
