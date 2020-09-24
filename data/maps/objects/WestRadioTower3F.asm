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
	object_event  4,  6, SPRITE_SUPER_NERD, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  6, SPRITE_ROCKER, FACE_UP, 2, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  1, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  5, SPRITE_GIRL, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  2, SPRITE_36, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  3, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  7, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  6, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower3F_Blocks::
INCBIN "maps/WestRadioTower3F.blk"
