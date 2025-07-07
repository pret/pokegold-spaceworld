INCLUDE "constants.asm"

SECTION "data/maps/objects/SilentHillPokecenter.asm", ROMX

	map_attributes SilentHillPokecenter, SILENT_HILL_POKECENTER, 0

SilentHillPokecenter_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, SILENT_HILL, 2, 59
	warp_event  6,  7, SILENT_HILL, 2, 60

	def_bg_events
	bg_event 13,  1, 1

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  4, SPRITE_24, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_RHYDON, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillPokecenter_Blocks::
INCBIN "maps/SilentHillPokecenter.blk"
