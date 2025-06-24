INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoPokecenter21F.asm", ROMX

	map_attributes KantoPokecenter21F, KANTO_POKECENTER_2_1F, 0

KantoPokecenter21F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, KANTO, 20, 59
	warp_event  6,  7, KANTO, 20, 60
	warp_event  0,  7, KANTO_POKECENTER_2_2F, 1, 57

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_24, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoPokecenter21F_Blocks::
INCBIN "maps/KantoPokecenter21F.blk"
