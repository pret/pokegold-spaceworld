INCLUDE "constants.asm"

SECTION "data/maps/objects/WestRadioTower1F.asm", ROMX

	map_attributes WestRadioTower1F, WEST_RADIO_TOWER_1F, 0

WestRadioTower1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, WEST, 3, 42
	warp_event  3,  7, WEST, 4, 42
	warp_event  7,  0, WEST_RADIO_TOWER_2F, 2, 14

	def_bg_events
	bg_event  5,  0, 0, 1
	bg_event  0,  1, 0, 2

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  3, SPRITE_SUPER_NERD, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  4, SPRITE_ROCKER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower1F_Blocks::
INCBIN "maps/WestRadioTower1F.blk"
