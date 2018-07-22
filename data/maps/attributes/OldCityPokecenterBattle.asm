INCLUDE "constants.asm"

SECTION "data/maps/attributes/OldCityPokecenterBattle.asm", ROMX
	map_attributes OldCityPokecenterBattle, OLD_CITY_POKECENTER_BATTLE, 0

OldCityPokecenterBattle_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, OLD_CITY_POKECENTER_2F, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, OLD_CITY_POKECENTER_2F, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 3, 3, SPRITE_GOLD, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenterBattle_Blocks:: INCBIN "maps/blk/OldCityPokecenterBattle.blk"