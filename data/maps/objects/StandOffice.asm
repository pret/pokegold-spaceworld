INCLUDE "constants.asm"

SECTION "data/maps/objects/StandOffice.asm", ROMX

	map_attributes StandOffice, STAND_OFFICE, 0

StandOffice_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, STAND, 3, 58
	warp_event  3,  7, STAND, 3, 58

	def_bg_events

	def_object_events
	object_event 13,  4, SPRITE_ROCKER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  6, SPRITE_SUPER_NERD, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  7, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandOffice_Blocks::
INCBIN "maps/StandOffice.blk"
