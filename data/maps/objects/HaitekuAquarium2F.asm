INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuAquarium2F.asm", ROMX

	map_attributes HaitekuAquarium2F, HAITEKU_AQUARIUM_2F, 0

HaitekuAquarium2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, HAITEKU_AQUARIUM_1F, 3, 57

	def_bg_events

	def_object_events
	object_event  7,  6, SPRITE_POKEFAN_M, SPRITEMOVEFN_RANDOM_WALK_X, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  4, SPRITE_TEACHER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuAquarium2F_Blocks::
INCBIN "maps/HaitekuAquarium2F.blk"
