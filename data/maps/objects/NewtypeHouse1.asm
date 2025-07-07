INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeHouse1.asm", ROMX

	map_attributes NewtypeHouse1, NEWTYPE_HOUSE_1, 0

NewtypeHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NEWTYPE, 8, 47
	warp_event  5,  7, NEWTYPE, 8, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse1_Blocks::
INCBIN "maps/NewtypeHouse1.blk"
