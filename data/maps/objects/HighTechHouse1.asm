INCLUDE "constants.asm"

SECTION "data/maps/objects/HighTechHouse1.asm", ROMX

	map_attributes HighTechHouse1, HIGHTECH_HOUSE_1, 0

HighTechHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, HIGHTECH, 5, 47
	warp_event  5,  7, HIGHTECH, 5, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_FISHING_GURU, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HighTechHouse1_Blocks::
INCBIN "maps/HighTechHouse1.blk"
