INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityPokecenter2F.asm", ROMX
	map_attributes OldCityPokecenter2F, OLD_CITY_POKECENTER_2F, 0

OldCityPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 0, 7, 3, OLD_CITY_POKECENTER_1F, wOverworldMapBlocks + 57
	warp_event 5, 0, 1, OLD_CITY_POKECENTER_TRADE, wOverworldMapBlocks + 17
	warp_event 9, 0, 1, OLD_CITY_POKECENTER_BATTLE, wOverworldMapBlocks + 19
	warp_event 13, 2, 1, OLD_CITY_POKECENTER_TIME_MACHINE, wOverworldMapBlocks + 35

	db 1 ; bg events
	bg_event 1, 1, 0, 1

	db 4 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 3, SPRITE_GRAMPS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 3, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenter2F_Blocks:: INCBIN "maps/blk/OldCityPokecenter2F.blk"
