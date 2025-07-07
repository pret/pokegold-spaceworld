INCLUDE "constants.asm"

SECTION "data/maps/objects/WestMart1F.asm", ROMX

	map_attributes WestMart1F, WEST_MART_1F, 0

WestMart1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 13,  7, WEST, 1, 63
	warp_event 14,  7, WEST, 2, 64
	warp_event 15,  0, WEST_MART_2F, 2, 22
	warp_event  2,  0, WEST_MART_ELEVATOR, 1, 16

	def_bg_events
	bg_event 14,  0, 1
	bg_event  3,  0, 2

	def_object_events
	object_event  7,  1, SPRITE_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart1F_Blocks::
INCBIN "maps/WestMart1F.blk"
