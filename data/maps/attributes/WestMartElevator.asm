INCLUDE "constants.asm"

SECTION "data/maps/attributes/WestMartElevator.asm", ROMX
	map_attributes WestMartElevator, WEST_MART_ELEVATOR, 0

WestMartElevator_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 1, 3, 4, WEST_MART_1F, wOverworldMapBlocks + 17
	warp_event 2, 3, 4, WEST_MART_1F, wOverworldMapBlocks + 18

	db 0 ; bg events

	db 0 ; person events

WestMartElevator_Blocks:: INCBIN "maps/blk/WestMartElevator.blk"