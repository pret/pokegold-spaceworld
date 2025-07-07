INCLUDE "constants.asm"

SECTION "data/maps/objects/WestRadioTower3F.asm", ROMX

	map_attributes WestRadioTower3F, WEST_RADIO_TOWER_3F, 0

WestRadioTower3F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  0, WEST_RADIO_TOWER_2F, 1, 11
	warp_event  7,  0, WEST_RADIO_TOWER_4F, 2, 14

	def_bg_events
	bg_event  5,  0, 1

	def_object_events
	object_event  4,  6, SPRITE_SUPER_NERD, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  6, SPRITE_ROCKER, SPRITEMOVEFN_RANDOM_WALK_XY, 2, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  1, SPRITE_TEACHER, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  5, SPRITE_GIRL, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  2, SPRITE_36, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  3, SPRITE_36, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  7, SPRITE_36, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  6, SPRITE_36, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower3F_Blocks::
INCBIN "maps/WestRadioTower3F.blk"
