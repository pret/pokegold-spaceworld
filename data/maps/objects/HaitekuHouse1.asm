INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuHouse1.asm", ROMX

	map_attributes HaitekuHouse1, HAITEKU_HOUSE_1, 0

HaitekuHouse1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, HAITEKU, 5, 47
	warp_event  5,  7, HAITEKU, 5, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_FISHING_GURU, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuHouse1_Blocks::
INCBIN "maps/HaitekuHouse1.blk"
