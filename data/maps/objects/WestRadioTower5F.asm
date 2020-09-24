INCLUDE "constants.asm"

SECTION "data/maps/objects/WestRadioTower5F.asm", ROMX

	map_attributes WestRadioTower5F, WEST_RADIO_TOWER_5F, 0

WestRadioTower5F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  0, WEST_RADIO_TOWER_4F, 1, 11

	def_bg_events
	bg_event  3,  0, 1
	bg_event  6,  4, 2
	bg_event  7,  4, 2

	def_object_events
	object_event  6,  6, SPRITE_SCIENTIST, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  2, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  6, SPRITE_PIPPI, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_PIPPI, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  7, SPRITE_SAKAKI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  2, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  4, SPRITE_36, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  7, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower5F_Blocks::
INCBIN "maps/WestRadioTower5F.blk"
