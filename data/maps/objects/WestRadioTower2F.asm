INCLUDE "constants.asm"

SECTION "data/maps/objects/WestRadioTower2F.asm", ROMX

	map_attributes WestRadioTower2F, WEST_RADIO_TOWER_2F, 0

WestRadioTower2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  0, WEST_RADIO_TOWER_3F, 1, 11
	warp_event  7,  0, WEST_RADIO_TOWER_1F, 3, 14

	def_bg_events
	bg_event  5,  0, 1

	def_object_events
	object_event  4,  6, SPRITE_GYM_GUY, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  5, SPRITE_ROCKER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_SUPER_NERD, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  2, SPRITE_GIRL, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_36, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  6, SPRITE_36, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  7, SPRITE_36, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower2F_Blocks::
INCBIN "maps/WestRadioTower2F.blk"
