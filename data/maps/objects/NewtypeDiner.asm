INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeDiner.asm", ROMX

	map_attributes NewtypeDiner, NEWTYPE_DINER, 0

NewtypeDiner_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, NEWTYPE, 9, 42
	warp_event  3,  7, NEWTYPE, 9, 42

	def_bg_events

	def_object_events
	object_event  2,  1, SPRITE_CLERK, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  3, SPRITE_GIRL, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  3, SPRITE_SAILOR, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  1, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeDiner_Blocks::
INCBIN "maps/NewtypeDiner.blk"
