INCLUDE "constants.asm"

SECTION "data/maps/objects/NewtypeHouse2.asm", ROMX

	map_attributes NewtypeHouse2, NEWTYPE_HOUSE_2, 0

NewtypeHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NEWTYPE, 10, 47
	warp_event  5,  7, NEWTYPE, 10, 47

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_GENTLEMAN, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse2_Blocks::
INCBIN "maps/NewtypeHouse2.blk"
