INCLUDE "constants.asm"

SECTION "data/maps/attributes/placeholder/Route18Pokecenter2F.asm", ROMX
	map_attributes Route18Pokecenter2F, ROUTE_18_POKECENTER_2F, 0

Route18Pokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, ROUTE_18_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 0 ; person events

Route18Pokecenter2F_Blocks:: INCBIN "maps/placeholder/blk/Route18Pokecenter2F.blk"