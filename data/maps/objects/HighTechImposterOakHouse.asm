INCLUDE "constants.asm"

SECTION "data/maps/objects/HighTechImposterOakHouse.asm", ROMX

	map_attributes HighTechImposterOakHouse, HIGHTECH_IMPOSTER_OAK_HOUSE, 0

HighTechImposterOakHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, HIGHTECH, 7, 47
	warp_event  5,  7, HIGHTECH, 7, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_EVIL_OKIDO, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  2, SPRITE_POKEFAN_F, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

HighTechImposterOakHouse_Blocks::
INCBIN "maps/HighTechImposterOakHouse.blk"
