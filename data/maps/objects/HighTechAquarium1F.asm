INCLUDE "constants.asm"

SECTION "data/maps/objects/HighTechAquarium1F.asm", ROMX

	map_attributes HighTechAquarium1F, HIGHTECH_AQUARIUM_1F, 0

HighTechAquarium1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  7, HIGHTECH, 8, 63
	warp_event 13,  7, HIGHTECH, 9, 63
	warp_event  0,  7, HIGHTECH_AQUARIUM_2F, 1, 57

	def_bg_events

	def_object_events
	object_event 15,  5, SPRITE_RECEPTIONIST, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12,  2, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  5, SPRITE_LASS, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

HighTechAquarium1F_Blocks::
INCBIN "maps/HighTechAquarium1F.blk"
