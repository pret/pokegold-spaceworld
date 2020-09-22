INCLUDE "constants.asm"

SECTION "data/maps/objects/SilentHillLabBack.asm", ROMX

	map_attributes SilentHillLabBack, SILENT_HILL_LAB_BACK, 0

SilentHillLabBack_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, SILENT_HILL_LAB_FRONT, 3, 42
	warp_event  4,  7, SILENT_HILL_LAB_FRONT, 3, 43

	def_bg_events
	bg_event  0,  1, 1
	bg_event  1,  1, 2
	bg_event  2,  1, 3
	bg_event  3,  1, 4
	bg_event  6,  0, 5

	def_object_events
	object_event  4,  2, SPRITE_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  4, SPRITE_SILVER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillLabBack_Blocks::
INCBIN "maps/SilentHillLabBack.blk"
