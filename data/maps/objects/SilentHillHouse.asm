INCLUDE "constants.asm"

SECTION "data/maps/objects/SilentHillHouse.asm", ROMX

	map_attributes SilentHillHouse, SILENT_HILL_HOUSE, 0

SilentHillHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, SILENT_HILL, 3, 47
	warp_event  5,  7, SILENT_HILL, 3, 47

	def_bg_events
	bg_event  0,  1, 1
	bg_event  4,  1, 2
	bg_event  5,  1, 3
	bg_event  9,  1, 4
	bg_event  8,  1, 5
	bg_event  2,  0, 6

	def_object_events
	object_event  5,  3, SPRITE_SILVERS_MOM, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  4, SPRITE_ROCKER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillHouse_Blocks::
INCBIN "maps/SilentHillHouse.blk"
