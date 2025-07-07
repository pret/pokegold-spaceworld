INCLUDE "constants.asm"

SECTION "data/maps/objects/HaitekuHouse2.asm", ROMX

	map_attributes HaitekuHouse2, HAITEKU_HOUSE_2, 0

HaitekuHouse2_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, HAITEKU, 6, 47
	warp_event  5,  7, HAITEKU, 6, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_SAILOR, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuHouse2_Blocks::
INCBIN "maps/HaitekuHouse2.blk"
