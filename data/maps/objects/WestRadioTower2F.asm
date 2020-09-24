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
	object_event  4,  6, SPRITE_GYM_GUY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  5, SPRITE_ROCKER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_SUPER_NERD, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  2, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  1, SPRITE_36, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  6, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  7, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower2F_Blocks::
INCBIN "maps/WestRadioTower2F.blk"
