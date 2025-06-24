INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeHouse3.asm", ROMX

	map_attributes NewtypeHouse3, NEWTYPE_HOUSE_3, 0

NewtypeHouse3_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NEWTYPE, 11, 47
	warp_event  5,  7, NEWTYPE, 11, 47

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_GRAMPS, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse3_Blocks::
INCBIN "maps/NewtypeHouse3.blk"
