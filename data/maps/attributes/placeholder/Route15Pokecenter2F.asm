INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Route15Pokecenter2F.asm", ROMX
	map_attributes Route15Pokecenter2F, ROUTE_15_POKECENTER_2F, 0

Route15Pokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, ROUTE_15_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 0 ; person events

Route15Pokecenter2F_Blocks:: INCBIN "maps/placeholder/blk/Route15Pokecenter2F.blk"