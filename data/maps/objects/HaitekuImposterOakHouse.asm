INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuImposterOakHouse.asm", ROMX

	map_attributes HaitekuImposterOakHouse, HAITEKU_IMPOSTER_OAK_HOUSE, 0

HaitekuImposterOakHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, HAITEKU, 7, 47
	warp_event  5,  7, HAITEKU, 7, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_EVIL_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  2, SPRITE_POKEFAN_F, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuImposterOakHouse_Blocks::
INCBIN "maps/HaitekuImposterOakHouse.blk"
