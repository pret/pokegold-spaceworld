INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonPokecenter1F.asm", ROMX

	map_attributes BaadonPokecenter1F, BAADON_POKECENTER_1F, 0

BaadonPokecenter1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, BAADON, 2, 59
	warp_event  6,  7, BAADON, 2, 60
	warp_event  0,  7, BAADON_POKECENTER_2F, 1, 57

	def_bg_events

	def_object_events
	object_event 14,  6, SPRITE_FISHER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonPokecenter1F_Blocks::
INCBIN "maps/BaadonPokecenter1F.blk"
