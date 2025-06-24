INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeDojo.asm", ROMX

	map_attributes NewtypeDojo, NEWTYPE_DOJO, 0

NewtypeDojo_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3, 15, NEWTYPE, 6, 82
	warp_event  4, 15, NEWTYPE, 7, 83

	def_bg_events

	def_object_events
	object_event  3,  2, SPRITE_BLACKBELT, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  6, SPRITE_BLACKBELT, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  6, SPRITE_BLACKBELT, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3, 10, SPRITE_BLACKBELT, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6, 10, SPRITE_BLACKBELT, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeDojo_Blocks::
INCBIN "maps/NewtypeDojo.blk"
