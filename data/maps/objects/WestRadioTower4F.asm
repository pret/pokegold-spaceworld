INCLUDE "constants.asm"

SECTION "data/maps/objects/WestRadioTower4F.asm", ROMX

	map_attributes WestRadioTower4F, WEST_RADIO_TOWER_4F, 0

WestRadioTower4F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  0, WEST_RADIO_TOWER_5F, 1, 11
	warp_event  7,  0, WEST_RADIO_TOWER_3F, 2, 14

	def_bg_events
	bg_event  5,  0, 1

	def_object_events
	object_event  2,  6, SPRITE_SUPER_NERD, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  2, SPRITE_ROCKER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  5, SPRITE_BURGLAR, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  6, SPRITE_ROCKER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  0,  5, SPRITE_GIRL, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  5, SPRITE_36, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  4, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  1, SPRITE_36, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  2, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower4F_Blocks::
INCBIN "maps/WestRadioTower4F.blk"
