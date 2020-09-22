INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoHospital.asm", ROMX

	map_attributes KantoHospital, KANTO_HOSPITAL, 0

KantoHospital_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  1,  7, KANTO, 19, 57
	warp_event  2,  7, KANTO, 19, 58

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  6, SPRITE_ROCKER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12,  6, SPRITE_GIRL, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoHospital_Blocks::
INCBIN "maps/KantoHospital.blk"
