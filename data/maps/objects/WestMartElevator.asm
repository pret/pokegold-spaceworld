INCLUDE "constants.asm"

SECTION "data/maps/objects/WestMartElevator.asm", ROMX

	map_attributes WestMartElevator, WEST_MART_ELEVATOR, 0

WestMartElevator_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  1,  3, WEST_MART_1F, 4, 17
	warp_event  2,  3, WEST_MART_1F, 4, 18

	def_bg_events

	def_object_events

WestMartElevator_Blocks::
INCBIN "maps/WestMartElevator.blk"
