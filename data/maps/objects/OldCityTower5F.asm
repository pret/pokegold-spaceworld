INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityTower5F.asm", ROMX

	map_attributes OldCityTower5F, OLD_CITY_TOWER_5F, 0

OldCityTower5F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  5, OLD_CITY_TOWER_4F, 2, 30

	def_bg_events
	bg_event  2,  0, 1
	bg_event  3,  0, 2
	bg_event  4,  1, 3

	def_object_events
	object_event  2,  3, SPRITE_SAGE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityTower5F_Blocks::
INCBIN "maps/OldCityTower5F.blk"
