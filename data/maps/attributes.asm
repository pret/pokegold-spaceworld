INCLUDE "constants.asm"

SECTION "data/maps/attributes.asm@Route2Gate1F", ROMX
	map_attributes Route2Gate1F, ROUTE_2_GATE_1F, 0

Route2Gate1F_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 0, 7, 13, WEST, wOverworldMapBlocks + 45
	warp_event 1, 7, 13, WEST, wOverworldMapBlocks + 45
	warp_event 8, 7, 1, ROUTE_2, wOverworldMapBlocks + 49
	warp_event 9, 7, 1, ROUTE_2, wOverworldMapBlocks + 49
	warp_event 1, 0, 1, ROUTE_2_GATE_2F, wOverworldMapBlocks + 12

	db 0 ; bg events

	db 2 ; person events
	object_event 8, 3, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 1, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2Gate1F_Blocks:: INCBIN "maps/blk/Route2Gate1F.blk"

SECTION "data/maps/attributes.asm@Route2Gate2F", ROMX
	map_attributes Route2Gate2F, ROUTE_2_GATE_2F, 0

Route2Gate2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 5, 0, 5, ROUTE_2_GATE_1F, wOverworldMapBlocks + 13

	db 2 ; bg events
	bg_event 1, 0, 0, 1
	bg_event 3, 0, 0, 2

	db 2 ; person events
	object_event 2, 2, SPRITE_LASS, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 4, SPRITE_TWIN, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2Gate2F_Blocks:: INCBIN "maps/blk/Route2Gate2F.blk"

SECTION "data/maps/attributes.asm@Route2House", ROMX
	map_attributes Route2House, ROUTE_2_HOUSE, 0

Route2House_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 2, ROUTE_2, wOverworldMapBlocks + 43
	warp_event 5, 7, 2, ROUTE_2, wOverworldMapBlocks + 43

	db 6 ; bg events
	bg_event 0, 0, 0, 1
	bg_event 2, 0, 0, 1
	bg_event 4, 0, 0, 1
	bg_event 6, 0, 0, 1
	bg_event 0, 3, 0, 2
	bg_event 4, 3, 0, 3

	db 1 ; person events
	object_event 6, 6, SPRITE_SCIENTIST, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2House_Blocks:: INCBIN "maps/blk/Route2House.blk"

SECTION "data/maps/attributes.asm@OldCityMuseum", ROMX
	map_attributes OldCityMuseum, OLD_CITY_MUSEUM, 0

OldCityMuseum_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 2, 7, 1, OLD_CITY, wOverworldMapBlocks + 58
	warp_event 3, 7, 2, OLD_CITY, wOverworldMapBlocks + 58

	db 4 ; bg events
	bg_event 2, 3, 0, 1
	bg_event 5, 4, 0, 2
	bg_event 9, 4, 0, 3
	bg_event 13, 4, 0, 4

	db 2 ; person events
	object_event 1, 5, SPRITE_FISHER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 4, SPRITE_EGG, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityMuseum_Blocks:: INCBIN "maps/blk/OldCityMuseum.blk"

SECTION "data/maps/attributes.asm@OldCityGym", ROMX
	map_attributes OldCityGym, OLD_CITY_GYM, 0

OldCityGym_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 17, 3, OLD_CITY, wOverworldMapBlocks + 102
	warp_event 5, 17, 4, OLD_CITY, wOverworldMapBlocks + 102

	db 2 ; bg events
	bg_event 3, 15, 0, 1
	bg_event 6, 15, 0, 1

	db 6 ; person events
	object_event 4, 5, SPRITE_HAYATO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 9, SPRITE_YOUNGSTER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event 8, 1, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event 1, 1, SPRITE_SUPER_NERD, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event 1, 9, SPRITE_YOUNGSTER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0
	object_event 7, 15, SPRITE_GYM_GUY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 1, 0, 0

OldCityGym_Blocks:: INCBIN "maps/blk/OldCityGym.blk"

SECTION "data/maps/attributes.asm@OldCityTower1F", ROMX
	map_attributes OldCityTower1F, OLD_CITY_TOWER_1F, 0

OldCityTower1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 7, 5, OLD_CITY, wOverworldMapBlocks + 42
	warp_event 4, 7, 6, OLD_CITY, wOverworldMapBlocks + 43
	warp_event 0, 1, 1, OLD_CITY_TOWER_2F, wOverworldMapBlocks + 11

	db 3 ; bg events
	bg_event 2, 6, 0, 1
	bg_event 5, 6, 0, 2
	bg_event 4, 1, 0, 3

	db 4 ; person events
	object_event 0, 2, SPRITE_SAGE, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 1, 5, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 5, 1, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 6, 4, SPRITE_SAGE, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

OldCityTower1F_Blocks:: INCBIN "maps/blk/OldCityTower1F.blk"

SECTION "data/maps/attributes.asm@OldCityTower2F", ROMX
	map_attributes OldCityTower2F, OLD_CITY_TOWER_2F, 0

OldCityTower2F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 1, 3, OLD_CITY_TOWER_1F, wOverworldMapBlocks + 11
	warp_event 7, 7, 2, OLD_CITY_TOWER_3F, wOverworldMapBlocks + 44

	db 2 ; bg events
	bg_event 3, 0, 0, 1
	bg_event 4, 1, 0, 2

	db 4 ; person events
	object_event 2, 3, SPRITE_MEDIUM, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 5, 3, SPRITE_MEDIUM, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 2, 6, SPRITE_MEDIUM, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 5, 6, SPRITE_MEDIUM, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0

OldCityTower2F_Blocks:: INCBIN "maps/blk/OldCityTower2F.blk"

SECTION "data/maps/attributes.asm@OldCityTower3F", ROMX
	map_attributes OldCityTower3F, OLD_CITY_TOWER_3F, 0

OldCityTower3F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 1, 1, OLD_CITY_TOWER_4F, wOverworldMapBlocks + 11
	warp_event 7, 7, 2, OLD_CITY_TOWER_2F, wOverworldMapBlocks + 44

	db 2 ; bg events
	bg_event 3, 0, 0, 1
	bg_event 4, 1, 0, 2

	db 4 ; person events
	object_event 2, 3, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 3, 4, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 4, 4, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 5, 5, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0

OldCityTower3F_Blocks:: INCBIN "maps/blk/OldCityTower3F.blk"

SECTION "data/maps/attributes.asm@OldCityTower4F", ROMX
	map_attributes OldCityTower4F, OLD_CITY_TOWER_4F, 0

OldCityTower4F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 1, 1, OLD_CITY_TOWER_3F, wOverworldMapBlocks + 11
	warp_event 7, 7, 1, OLD_CITY_TOWER_5F, wOverworldMapBlocks + 44

	db 2 ; bg events
	bg_event 3, 0, 0, 1
	bg_event 4, 1, 0, 2

	db 4 ; person events
	object_event 3, 2, SPRITE_SAGE, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 4, 7, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 6, 7, SPRITE_SAGE, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 7, 1, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

OldCityTower4F_Blocks:: INCBIN "maps/blk/OldCityTower4F.blk"

SECTION "data/maps/attributes.asm@OldCityTower5F", ROMX
	map_attributes OldCityTower5F, OLD_CITY_TOWER_5F, 0

OldCityTower5F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 5, 5, 2, OLD_CITY_TOWER_4F, wOverworldMapBlocks + 30

	db 3 ; bg events
	bg_event 2, 0, 0, 1
	bg_event 3, 0, 0, 2
	bg_event 4, 1, 0, 3

	db 1 ; person events
	object_event 2, 3, SPRITE_SAGE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityTower5F_Blocks:: INCBIN "maps/blk/OldCityTower5F.blk"

SECTION "data/maps/attributes.asm@OldCityBillsHouse", ROMX
	map_attributes OldCityBillsHouse, OLD_CITY_BILLS_HOUSE, 0

OldCityBillsHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 7, OLD_CITY, wOverworldMapBlocks + 42
	warp_event 4, 7, 7, OLD_CITY, wOverworldMapBlocks + 43

	db 6 ; bg events
	bg_event 2, 1, 0, 1
	bg_event 3, 1, 0, 2
	bg_event 4, 1, 0, 3
	bg_event 6, 1, 0, 4
	bg_event 7, 1, 0, 5
	bg_event 1, 1, 0, 6

	db 1 ; person events
	object_event 5, 4, SPRITE_MASAKI, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityBillsHouse_Blocks:: INCBIN "maps/blk/OldCityBillsHouse.blk"

SECTION "data/maps/attributes.asm@OldCityMart", ROMX
	map_attributes OldCityMart, OLD_CITY_MART, 0

OldCityMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 8, OLD_CITY, wOverworldMapBlocks + 51
	warp_event 5, 7, 8, OLD_CITY, wOverworldMapBlocks + 51

	db 1 ; bg events
	bg_event 0, 7, 0, 1

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_YOUNGSTER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityMart_Blocks:: INCBIN "maps/blk/OldCityMart.blk"

SECTION "data/maps/attributes.asm@OldCityHouse", ROMX
	map_attributes OldCityHouse, OLD_CITY_HOUSE, 0

OldCityHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 9, OLD_CITY, wOverworldMapBlocks + 42
	warp_event 4, 7, 9, OLD_CITY, wOverworldMapBlocks + 43

	db 4 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 2, 1, 0, 3
	bg_event 7, 1, 0, 4

	db 3 ; person events
	object_event 2, 3, SPRITE_POKEFAN_M, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 6, SPRITE_LASS, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityHouse_Blocks:: INCBIN "maps/blk/OldCityHouse.blk"

SECTION "data/maps/attributes.asm@OldCityPokecenter1F", ROMX
	map_attributes OldCityPokecenter1F, OLD_CITY_POKECENTER_1F, 0

OldCityPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 10, OLD_CITY, wOverworldMapBlocks + 59
	warp_event 6, 7, 10, OLD_CITY, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, OLD_CITY_POKECENTER_2F, wOverworldMapBlocks + 57

	db 1 ; bg events
	bg_event 13, 1, 0, 1

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_YOUNGSTER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_35, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenter1F_Blocks:: INCBIN "maps/blk/OldCityPokecenter1F.blk"

SECTION "data/maps/attributes.asm@OldCityPokecenter2F", ROMX
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

SECTION "data/maps/attributes.asm@OldCityPokecenterTrade", ROMX
	map_attributes OldCityPokecenterTrade, OLD_CITY_POKECENTER_TRADE, 0

OldCityPokecenterTrade_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 2, OLD_CITY_POKECENTER_2F, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, OLD_CITY_POKECENTER_2F, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 3, 3, SPRITE_GOLD, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenterTrade_Blocks:: INCBIN "maps/blk/OldCityPokecenterTrade.blk"

SECTION "data/maps/attributes.asm@OldCityPokecenterBattle", ROMX
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

SECTION "data/maps/attributes.asm@OldCityPokecenterTimeMachine", ROMX
	map_attributes OldCityPokecenterTimeMachine, OLD_CITY_POKECENTER_TIME_MACHINE, 0

OldCityPokecenterTimeMachine_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 2, 7, 4, OLD_CITY_POKECENTER_2F, wOverworldMapBlocks + 58
	warp_event 3, 7, 4, OLD_CITY_POKECENTER_2F, wOverworldMapBlocks + 58

	db 1 ; bg events
	bg_event 15, 3, 0, 1

	db 1 ; person events
	object_event 13, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenterTimeMachine_Blocks:: INCBIN "maps/blk/OldCityPokecenterTimeMachine.blk"

SECTION "data/maps/attributes.asm@OldCityKurtsHouse", ROMX
	map_attributes OldCityKurtsHouse, OLD_CITY_KURTS_HOUSE, 0

OldCityKurtsHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 11, OLD_CITY, wOverworldMapBlocks + 58
	warp_event 4, 7, 11, OLD_CITY, wOverworldMapBlocks + 59

	db 5 ; bg events
	bg_event 4, 1, 0, 1
	bg_event 5, 1, 0, 2
	bg_event 12, 1, 0, 3
	bg_event 14, 0, 0, 4
	bg_event 15, 0, 0, 4

	db 1 ; person events
	object_event 2, 2, SPRITE_GANTETSU, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityKurtsHouse_Blocks:: INCBIN "maps/blk/OldCityKurtsHouse.blk"

SECTION "data/maps/attributes.asm@OldCitySchool", ROMX
	map_attributes OldCitySchool, OLD_CITY_SCHOOL, 0

OldCitySchool_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 15, 14, OLD_CITY, wOverworldMapBlocks + 82
	warp_event 4, 15, 14, OLD_CITY, wOverworldMapBlocks + 83

	db 4 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 1
	bg_event 3, 0, 0, 2
	bg_event 4, 0, 0, 2

	db 6 ; person events
	object_event 2, 5, SPRITE_GIRL, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_ROCKER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_TEACHER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 11, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCitySchool_Blocks:: INCBIN "maps/blk/OldCitySchool.blk"

SECTION "data/maps/attributes.asm@Route1Gate1F", ROMX
	map_attributes Route1Gate1F, ROUTE_1_GATE_1F, 0

Route1Gate1F_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 4, 7, 1, ROUTE_1_P2, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, ROUTE_1_P2, wOverworldMapBlocks + 47
	warp_event 4, 0, 12, OLD_CITY, wOverworldMapBlocks + 14
	warp_event 5, 0, 13, OLD_CITY, wOverworldMapBlocks + 14
	warp_event 1, 0, 1, ROUTE_1_GATE_2F, wOverworldMapBlocks + 12

	db 0 ; bg events

	db 2 ; person events
	object_event 6, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 6, SPRITE_COOLTRAINER_F, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route1Gate1F_Blocks:: INCBIN "maps/blk/Route1Gate1F.blk"

SECTION "data/maps/attributes.asm@Route1Gate2F", ROMX
	map_attributes Route1Gate2F, ROUTE_1_GATE_2F, 0

Route1Gate2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 5, 0, 5, ROUTE_1_GATE_1F, wOverworldMapBlocks + 13

	db 2 ; bg events
	bg_event 1, 0, 0, 1
	bg_event 3, 0, 0, 2

	db 2 ; person events
	object_event 3, 3, SPRITE_LASS, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 4, SPRITE_TWIN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route1Gate2F_Blocks:: INCBIN "maps/blk/Route1Gate2F.blk"

SECTION "data/maps/attributes.asm@WestMart1F", ROMX
	map_attributes WestMart1F, WEST_MART_1F, 0

WestMart1F_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 13, 7, 1, WEST, wOverworldMapBlocks + 63
	warp_event 14, 7, 2, WEST, wOverworldMapBlocks + 64
	warp_event 15, 0, 2, WEST_MART_2F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 2 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2

	db 1 ; person events
	object_event 7, 1, SPRITE_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart1F_Blocks:: INCBIN "maps/blk/WestMart1F.blk"

SECTION "data/maps/attributes.asm@WestMart2F", ROMX
	map_attributes WestMart2F, WEST_MART_2F, 0

WestMart2F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, WEST_MART_3F, wOverworldMapBlocks + 21
	warp_event 15, 0, 3, WEST_MART_1F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 16 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2
	bg_event 3, 4, 0, 3
	bg_event 3, 5, 0, 3
	bg_event 3, 6, 0, 3
	bg_event 3, 7, 0, 3
	bg_event 7, 4, 0, 3
	bg_event 7, 5, 0, 3
	bg_event 7, 6, 0, 3
	bg_event 7, 7, 0, 3
	bg_event 4, 1, 0, 3
	bg_event 5, 1, 0, 3
	bg_event 6, 1, 0, 3
	bg_event 7, 1, 0, 3
	bg_event 8, 1, 0, 3
	bg_event 9, 1, 0, 3

	db 4 ; person events
	object_event 14, 5, SPRITE_CLERK, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 6, SPRITE_LASS, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_BURGLAR, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_ROCKET_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart2F_Blocks:: INCBIN "maps/blk/WestMart2F.blk"

SECTION "data/maps/attributes.asm@WestMart3F", ROMX
	map_attributes WestMart3F, WEST_MART_3F, 0

WestMart3F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, WEST_MART_2F, wOverworldMapBlocks + 21
	warp_event 15, 0, 2, WEST_MART_4F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 14 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2
	bg_event 1, 4, 0, 3
	bg_event 1, 5, 0, 3
	bg_event 1, 6, 0, 3
	bg_event 1, 7, 0, 3
	bg_event 5, 4, 0, 3
	bg_event 5, 5, 0, 3
	bg_event 5, 6, 0, 3
	bg_event 5, 7, 0, 3
	bg_event 9, 4, 0, 3
	bg_event 9, 5, 0, 3
	bg_event 9, 6, 0, 3
	bg_event 9, 7, 0, 3

	db 3 ; person events
	object_event 6, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 4, SPRITE_GENTLEMAN, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 5, SPRITE_SUPER_NERD, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart3F_Blocks:: INCBIN "maps/blk/WestMart3F.blk"

SECTION "data/maps/attributes.asm@WestMart4F", ROMX
	map_attributes WestMart4F, WEST_MART_4F, 0

WestMart4F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, WEST_MART_5F, wOverworldMapBlocks + 21
	warp_event 15, 0, 2, WEST_MART_3F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 14 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2
	bg_event 2, 5, 0, 3
	bg_event 3, 5, 0, 3
	bg_event 4, 5, 0, 3
	bg_event 5, 5, 0, 3
	bg_event 6, 5, 0, 3
	bg_event 7, 5, 0, 3
	bg_event 8, 5, 0, 3
	bg_event 9, 5, 0, 3
	bg_event 6, 1, 0, 3
	bg_event 7, 1, 0, 3
	bg_event 8, 1, 0, 3
	bg_event 9, 1, 0, 3

	db 3 ; person events
	object_event 13, 5, SPRITE_CLERK, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 6, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 2, SPRITE_ROCKER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart4F_Blocks:: INCBIN "maps/blk/WestMart4F.blk"

SECTION "data/maps/attributes.asm@WestMart5F", ROMX
	map_attributes WestMart5F, WEST_MART_5F, 0

WestMart5F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, WEST_MART_4F, wOverworldMapBlocks + 21
	warp_event 15, 0, 1, WEST_MART_6F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, WEST_MART_ELEVATOR, wOverworldMapBlocks + 16

	db 2 ; bg events
	bg_event 14, 0, 0, 1
	bg_event 3, 0, 0, 2

	db 3 ; person events
	object_event 8, 5, SPRITE_GYM_GUY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 5, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 4, SPRITE_NYOROBON, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart5F_Blocks:: INCBIN "maps/blk/WestMart5F.blk"

SECTION "data/maps/attributes.asm@WestMart6F", ROMX
	map_attributes WestMart6F, WEST_MART_6F, 0

WestMart6F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 15, 0, 2, WEST_MART_5F, wOverworldMapBlocks + 22

	db 5 ; bg events
	bg_event 8, 1, 0, 1
	bg_event 9, 1, 0, 2
	bg_event 10, 1, 0, 3
	bg_event 11, 1, 0, 4
	bg_event 14, 0, 0, 5

	db 3 ; person events
	object_event 12, 3, SPRITE_OFFICER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 4, SPRITE_SIDON, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 6, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestMart6F_Blocks:: INCBIN "maps/blk/WestMart6F.blk"

SECTION "data/maps/attributes.asm@WestMartElevator", ROMX
	map_attributes WestMartElevator, WEST_MART_ELEVATOR, 0

WestMartElevator_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 1, 3, 4, WEST_MART_1F, wOverworldMapBlocks + 17
	warp_event 2, 3, 4, WEST_MART_1F, wOverworldMapBlocks + 18

	db 0 ; bg events

	db 0 ; person events

WestMartElevator_Blocks:: INCBIN "maps/blk/WestMartElevator.blk"

SECTION "data/maps/attributes.asm@WestRadioTower1F", ROMX
	map_attributes WestRadioTower1F, WEST_RADIO_TOWER_1F, 0

WestRadioTower1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 2, 7, 3, WEST, wOverworldMapBlocks + 42
	warp_event 3, 7, 4, WEST, wOverworldMapBlocks + 42
	warp_event 7, 0, 2, WEST_RADIO_TOWER_2F, wOverworldMapBlocks + 14

	db 2 ; bg events
	bg_event 5, 0, 0, 1
	bg_event 0, 1, 0, 2

	db 3 ; person events
	object_event 6, 6, SPRITE_RECEPTIONIST, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 3, SPRITE_SUPER_NERD, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 4, SPRITE_ROCKER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower1F_Blocks:: INCBIN "maps/blk/WestRadioTower1F.blk"

SECTION "data/maps/attributes.asm@WestRadioTower2F", ROMX
	map_attributes WestRadioTower2F, WEST_RADIO_TOWER_2F, 0

WestRadioTower2F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 0, 1, WEST_RADIO_TOWER_3F, wOverworldMapBlocks + 11
	warp_event 7, 0, 3, WEST_RADIO_TOWER_1F, wOverworldMapBlocks + 14

	db 1 ; bg events
	bg_event 5, 0, 0, 1

	db 7 ; person events
	object_event 4, 6, SPRITE_GYM_GUY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 5, SPRITE_ROCKER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_SUPER_NERD, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 2, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_36, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 7, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower2F_Blocks:: INCBIN "maps/blk/WestRadioTower2F.blk"

SECTION "data/maps/attributes.asm@WestRadioTower3F", ROMX
	map_attributes WestRadioTower3F, WEST_RADIO_TOWER_3F, 0

WestRadioTower3F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 0, 1, WEST_RADIO_TOWER_2F, wOverworldMapBlocks + 11
	warp_event 7, 0, 2, WEST_RADIO_TOWER_4F, wOverworldMapBlocks + 14

	db 1 ; bg events
	bg_event 5, 0, 0, 1

	db 8 ; person events
	object_event 4, 6, SPRITE_SUPER_NERD, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 6, SPRITE_ROCKER, FACE_UP, 2, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 5, SPRITE_GIRL, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 2, SPRITE_36, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 3, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 7, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 6, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower3F_Blocks:: INCBIN "maps/blk/WestRadioTower3F.blk"

SECTION "data/maps/attributes.asm@WestRadioTower4F", ROMX
	map_attributes WestRadioTower4F, WEST_RADIO_TOWER_4F, 0

WestRadioTower4F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 0, 0, 1, WEST_RADIO_TOWER_5F, wOverworldMapBlocks + 11
	warp_event 7, 0, 2, WEST_RADIO_TOWER_3F, wOverworldMapBlocks + 14

	db 1 ; bg events
	bg_event 5, 0, 0, 1

	db 9 ; person events
	object_event 2, 6, SPRITE_SUPER_NERD, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 2, SPRITE_ROCKER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 5, SPRITE_BURGLAR, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 6, SPRITE_ROCKER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 5, SPRITE_GIRL, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 5, SPRITE_36, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 4, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 1, SPRITE_36, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 2, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower4F_Blocks:: INCBIN "maps/blk/WestRadioTower4F.blk"

SECTION "data/maps/attributes.asm@WestRadioTower5F", ROMX
	map_attributes WestRadioTower5F, WEST_RADIO_TOWER_5F, 0

WestRadioTower5F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 0, 1, WEST_RADIO_TOWER_4F, wOverworldMapBlocks + 11

	db 3 ; bg events
	bg_event 3, 0, 0, 1
	bg_event 6, 4, 0, 2
	bg_event 7, 4, 0, 2

	db 8 ; person events
	object_event 6, 6, SPRITE_SCIENTIST, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 2, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 6, SPRITE_PIPPI, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_PIPPI, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 7, SPRITE_SAKAKI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 2, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 4, SPRITE_36, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 7, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower5F_Blocks:: INCBIN "maps/blk/WestRadioTower5F.blk"

SECTION "data/maps/attributes.asm@WestRocketRaidedHouse", ROMX
	map_attributes WestRocketRaidedHouse, WEST_ROCKET_RAIDED_HOUSE, 0

WestRocketRaidedHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, WEST, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, WEST, wOverworldMapBlocks + 47

	db 7 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 2, 1, 0, 3
	bg_event 4, 1, 0, 4
	bg_event 5, 1, 0, 4
	bg_event 7, 1, 0, 5
	bg_event 8, 0, 0, 6

	db 5 ; person events
	object_event 8, 1, SPRITE_36, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 5, SPRITE_36, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 4, SPRITE_POKEFAN_M, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 3, SPRITE_POKEFAN_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRocketRaidedHouse_Blocks:: INCBIN "maps/blk/WestRocketRaidedHouse.blk"

SECTION "data/maps/attributes.asm@WestPokecenter1F", ROMX
	map_attributes WestPokecenter1F, WEST_POKECENTER_1F, 0

WestPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 6, WEST, wOverworldMapBlocks + 59
	warp_event 6, 7, 6, WEST, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, WEST_POKECENTER_2F, wOverworldMapBlocks + 57

	db 1 ; bg events
	bg_event 13, 1, 0, 1

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_LASS, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_ROCKET_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestPokecenter1F_Blocks:: INCBIN "maps/blk/WestPokecenter1F.blk"

SECTION "data/maps/attributes.asm@WestPokecenter2F", ROMX
	map_attributes WestPokecenter2F, WEST_POKECENTER_2F, 0

WestPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, WEST_POKECENTER_1F, wOverworldMapBlocks + 57

	db 1 ; bg events
	bg_event 1, 1, 0, 1

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 3, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestPokecenter2F_Blocks:: INCBIN "maps/blk/WestPokecenter2F.blk"

SECTION "data/maps/attributes.asm@WestGym", ROMX
	map_attributes WestGym, WEST_GYM, 0

WestGym_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 17, 7, WEST, wOverworldMapBlocks + 102
	warp_event 5, 17, 8, WEST, wOverworldMapBlocks + 102

	db 2 ; bg events
	bg_event 3, 15, 0, 1
	bg_event 6, 15, 0, 1

	db 6 ; person events
	object_event 4, 4, SPRITE_TSUKUSHI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 7, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 3, 11, SPRITE_COOLTRAINER_F, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0
	object_event 5, 9, SPRITE_LASS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 4, 6, SPRITE_TWIN, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 7, 15, SPRITE_GYM_GUY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestGym_Blocks:: INCBIN "maps/blk/WestGym.blk"

SECTION "data/maps/attributes.asm@WestHouse1", ROMX
	map_attributes WestHouse1, WEST_HOUSE_1, 0

WestHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 9, WEST, wOverworldMapBlocks + 47
	warp_event 5, 7, 9, WEST, wOverworldMapBlocks + 47

	db 4 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 5, 1, 0, 3
	bg_event 8, 0, 0, 4

	db 3 ; person events
	object_event 7, 3, SPRITE_GRAMPS, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 6, SPRITE_YOUNGSTER, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 4, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestHouse1_Blocks:: INCBIN "maps/blk/WestHouse1.blk"

SECTION "data/maps/attributes.asm@WestHouse2", ROMX
	map_attributes WestHouse2, WEST_HOUSE_2, 0

WestHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 10, WEST, wOverworldMapBlocks + 47
	warp_event 5, 7, 10, WEST, wOverworldMapBlocks + 47

	db 4 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 5, 1, 0, 3
	bg_event 8, 0, 0, 4

	db 3 ; person events
	object_event 7, 3, SPRITE_GRAMPS, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 6, SPRITE_YOUNGSTER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_BUG_CATCHER_BOY, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0

WestHouse2_Blocks:: INCBIN "maps/blk/WestHouse2.blk"

SECTION "data/maps/attributes.asm@HaitekuWestRouteGate", ROMX
	map_attributes HaitekuWestRouteGate, HAITEKU_WEST_ROUTE_GATE, 0

HaitekuWestRouteGate_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 1, HAITEKU_WEST_ROUTE_OCEAN, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, HAITEKU_WEST_ROUTE_OCEAN, wOverworldMapBlocks + 47
	warp_event 4, 0, 8, SOUTH, wOverworldMapBlocks + 14
	warp_event 5, 0, 9, SOUTH, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

HaitekuWestRouteGate_Blocks:: INCBIN "maps/blk/HaitekuWestRouteGate.blk"

SECTION "data/maps/attributes.asm@HaitekuPokecenter1F", ROMX
	map_attributes HaitekuPokecenter1F, HAITEKU_POKECENTER_1F, 0

HaitekuPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 1, HAITEKU, wOverworldMapBlocks + 59
	warp_event 6, 7, 1, HAITEKU, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, HAITEKU_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_FISHER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_SAILOR, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuPokecenter1F_Blocks:: INCBIN "maps/blk/HaitekuPokecenter1F.blk"

SECTION "data/maps/attributes.asm@HaitekuPokecenter2F", ROMX
	map_attributes HaitekuPokecenter2F, HAITEKU_POKECENTER_2F, 0

HaitekuPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, HAITEKU_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuPokecenter2F_Blocks:: INCBIN "maps/blk/HaitekuPokecenter2F.blk"

SECTION "data/maps/attributes.asm@HaitekuLeague1F", ROMX
	map_attributes HaitekuLeague1F, HAITEKU_LEAGUE_1F, 0

HaitekuLeague1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 2, HAITEKU, wOverworldMapBlocks + 82
	warp_event 4, 15, 3, HAITEKU, wOverworldMapBlocks + 83
	warp_event 7, 1, 1, HAITEKU_LEAGUE_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuLeague1F_Blocks:: INCBIN "maps/blk/HaitekuLeague1F.blk"

SECTION "data/maps/attributes.asm@HaitekuLeague2F", ROMX
	map_attributes HaitekuLeague2F, HAITEKU_LEAGUE_2F, 0

HaitekuLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, HAITEKU_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 1, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 6, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 12, SPRITE_COOLTRAINER_F, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 10, SPRITE_24, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 7, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuLeague2F_Blocks:: INCBIN "maps/blk/HaitekuLeague2F.blk"

SECTION "data/maps/attributes.asm@HaitekuMart", ROMX
	map_attributes HaitekuMart, HAITEKU_MART, 0

HaitekuMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 4, HAITEKU, wOverworldMapBlocks + 51
	warp_event 5, 7, 4, HAITEKU, wOverworldMapBlocks + 51

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_POKEFAN_M, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_SAILOR, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuMart_Blocks:: INCBIN "maps/blk/HaitekuMart.blk"

SECTION "data/maps/attributes.asm@HaitekuHouse1", ROMX
	map_attributes HaitekuHouse1, HAITEKU_HOUSE_1, 0

HaitekuHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, HAITEKU, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, HAITEKU, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 3, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuHouse1_Blocks:: INCBIN "maps/blk/HaitekuHouse1.blk"

SECTION "data/maps/attributes.asm@HaitekuHouse2", ROMX
	map_attributes HaitekuHouse2, HAITEKU_HOUSE_2, 0

HaitekuHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 6, HAITEKU, wOverworldMapBlocks + 47
	warp_event 5, 7, 6, HAITEKU, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 3, SPRITE_SAILOR, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuHouse2_Blocks:: INCBIN "maps/blk/HaitekuHouse2.blk"

SECTION "data/maps/attributes.asm@HaitekuImposterOakHouse", ROMX
	map_attributes HaitekuImposterOakHouse, HAITEKU_IMPOSTER_OAK_HOUSE, 0

HaitekuImposterOakHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 7, HAITEKU, wOverworldMapBlocks + 47
	warp_event 5, 7, 7, HAITEKU, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_EVIL_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 2, SPRITE_POKEFAN_F, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuImposterOakHouse_Blocks:: INCBIN "maps/blk/HaitekuImposterOakHouse.blk"

SECTION "data/maps/attributes.asm@HaitekuAquarium1F", ROMX
	map_attributes HaitekuAquarium1F, HAITEKU_AQUARIUM_1F, 0

HaitekuAquarium1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 7, 8, HAITEKU, wOverworldMapBlocks + 63
	warp_event 13, 7, 9, HAITEKU, wOverworldMapBlocks + 63
	warp_event 0, 7, 1, HAITEKU_AQUARIUM_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 15, 5, SPRITE_RECEPTIONIST, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12, 2, SPRITE_YOUNGSTER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 5, SPRITE_LASS, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuAquarium1F_Blocks:: INCBIN "maps/blk/HaitekuAquarium1F.blk"

SECTION "data/maps/attributes.asm@HaitekuAquarium2F", ROMX
	map_attributes HaitekuAquarium2F, HAITEKU_AQUARIUM_2F, 0

HaitekuAquarium2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, HAITEKU_AQUARIUM_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 6, SPRITE_POKEFAN_M, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 4, SPRITE_TEACHER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuAquarium2F_Blocks:: INCBIN "maps/blk/HaitekuAquarium2F.blk"

SECTION "data/maps/attributes.asm@FontoRouteGate1", ROMX
	map_attributes FontoRouteGate1, FONTO_ROUTE_GATE_1, 0

FontoRouteGate1_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 0, 7, 7, SOUTH, wOverworldMapBlocks + 45
	warp_event 1, 7, 7, SOUTH, wOverworldMapBlocks + 45
	warp_event 8, 7, 1, FONTO_ROUTE_1, wOverworldMapBlocks + 49
	warp_event 9, 7, 1, FONTO_ROUTE_1, wOverworldMapBlocks + 49

	db 0 ; bg events

	db 0 ; person events

FontoRouteGate1_Blocks:: INCBIN "maps/blk/FontoRouteGate1.blk"

SECTION "data/maps/attributes.asm@FontoRouteGate2", ROMX
	map_attributes FontoRouteGate2, FONTO_ROUTE_GATE_2, 0

FontoRouteGate2_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 8, BAADON, wOverworldMapBlocks + 47
	warp_event 5, 7, 9, BAADON, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, FONTO_ROUTE_4, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, FONTO_ROUTE_4, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

FontoRouteGate2_Blocks:: INCBIN "maps/blk/FontoRouteGate2.blk"

SECTION "data/maps/attributes.asm@FontoRouteGate3", ROMX
	map_attributes FontoRouteGate3, FONTO_ROUTE_GATE_3, 0

FontoRouteGate3_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 5, SOUTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 6, SOUTH, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, FONTO_ROUTE_5, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, FONTO_ROUTE_5, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

FontoRouteGate3_Blocks:: INCBIN "maps/blk/FontoRouteGate3.blk"

SECTION "data/maps/attributes.asm@FontoRocketHouse", ROMX
	map_attributes FontoRocketHouse, FONTO_ROCKET_HOUSE, 0

FontoRocketHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 12, 7, 1, FONTO, wOverworldMapBlocks + 63
	warp_event 13, 7, 1, FONTO, wOverworldMapBlocks + 63

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 4, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 2, SPRITE_ROCKET_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 2, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12, 2, SPRITE_POPPO, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoRocketHouse_Blocks:: INCBIN "maps/blk/FontoRocketHouse.blk"

SECTION "data/maps/attributes.asm@FontoMart", ROMX
	map_attributes FontoMart, FONTO_MART, 0

FontoMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 2, FONTO, wOverworldMapBlocks + 59
	warp_event 5, 7, 2, FONTO, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoMart_Blocks:: INCBIN "maps/blk/FontoMart.blk"

SECTION "data/maps/attributes.asm@FontoHouse", ROMX
	map_attributes FontoHouse, FONTO_HOUSE, 0

FontoHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, FONTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, FONTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 8, 4, SPRITE_GENTLEMAN, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

FontoHouse_Blocks:: INCBIN "maps/blk/FontoHouse.blk"

SECTION "data/maps/attributes.asm@FontoPokecenter1F", ROMX
	map_attributes FontoPokecenter1F, FONTO_POKECENTER_1F, 0

FontoPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 4, FONTO, wOverworldMapBlocks + 59
	warp_event 6, 7, 4, FONTO, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, FONTO_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_24, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoPokecenter1F_Blocks:: INCBIN "maps/blk/FontoPokecenter1F.blk"

SECTION "data/maps/attributes.asm@FontoPokecenter2F", ROMX
	map_attributes FontoPokecenter2F, FONTO_POKECENTER_2F, 0

FontoPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, FONTO_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoPokecenter2F_Blocks:: INCBIN "maps/blk/FontoPokecenter2F.blk"

SECTION "data/maps/attributes.asm@FontoLab", ROMX
	map_attributes FontoLab, FONTO_LAB, 0

FontoLab_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 5, FONTO, wOverworldMapBlocks + 46
	warp_event 4, 7, 5, FONTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 2, 2, SPRITE_SCIENTIST, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 5, SPRITE_SCIENTIST, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoLab_Blocks:: INCBIN "maps/blk/FontoLab.blk"

SECTION "data/maps/attributes.asm@BaadonMart", ROMX
	map_attributes BaadonMart, BAADON_MART, 0

BaadonMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 1, BAADON, wOverworldMapBlocks + 59
	warp_event 5, 7, 1, BAADON, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_YOUNGSTER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_TEACHER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonMart_Blocks:: INCBIN "maps/blk/BaadonMart.blk"

SECTION "data/maps/attributes.asm@BaadonPokecenter1F", ROMX
	map_attributes BaadonPokecenter1F, BAADON_POKECENTER_1F, 0

BaadonPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 2, BAADON, wOverworldMapBlocks + 59
	warp_event 6, 7, 2, BAADON, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, BAADON_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 14, 6, SPRITE_FISHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_GENTLEMAN, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_POKEFAN_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonPokecenter1F_Blocks:: INCBIN "maps/blk/BaadonPokecenter1F.blk"

SECTION "data/maps/attributes.asm@BaadonPokecenter2F", ROMX
	map_attributes BaadonPokecenter2F, BAADON_POKECENTER_2F, 0

BaadonPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, BAADON_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonPokecenter2F_Blocks:: INCBIN "maps/blk/BaadonPokecenter2F.blk"

SECTION "data/maps/attributes.asm@BaadonHouse1", ROMX
	map_attributes BaadonHouse1, BAADON_HOUSE_1, 0

BaadonHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 3, BAADON, wOverworldMapBlocks + 42
	warp_event 4, 7, 3, BAADON, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_ELDER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonHouse1_Blocks:: INCBIN "maps/blk/BaadonHouse1.blk"

SECTION "data/maps/attributes.asm@BaadonWallpaperHouse", ROMX
	map_attributes BaadonWallpaperHouse, BAADON_WALLPAPER_HOUSE, 0

BaadonWallpaperHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 2, 7, 4, BAADON, wOverworldMapBlocks + 42
	warp_event 3, 7, 4, BAADON, wOverworldMapBlocks + 42

	db 0 ; bg events

	db 0 ; person events

BaadonWallpaperHouse_Blocks:: INCBIN "maps/blk/BaadonWallpaperHouse.blk"

SECTION "data/maps/attributes.asm@BaadonHouse2", ROMX
	map_attributes BaadonHouse2, BAADON_HOUSE_2, 0

BaadonHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, BAADON, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, BAADON, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 5, SPRITE_GRANNY, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonHouse2_Blocks:: INCBIN "maps/blk/BaadonHouse2.blk"

SECTION "data/maps/attributes.asm@BaadonLeague1F", ROMX
	map_attributes BaadonLeague1F, BAADON_LEAGUE_1F, 0

BaadonLeague1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 6, BAADON, wOverworldMapBlocks + 82
	warp_event 4, 15, 7, BAADON, wOverworldMapBlocks + 83
	warp_event 7, 1, 1, BAADON_LEAGUE_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

BaadonLeague1F_Blocks:: INCBIN "maps/blk/BaadonLeague1F.blk"

SECTION "data/maps/attributes.asm@BaadonLeague2F", ROMX
	map_attributes BaadonLeague2F, BAADON_LEAGUE_2F, 0

BaadonLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, BAADON_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 2, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 1, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 9, SPRITE_24, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 11, SPRITE_COOLTRAINER_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BaadonLeague2F_Blocks:: INCBIN "maps/blk/BaadonLeague2F.blk"

SECTION "data/maps/attributes.asm@BaadonRouteGateWest", ROMX
	map_attributes BaadonRouteGateWest, BAADON_ROUTE_GATE_WEST, 0

BaadonRouteGateWest_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 11, WEST, wOverworldMapBlocks + 47
	warp_event 5, 7, 12, WEST, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, BAADON_ROUTE_1, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, BAADON_ROUTE_1, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

BaadonRouteGateWest_Blocks:: INCBIN "maps/blk/BaadonRouteGateWest.blk"

SECTION "data/maps/attributes.asm@BaadonRouteGateNewtype", ROMX
	map_attributes BaadonRouteGateNewtype, BAADON_ROUTE_GATE_NEWTYPE, 0

BaadonRouteGateNewtype_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 1, ROUTE_15, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, ROUTE_15, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, BAADON_ROUTE_3, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, BAADON_ROUTE_3, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

BaadonRouteGateNewtype_Blocks:: INCBIN "maps/blk/BaadonRouteGateNewtype.blk"

SECTION "data/maps/attributes.asm@NewtypePokecenter1F", ROMX
	map_attributes NewtypePokecenter1F, NEWTYPE_POKECENTER_1F, 0

NewtypePokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 1, NEWTYPE, wOverworldMapBlocks + 59
	warp_event 6, 7, 1, NEWTYPE, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, NEWTYPE_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypePokecenter1F_Blocks:: INCBIN "maps/blk/NewtypePokecenter1F.blk"

SECTION "data/maps/attributes.asm@NewtypePokecenter2F", ROMX
	map_attributes NewtypePokecenter2F, NEWTYPE_POKECENTER_2F, 0

NewtypePokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, NEWTYPE_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypePokecenter2F_Blocks:: INCBIN "maps/blk/NewtypePokecenter2F.blk"

SECTION "data/maps/attributes.asm@NewtypeLeague1F", ROMX
	map_attributes NewtypeLeague1F, NEWTYPE_LEAGUE_1F, 0

NewtypeLeague1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 2, NEWTYPE, wOverworldMapBlocks + 82
	warp_event 4, 15, 3, NEWTYPE, wOverworldMapBlocks + 83
	warp_event 7, 1, 1, NEWTYPE_LEAGUE_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeLeague1F_Blocks:: INCBIN "maps/blk/NewtypeLeague1F.blk"

SECTION "data/maps/attributes.asm@NewtypeLeague2F", ROMX
	map_attributes NewtypeLeague2F, NEWTYPE_LEAGUE_2F, 0

NewtypeLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, NEWTYPE_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 5, 5, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 0, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 0, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 11, SPRITE_24, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 11, SPRITE_COOLTRAINER_F, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeLeague2F_Blocks:: INCBIN "maps/blk/NewtypeLeague2F.blk"

SECTION "data/maps/attributes.asm@NewtypeSailorHouse", ROMX
	map_attributes NewtypeSailorHouse, NEWTYPE_SAILOR_HOUSE, 0

NewtypeSailorHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 4, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 4, NEWTYPE, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 6, 3, SPRITE_47, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeSailorHouse_Blocks:: INCBIN "maps/blk/NewtypeSailorHouse.blk"

SECTION "data/maps/attributes.asm@NewtypeMart", ROMX
	map_attributes NewtypeMart, NEWTYPE_MART, 0

NewtypeMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, NEWTYPE, wOverworldMapBlocks + 59
	warp_event 5, 7, 5, NEWTYPE, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_POKEFAN_F, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeMart_Blocks:: INCBIN "maps/blk/NewtypeMart.blk"

SECTION "data/maps/attributes.asm@NewtypeDojo", ROMX
	map_attributes NewtypeDojo, NEWTYPE_DOJO, 0

NewtypeDojo_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 15, 6, NEWTYPE, wOverworldMapBlocks + 82
	warp_event 4, 15, 7, NEWTYPE, wOverworldMapBlocks + 83

	db 0 ; bg events

	db 5 ; person events
	object_event 3, 2, SPRITE_BLACKBELT, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 6, SPRITE_BLACKBELT, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 6, SPRITE_BLACKBELT, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 10, SPRITE_BLACKBELT, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 10, SPRITE_BLACKBELT, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeDojo_Blocks:: INCBIN "maps/blk/NewtypeDojo.blk"

SECTION "data/maps/attributes.asm@NewtypeHouse1", ROMX
	map_attributes NewtypeHouse1, NEWTYPE_HOUSE_1, 0

NewtypeHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 8, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 8, NEWTYPE, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 3, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse1_Blocks:: INCBIN "maps/blk/NewtypeHouse1.blk"

SECTION "data/maps/attributes.asm@NewtypeDiner", ROMX
	map_attributes NewtypeDiner, NEWTYPE_DINER, 0

NewtypeDiner_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 2, 7, 9, NEWTYPE, wOverworldMapBlocks + 42
	warp_event 3, 7, 9, NEWTYPE, wOverworldMapBlocks + 42

	db 0 ; bg events

	db 4 ; person events
	object_event 2, 1, SPRITE_CLERK, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 3, SPRITE_GIRL, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 3, SPRITE_SAILOR, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 1, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeDiner_Blocks:: INCBIN "maps/blk/NewtypeDiner.blk"

SECTION "data/maps/attributes.asm@NewtypeHouse2", ROMX
	map_attributes NewtypeHouse2, NEWTYPE_HOUSE_2, 0

NewtypeHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 10, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 10, NEWTYPE, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 4, 3, SPRITE_GENTLEMAN, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse2_Blocks:: INCBIN "maps/blk/NewtypeHouse2.blk"

SECTION "data/maps/attributes.asm@NewtypeHouse3", ROMX
	map_attributes NewtypeHouse3, NEWTYPE_HOUSE_3, 0

NewtypeHouse3_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 11, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 11, NEWTYPE, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 4, 3, SPRITE_GRAMPS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeHouse3_Blocks:: INCBIN "maps/blk/NewtypeHouse3.blk"

SECTION "data/maps/attributes.asm@Route15Pokecenter1F", ROMX
	map_attributes Route15Pokecenter1F, ROUTE_15_POKECENTER_1F, 0

Route15Pokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 3, ROUTE_15, wOverworldMapBlocks + 59
	warp_event 6, 7, 3, ROUTE_15, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, ROUTE_15_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route15Pokecenter1F_Blocks:: INCBIN "maps/blk/Route15Pokecenter1F.blk"

SECTION "data/maps/attributes.asm@Route15Pokecenter2F", ROMX
	map_attributes Route15Pokecenter2F, ROUTE_15_POKECENTER_2F, 0

Route15Pokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, ROUTE_15_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 0 ; person events

Route15Pokecenter2F_Blocks:: INCBIN "maps/blk/Route15Pokecenter2F.blk"

SECTION "data/maps/attributes.asm@NewtypeRouteGate", ROMX
	map_attributes NewtypeRouteGate, NEWTYPE_ROUTE_GATE, 0

NewtypeRouteGate_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 1, ROUTE_18, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, ROUTE_18, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, BULL_FOREST_ROUTE_1, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, BULL_FOREST_ROUTE_1, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

NewtypeRouteGate_Blocks:: INCBIN "maps/blk/NewtypeRouteGate.blk"

SECTION "data/maps/attributes.asm@Route18Pokecenter1F", ROMX
	map_attributes Route18Pokecenter1F, ROUTE_18_POKECENTER_1F, 0

Route18Pokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 3, ROUTE_18, wOverworldMapBlocks + 59
	warp_event 6, 7, 3, ROUTE_18, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, ROUTE_18_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route18Pokecenter1F_Blocks:: INCBIN "maps/blk/Route18Pokecenter1F.blk"

SECTION "data/maps/attributes.asm@Route18Pokecenter2F", ROMX
	map_attributes Route18Pokecenter2F, ROUTE_18_POKECENTER_2F, 0

Route18Pokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, ROUTE_18_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 0 ; person events

Route18Pokecenter2F_Blocks:: INCBIN "maps/blk/Route18Pokecenter2F.blk"

SECTION "data/maps/attributes.asm@SugarRouteGate", ROMX
	map_attributes SugarRouteGate, SUGAR_ROUTE_GATE, 0

SugarRouteGate_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 12, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 5, 7, 13, NEWTYPE, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, SUGAR_ROUTE, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, SUGAR_ROUTE, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

SugarRouteGate_Blocks:: INCBIN "maps/blk/SugarRouteGate.blk"

SECTION "data/maps/attributes.asm@SugarHouse", ROMX
	map_attributes SugarHouse, SUGAR_HOUSE, 0

SugarHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 15, 1, SUGAR, wOverworldMapBlocks + 82
	warp_event 4, 15, 1, SUGAR, wOverworldMapBlocks + 83

	db 0 ; bg events

	db 3 ; person events
	object_event 3, 5, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 5, SPRITE_TWIN, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_GRAMPS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarHouse_Blocks:: INCBIN "maps/blk/SugarHouse.blk"

SECTION "data/maps/attributes.asm@SugarHouse2", ROMX
	map_attributes SugarHouse2, SUGAR_HOUSE_2, 0

SugarHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 2, SUGAR, wOverworldMapBlocks + 42
	warp_event 4, 7, 2, SUGAR, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_FISHING_GURU, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarHouse2_Blocks:: INCBIN "maps/blk/SugarHouse2.blk"

SECTION "data/maps/attributes.asm@SugarMart", ROMX
	map_attributes SugarMart, SUGAR_MART, 0

SugarMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, SUGAR, wOverworldMapBlocks + 59
	warp_event 5, 7, 3, SUGAR, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarMart_Blocks:: INCBIN "maps/blk/SugarMart.blk"

SECTION "data/maps/attributes.asm@SugarPokecenter1F", ROMX
	map_attributes SugarPokecenter1F, SUGAR_POKECENTER_1F, 0

SugarPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 4, SUGAR, wOverworldMapBlocks + 59
	warp_event 6, 7, 4, SUGAR, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, SUGAR_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_24, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarPokecenter1F_Blocks:: INCBIN "maps/blk/SugarPokecenter1F.blk"

SECTION "data/maps/attributes.asm@SugarPokecenter2F", ROMX
	map_attributes SugarPokecenter2F, SUGAR_POKECENTER_2F, 0

SugarPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, SUGAR_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarPokecenter2F_Blocks:: INCBIN "maps/blk/SugarPokecenter2F.blk"

SECTION "data/maps/attributes.asm@BullForestRoute1House", ROMX
	map_attributes BullForestRoute1House, BULL_FOREST_ROUTE_1_HOUSE, 0

BullForestRoute1House_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, BULL_FOREST_ROUTE_1, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, BULL_FOREST_ROUTE_1, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 1, 5, SPRITE_COOLTRAINER_F, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullForestRoute1House_Blocks:: INCBIN "maps/blk/BullForestRoute1House.blk"

SECTION "data/maps/attributes.asm@BullForestRouteGateStand", ROMX
	map_attributes BullForestRouteGateStand, BULL_FOREST_ROUTE_GATE_STAND, 0

BullForestRouteGateStand_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 9, STAND, wOverworldMapBlocks + 47
	warp_event 5, 7, 10, STAND, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, BULL_FOREST_ROUTE_2, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, BULL_FOREST_ROUTE_2, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

BullForestRouteGateStand_Blocks:: INCBIN "maps/blk/BullForestRouteGateStand.blk"

SECTION "data/maps/attributes.asm@BullMart", ROMX
	map_attributes BullMart, BULL_MART, 0

BullMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 1, BULL_FOREST, wOverworldMapBlocks + 59
	warp_event 5, 7, 1, BULL_FOREST, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_FISHER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullMart_Blocks:: INCBIN "maps/blk/BullMart.blk"

SECTION "data/maps/attributes.asm@BullHouse1", ROMX
	map_attributes BullHouse1, BULL_HOUSE_1, 0

BullHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 2, BULL_FOREST, wOverworldMapBlocks + 42
	warp_event 4, 7, 2, BULL_FOREST, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_KIKUKO, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse1_Blocks:: INCBIN "maps/blk/BullHouse1.blk"

SECTION "data/maps/attributes.asm@BullHouse2", ROMX
	map_attributes BullHouse2, BULL_HOUSE_2, 0

BullHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, BULL_FOREST, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, BULL_FOREST, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 8, 4, SPRITE_GRANNY, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse2_Blocks:: INCBIN "maps/blk/BullHouse2.blk"

SECTION "data/maps/attributes.asm@BullHouse3", ROMX
	map_attributes BullHouse3, BULL_HOUSE_3, 0

BullHouse3_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 4, BULL_FOREST, wOverworldMapBlocks + 47
	warp_event 5, 7, 4, BULL_FOREST, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 4, 3, SPRITE_GRAMPS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullHouse3_Blocks:: INCBIN "maps/blk/BullHouse3.blk"

SECTION "data/maps/attributes.asm@BullPokecenter1F", ROMX
	map_attributes BullPokecenter1F, BULL_POKECENTER_1F, 0

BullPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 5, BULL_FOREST, wOverworldMapBlocks + 59
	warp_event 6, 7, 5, BULL_FOREST, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, BULL_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_24, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullPokecenter1F_Blocks:: INCBIN "maps/blk/BullPokecenter1F.blk"

SECTION "data/maps/attributes.asm@BullPokecenter2F", ROMX
	map_attributes BullPokecenter2F, BULL_POKECENTER_2F, 0

BullPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, BULL_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullPokecenter2F_Blocks:: INCBIN "maps/blk/BullPokecenter2F.blk"

SECTION "data/maps/attributes.asm@BullLeague1F", ROMX
	map_attributes BullLeague1F, BULL_LEAGUE_1F, 0

BullLeague1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 6, BULL_FOREST, wOverworldMapBlocks + 82
	warp_event 4, 15, 7, BULL_FOREST, wOverworldMapBlocks + 83
	warp_event 7, 1, 1, BULL_LEAGUE_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

BullLeague1F_Blocks:: INCBIN "maps/blk/BullLeague1F.blk"

SECTION "data/maps/attributes.asm@BullLeague2F", ROMX
	map_attributes BullLeague2F, BULL_LEAGUE_2F, 0

BullLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, BULL_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 4, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 9, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 9, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 11, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 11, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

BullLeague2F_Blocks:: INCBIN "maps/blk/BullLeague2F.blk"

SECTION "data/maps/attributes.asm@BullHouse4", ROMX
	map_attributes BullHouse4, BULL_HOUSE_4, 0

BullHouse4_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 8, BULL_FOREST, wOverworldMapBlocks + 47
	warp_event 5, 7, 8, BULL_FOREST, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 0 ; person events

BullHouse4_Blocks:: INCBIN "maps/blk/BullHouse4.blk"

SECTION "data/maps/attributes.asm@StandRouteGateKanto", ROMX
	map_attributes StandRouteGateKanto, STAND_ROUTE_GATE_KANTO, 0

StandRouteGateKanto_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 4, 7, 1, KANTO_EAST_ROUTE, wOverworldMapBlocks + 47
	warp_event 5, 7, 2, KANTO_EAST_ROUTE, wOverworldMapBlocks + 47
	warp_event 4, 0, 1, STAND_ROUTE, wOverworldMapBlocks + 14
	warp_event 5, 0, 2, STAND_ROUTE, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

StandRouteGateKanto_Blocks:: INCBIN "maps/blk/StandRouteGateKanto.blk"

SECTION "data/maps/attributes.asm@StandLab", ROMX
	map_attributes StandLab, STAND_LAB, 0

StandLab_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 1, STAND, wOverworldMapBlocks + 42
	warp_event 4, 7, 1, STAND, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandLab_Blocks:: INCBIN "maps/blk/StandLab.blk"

SECTION "data/maps/attributes.asm@StandPokecenter1F", ROMX
	map_attributes StandPokecenter1F, STAND_POKECENTER_1F, 0

StandPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 2, STAND, wOverworldMapBlocks + 59
	warp_event 6, 7, 2, STAND, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, STAND_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GIRL, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_GENTLEMAN, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_LASS, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandPokecenter1F_Blocks:: INCBIN "maps/blk/StandPokecenter1F.blk"

SECTION "data/maps/attributes.asm@StandPokecenter2F", ROMX
	map_attributes StandPokecenter2F, STAND_POKECENTER_2F, 0

StandPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, STAND_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandPokecenter2F_Blocks:: INCBIN "maps/blk/StandPokecenter2F.blk"

SECTION "data/maps/attributes.asm@StandOffice", ROMX
	map_attributes StandOffice, STAND_OFFICE, 0

StandOffice_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 2, 7, 3, STAND, wOverworldMapBlocks + 58
	warp_event 3, 7, 3, STAND, wOverworldMapBlocks + 58

	db 0 ; bg events

	db 3 ; person events
	object_event 13, 4, SPRITE_ROCKER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 6, SPRITE_SUPER_NERD, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 7, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandOffice_Blocks:: INCBIN "maps/blk/StandOffice.blk"

SECTION "data/maps/attributes.asm@StandMart", ROMX
	map_attributes StandMart, STAND_MART, 0

StandMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 4, STAND, wOverworldMapBlocks + 59
	warp_event 5, 7, 4, STAND, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandMart_Blocks:: INCBIN "maps/blk/StandMart.blk"

SECTION "data/maps/attributes.asm@StandHouse", ROMX
	map_attributes StandHouse, STAND_HOUSE, 0

StandHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, STAND, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, STAND, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_SUPER_NERD, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

StandHouse_Blocks:: INCBIN "maps/blk/StandHouse.blk"

SECTION "data/maps/attributes.asm@StandRocketHouse1F", ROMX
	map_attributes StandRocketHouse1F, STAND_ROCKET_HOUSE_1F, 0

StandRocketHouse1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 2, 7, 6, STAND, wOverworldMapBlocks + 58
	warp_event 3, 7, 6, STAND, wOverworldMapBlocks + 58
	warp_event 15, 1, 1, STAND_ROCKET_HOUSE_2F, wOverworldMapBlocks + 22

	db 0 ; bg events

	db 1 ; person events
	object_event 11, 4, SPRITE_36, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandRocketHouse1F_Blocks:: INCBIN "maps/blk/StandRocketHouse1F.blk"

SECTION "data/maps/attributes.asm@StandRocketHouse2F", ROMX
	map_attributes StandRocketHouse2F, STAND_ROCKET_HOUSE_2F, 0

StandRocketHouse2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 15, 1, 3, STAND_ROCKET_HOUSE_1F, wOverworldMapBlocks + 22

	db 0 ; bg events

	db 1 ; person events
	object_event 5, 4, SPRITE_ROCKET_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

StandRocketHouse2F_Blocks:: INCBIN "maps/blk/StandRocketHouse2F.blk"

SECTION "data/maps/attributes.asm@StandLeague1F", ROMX
	map_attributes StandLeague1F, STAND_LEAGUE_1F, 0

StandLeague1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 7, STAND, wOverworldMapBlocks + 82
	warp_event 4, 15, 8, STAND, wOverworldMapBlocks + 83
	warp_event 7, 1, 1, STAND_LEAGUE_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

StandLeague1F_Blocks:: INCBIN "maps/blk/StandLeague1F.blk"

SECTION "data/maps/attributes.asm@StandLeague2F", ROMX
	map_attributes StandLeague2F, STAND_LEAGUE_2F, 0

StandLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, STAND_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 7, SPRITE_POKEFAN_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_24, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 6, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 6, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 1, SPRITE_COOLTRAINER_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandLeague2F_Blocks:: INCBIN "maps/blk/StandLeague2F.blk"

SECTION "data/maps/attributes.asm@KantoCeruleanHouse", ROMX
	map_attributes KantoCeruleanHouse, KANTO_CERULEAN_HOUSE, 0

KantoCeruleanHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 1, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 1, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 3, 3, SPRITE_FISHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeruleanHouse_Blocks:: INCBIN "maps/blk/KantoCeruleanHouse.blk"

SECTION "data/maps/attributes.asm@KantoPokecenter1F", ROMX
	map_attributes KantoPokecenter1F, KANTO_POKECENTER_1F, 0

KantoPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 2, KANTO, wOverworldMapBlocks + 59
	warp_event 6, 7, 2, KANTO, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, KANTO_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_YOUNGSTER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_24, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoPokecenter1F_Blocks:: INCBIN "maps/blk/KantoPokecenter1F.blk"

SECTION "data/maps/attributes.asm@KantoPokecenter2F", ROMX
	map_attributes KantoPokecenter2F, KANTO_POKECENTER_2F, 0

KantoPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, KANTO_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoPokecenter2F_Blocks:: INCBIN "maps/blk/KantoPokecenter2F.blk"

SECTION "data/maps/attributes.asm@KantoLeague1F", ROMX
	map_attributes KantoLeague1F, KANTO_LEAGUE_1F, 0

KantoLeague1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 3, KANTO, wOverworldMapBlocks + 82
	warp_event 4, 15, 4, KANTO, wOverworldMapBlocks + 83
	warp_event 7, 1, 1, KANTO_LEAGUE_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

KantoLeague1F_Blocks:: INCBIN "maps/blk/KantoLeague1F.blk"

SECTION "data/maps/attributes.asm@KantoLeague2F", ROMX
	map_attributes KantoLeague2F, KANTO_LEAGUE_2F, 0

KantoLeague2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, KANTO_LEAGUE_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 7, SPRITE_RED, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_24, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 6, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 6, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 1, SPRITE_COOLTRAINER_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoLeague2F_Blocks:: INCBIN "maps/blk/KantoLeague2F.blk"

SECTION "data/maps/attributes.asm@KantoLavenderHouse", ROMX
	map_attributes KantoLavenderHouse, KANTO_LAVENDER_HOUSE, 0

KantoLavenderHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 5, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 5, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_POKEFAN_M, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_POKEFAN_F, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoLavenderHouse_Blocks:: INCBIN "maps/blk/KantoLavenderHouse.blk"

SECTION "data/maps/attributes.asm@KantoCeladonMart1F", ROMX
	map_attributes KantoCeladonMart1F, KANTO_CELADON_MART_1F, 0

KantoCeladonMart1F_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 13, 7, 6, KANTO, wOverworldMapBlocks + 63
	warp_event 14, 7, 7, KANTO, wOverworldMapBlocks + 64
	warp_event 15, 0, 2, KANTO_CELADON_MART_2F, wOverworldMapBlocks + 22
	warp_event 2, 0, 2, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 1 ; person events
	object_event 7, 1, SPRITE_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart1F_Blocks:: INCBIN "maps/blk/KantoCeladonMart1F.blk"

SECTION "data/maps/attributes.asm@KantoCeladonMart2F", ROMX
	map_attributes KantoCeladonMart2F, KANTO_CELADON_MART_2F, 0

KantoCeladonMart2F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, KANTO_CELADON_MART_3F, wOverworldMapBlocks + 21
	warp_event 15, 0, 3, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 2 ; person events
	object_event 14, 5, SPRITE_CLERK, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 5, SPRITE_LASS, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart2F_Blocks:: INCBIN "maps/blk/KantoCeladonMart2F.blk"

SECTION "data/maps/attributes.asm@KantoCeladonMart3F", ROMX
	map_attributes KantoCeladonMart3F, KANTO_CELADON_MART_3F, 0

KantoCeladonMart3F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, KANTO_CELADON_MART_2F, wOverworldMapBlocks + 21
	warp_event 15, 0, 2, KANTO_CELADON_MART_4F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 2 ; person events
	object_event 6, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 5, SPRITE_GIRL, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart3F_Blocks:: INCBIN "maps/blk/KantoCeladonMart3F.blk"

SECTION "data/maps/attributes.asm@KantoCeladonMart4F", ROMX
	map_attributes KantoCeladonMart4F, KANTO_CELADON_MART_4F, 0

KantoCeladonMart4F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 0, 1, KANTO_CELADON_MART_5F, wOverworldMapBlocks + 21
	warp_event 15, 0, 2, KANTO_CELADON_MART_3F, wOverworldMapBlocks + 22
	warp_event 2, 0, 1, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 3 ; person events
	object_event 14, 5, SPRITE_MEDIUM, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 5, SPRITE_MEDIUM, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_MEDIUM, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart4F_Blocks:: INCBIN "maps/blk/KantoCeladonMart4F.blk"

SECTION "data/maps/attributes.asm@KantoCeladonMart5F", ROMX
	map_attributes KantoCeladonMart5F, KANTO_CELADON_MART_5F, 0

KantoCeladonMart5F_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 13, 0, 1, KANTO_CELADON_MART_4F, wOverworldMapBlocks + 21
	warp_event 2, 0, 1, KANTO_CELADON_ELEVATOR, wOverworldMapBlocks + 16

	db 0 ; bg events

	db 3 ; person events
	object_event 14, 5, SPRITE_CLERK, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 3, SPRITE_SIDON, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart5F_Blocks:: INCBIN "maps/blk/KantoCeladonMart5F.blk"

SECTION "data/maps/attributes.asm@KantoCeladonElevator", ROMX
	map_attributes KantoCeladonElevator, KANTO_CELADON_ELEVATOR, 0

KantoCeladonElevator_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 1, 3, 4, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 17
	warp_event 2, 3, 4, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 18

	db 0 ; bg events

	db 0 ; person events

KantoCeladonElevator_Blocks:: INCBIN "maps/blk/KantoCeladonElevator.blk"

SECTION "data/maps/attributes.asm@KantoMart", ROMX
	map_attributes KantoMart, KANTO_MART, 0

KantoMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 8, KANTO, wOverworldMapBlocks + 59
	warp_event 5, 7, 8, KANTO, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_TWIN, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_GRAMPS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoMart_Blocks:: INCBIN "maps/blk/KantoMart.blk"

SECTION "data/maps/attributes.asm@KantoGamefreakHQ1", ROMX
	map_attributes KantoGamefreakHQ1, KANTO_GAMEFREAK_HQ_1, 0

KantoGamefreakHQ1_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 4, 11, 9, KANTO, wOverworldMapBlocks + 63
	warp_event 5, 11, 10, KANTO, wOverworldMapBlocks + 63
	warp_event 7, 1, 2, KANTO_GAMEFREAK_HQ_2, wOverworldMapBlocks + 14
	warp_event 2, 1, 3, KANTO_GAMEFREAK_HQ_2, wOverworldMapBlocks + 12
	warp_event 4, 0, 30, KANTO, wOverworldMapBlocks + 13

	db 0 ; bg events

	db 4 ; person events
	object_event 1, 5, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 5, SPRITE_SIDON, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 8, SPRITE_PIPPI, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 7, SPRITE_POPPO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ1_Blocks:: INCBIN "maps/blk/KantoGamefreakHQ1.blk"

SECTION "data/maps/attributes.asm@KantoGamefreakHQ2", ROMX
	map_attributes KantoGamefreakHQ2, KANTO_GAMEFREAK_HQ_2, 0

KantoGamefreakHQ2_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 6, 1, 1, KANTO_GAMEFREAK_HQ_3, wOverworldMapBlocks + 14
	warp_event 7, 1, 3, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 14
	warp_event 2, 1, 4, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 12
	warp_event 4, 1, 4, KANTO_GAMEFREAK_HQ_3, wOverworldMapBlocks + 13

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 4, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ2_Blocks:: INCBIN "maps/blk/KantoGamefreakHQ2.blk"

SECTION "data/maps/attributes.asm@KantoGamefreakHQ3", ROMX
	map_attributes KantoGamefreakHQ3, KANTO_GAMEFREAK_HQ_3, 0

KantoGamefreakHQ3_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 6, 1, 1, KANTO_GAMEFREAK_HQ_2, wOverworldMapBlocks + 14
	warp_event 7, 1, 2, KANTO_GAMEFREAK_HQ_4, wOverworldMapBlocks + 14
	warp_event 2, 1, 3, KANTO_GAMEFREAK_HQ_4, wOverworldMapBlocks + 12
	warp_event 4, 1, 4, KANTO_GAMEFREAK_HQ_2, wOverworldMapBlocks + 13

	db 0 ; bg events

	db 3 ; person events
	object_event 0, 5, SPRITE_GYM_GUY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 7, SPRITE_BURGLAR, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 7, SPRITE_FISHER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGamefreakHQ3_Blocks:: INCBIN "maps/blk/KantoGamefreakHQ3.blk"

SECTION "data/maps/attributes.asm@KantoGamefreakHQ4", ROMX
	map_attributes KantoGamefreakHQ4, KANTO_GAMEFREAK_HQ_4, 0

KantoGamefreakHQ4_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 2, 7, 1, KANTO_GAMEFREAK_HQ_5, wOverworldMapBlocks + 42
	warp_event 6, 1, 2, KANTO_GAMEFREAK_HQ_3, wOverworldMapBlocks + 14
	warp_event 2, 1, 3, KANTO_GAMEFREAK_HQ_3, wOverworldMapBlocks + 12

	db 0 ; bg events

	db 0 ; person events

KantoGamefreakHQ4_Blocks:: INCBIN "maps/blk/KantoGamefreakHQ4.blk"

SECTION "data/maps/attributes.asm@KantoGamefreakHQ5", ROMX
	map_attributes KantoGamefreakHQ5, KANTO_GAMEFREAK_HQ_5, 0

KantoGamefreakHQ5_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 1, KANTO_GAMEFREAK_HQ_4, wOverworldMapBlocks + 42
	warp_event 4, 7, 1, KANTO_GAMEFREAK_HQ_4, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 0 ; person events

KantoGamefreakHQ5_Blocks:: INCBIN "maps/blk/KantoGamefreakHQ5.blk"

SECTION "data/maps/attributes.asm@KantoSilphCo", ROMX
	map_attributes KantoSilphCo, KANTO_SILPH_CO, 0

KantoSilphCo_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 6, 15, 11, KANTO, wOverworldMapBlocks + 148
	warp_event 7, 15, 12, KANTO, wOverworldMapBlocks + 148

	db 0 ; bg events

	db 2 ; person events
	object_event 2, 2, SPRITE_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22, 1, SPRITE_OFFICER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoSilphCo_Blocks:: INCBIN "maps/blk/KantoSilphCo.blk"

SECTION "data/maps/attributes.asm@KantoViridianHouse", ROMX
	map_attributes KantoViridianHouse, KANTO_VIRIDIAN_HOUSE, 0

KantoViridianHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 13, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 13, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_TWIN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoViridianHouse_Blocks:: INCBIN "maps/blk/KantoViridianHouse.blk"

SECTION "data/maps/attributes.asm@KantoGameCorner", ROMX
	map_attributes KantoGameCorner, KANTO_GAME_CORNER, 0

KantoGameCorner_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 8, 13, 14, KANTO, wOverworldMapBlocks + 117
	warp_event 9, 13, 14, KANTO, wOverworldMapBlocks + 117
	warp_event 10, 13, 14, KANTO, wOverworldMapBlocks + 118
	warp_event 11, 13, 14, KANTO, wOverworldMapBlocks + 118

	db 0 ; bg events

	db 10 ; person events
	object_event 3, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 6, SPRITE_POKEFAN_M, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 7, SPRITE_TWIN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 8, SPRITE_ROCKER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11, 6, SPRITE_GIRL, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11, 8, SPRITE_GRAMPS, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_FISHER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 17, 9, SPRITE_POKEFAN_M, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 2, SPRITE_ROCKER, SLOW_STEP_DOWN, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGameCorner_Blocks:: INCBIN "maps/blk/KantoGameCorner.blk"

SECTION "data/maps/attributes.asm@KantoUnusedArea", ROMX
	map_attributes KantoUnusedArea, KANTO_UNUSED_AREA, 0

KantoUnusedArea_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

KantoUnusedArea_Blocks:: INCBIN "maps/blk/KantoUnusedArea.blk"

SECTION "data/maps/attributes.asm@KantoGameCornerPrizes", ROMX
	map_attributes KantoGameCornerPrizes, KANTO_GAME_CORNER_PRIZES, 0

KantoGameCornerPrizes_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 15, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 15, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 3 ; person events
	object_event 2, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 1, SPRITE_CLERK, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGameCornerPrizes_Blocks:: INCBIN "maps/blk/KantoGameCornerPrizes.blk"

SECTION "data/maps/attributes.asm@KantoDiner", ROMX
	map_attributes KantoDiner, KANTO_DINER, 0

KantoDiner_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 16, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 16, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 0 ; person events

KantoDiner_Blocks:: INCBIN "maps/blk/KantoDiner.blk"

SECTION "data/maps/attributes.asm@KantoSchool", ROMX
	map_attributes KantoSchool, KANTO_SCHOOL, 0

KantoSchool_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 15, 17, KANTO, wOverworldMapBlocks + 82
	warp_event 4, 15, 18, KANTO, wOverworldMapBlocks + 83

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

KantoSchool_Blocks:: INCBIN "maps/blk/KantoSchool.blk"

SECTION "data/maps/attributes.asm@KantoHospital", ROMX
	map_attributes KantoHospital, KANTO_HOSPITAL, 0

KantoHospital_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 1, 7, 19, KANTO, wOverworldMapBlocks + 57
	warp_event 2, 7, 19, KANTO, wOverworldMapBlocks + 58

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 6, SPRITE_ROCKER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12, 6, SPRITE_GIRL, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoHospital_Blocks:: INCBIN "maps/blk/KantoHospital.blk"

SECTION "data/maps/attributes.asm@KantoPokecenter21F", ROMX
	map_attributes KantoPokecenter21F, KANTO_POKECENTER_2_1F, 0

KantoPokecenter21F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 20, KANTO, wOverworldMapBlocks + 59
	warp_event 6, 7, 20, KANTO, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, KANTO_POKECENTER_2_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_24, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoPokecenter21F_Blocks:: INCBIN "maps/blk/KantoPokecenter21F.blk"

SECTION "data/maps/attributes.asm@KantoPokecenter22F", ROMX
	map_attributes KantoPokecenter22F, KANTO_POKECENTER_2_2F, 0

KantoPokecenter22F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, KANTO_POKECENTER_2_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoPokecenter22F_Blocks:: INCBIN "maps/blk/KantoPokecenter22F.blk"

SECTION "data/maps/attributes.asm@KantoRedsHouse", ROMX
	map_attributes KantoRedsHouse, KANTO_REDS_HOUSE, 0

KantoRedsHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 21, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 21, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_SUPER_NERD, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_TEACHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoRedsHouse_Blocks:: INCBIN "maps/blk/KantoRedsHouse.blk"

SECTION "data/maps/attributes.asm@KantoGreensHouse1F", ROMX
	map_attributes KantoGreensHouse1F, KANTO_GREENS_HOUSE_1F, 0

KantoGreensHouse1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 2, 7, 22, KANTO, wOverworldMapBlocks + 42
	warp_event 3, 7, 22, KANTO, wOverworldMapBlocks + 42
	warp_event 7, 1, 1, KANTO_GREENS_HOUSE_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 1 ; person events
	object_event 5, 3, SPRITE_0F, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGreensHouse1F_Blocks:: INCBIN "maps/blk/KantoGreensHouse1F.blk"

SECTION "data/maps/attributes.asm@KantoGreensHouse2F", ROMX
	map_attributes KantoGreensHouse2F, KANTO_GREENS_HOUSE_2F, 0

KantoGreensHouse2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 1, 3, KANTO_GREENS_HOUSE_1F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 0 ; person events

KantoGreensHouse2F_Blocks:: INCBIN "maps/blk/KantoGreensHouse2F.blk"

SECTION "data/maps/attributes.asm@KantoEldersHouse", ROMX
	map_attributes KantoEldersHouse, KANTO_ELDERS_HOUSE, 0

KantoEldersHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 23, KANTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 23, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 2 ; person events
	object_event 7, 3, SPRITE_GRAMPS, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 5, SPRITE_GRANNY, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoEldersHouse_Blocks:: INCBIN "maps/blk/KantoEldersHouse.blk"

SECTION "data/maps/attributes.asm@KantoOaksLab", ROMX
	map_attributes KantoOaksLab, KANTO_OAKS_LAB, 0

KantoOaksLab_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 24, KANTO, wOverworldMapBlocks + 42
	warp_event 4, 7, 25, KANTO, wOverworldMapBlocks + 43

	db 0 ; bg events

	db 1 ; person events
	object_event 3, 2, SPRITE_NANAMI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoOaksLab_Blocks:: INCBIN "maps/blk/KantoOaksLab.blk"

SECTION "data/maps/attributes.asm@KantoLeague21F", ROMX
	map_attributes KantoLeague21F, KANTO_LEAGUE_2_1F, 0

KantoLeague21F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 26, KANTO, wOverworldMapBlocks + 82
	warp_event 4, 15, 27, KANTO, wOverworldMapBlocks + 83
	warp_event 7, 1, 1, KANTO_LEAGUE_2_2F, wOverworldMapBlocks + 14

	db 0 ; bg events

	db 5 ; person events
	object_event 2, 5, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 7, SPRITE_LASS, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 1, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_COOLTRAINER_F, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

KantoLeague21F_Blocks:: INCBIN "maps/blk/KantoLeague21F.blk"

SECTION "data/maps/attributes.asm@KantoLeague22F", ROMX
	map_attributes KantoLeague22F, KANTO_LEAGUE_2_2F, 0

KantoLeague22F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 7, 15, 3, KANTO_LEAGUE_2_1F, wOverworldMapBlocks + 92

	db 0 ; bg events

	db 5 ; person events
	object_event 4, 7, SPRITE_POKEFAN_M, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_24, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 6, SPRITE_COOLTRAINER_F, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 6, SPRITE_24, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 1, SPRITE_COOLTRAINER_F, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoLeague22F_Blocks:: INCBIN "maps/blk/KantoLeague22F.blk"

SECTION "data/maps/attributes.asm@KantoFishingGuru", ROMX
	map_attributes KantoFishingGuru, KANTO_FISHING_GURU, 0

KantoFishingGuru_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 28, KANTO, wOverworldMapBlocks + 46
	warp_event 4, 7, 28, KANTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 4, 3, SPRITE_FISHING_GURU, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoFishingGuru_Blocks:: INCBIN "maps/blk/KantoFishingGuru.blk"

SECTION "data/maps/attributes.asm@SouthHouse1", ROMX
	map_attributes SouthHouse1, SOUTH_HOUSE_1, 0

SouthHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 1, SOUTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 1, SOUTH, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthHouse1_Blocks:: INCBIN "maps/blk/SouthHouse1.blk"

SECTION "data/maps/attributes.asm@SouthPokecenter1F", ROMX
	map_attributes SouthPokecenter1F, SOUTH_POKECENTER_1F, 0

SouthPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 2, SOUTH, wOverworldMapBlocks + 59
	warp_event 6, 7, 2, SOUTH, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, SOUTH_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_24, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthPokecenter1F_Blocks:: INCBIN "maps/blk/SouthPokecenter1F.blk"

SECTION "data/maps/attributes.asm@SouthPokecenter2F", ROMX
	map_attributes SouthPokecenter2F, SOUTH_POKECENTER_2F, 0

SouthPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, SOUTH_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthPokecenter2F_Blocks:: INCBIN "maps/blk/SouthPokecenter2F.blk"

SECTION "data/maps/attributes.asm@SouthMart", ROMX
	map_attributes SouthMart, SOUTH_MART, 0

SouthMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, SOUTH, wOverworldMapBlocks + 59
	warp_event 5, 7, 3, SOUTH, wOverworldMapBlocks + 59

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthMart_Blocks:: INCBIN "maps/blk/SouthMart.blk"

SECTION "data/maps/attributes.asm@SouthHouse2", ROMX
	map_attributes SouthHouse2, SOUTH_HOUSE_2, 0

SouthHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 4, SOUTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 4, SOUTH, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 1, 2, SPRITE_FISHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

SouthHouse2_Blocks:: INCBIN "maps/blk/SouthHouse2.blk"

SECTION "data/maps/attributes.asm@NorthHouse1", ROMX
	map_attributes NorthHouse1, NORTH_HOUSE_1, 0

NorthHouse1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 1, NORTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 1, NORTH, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_TWIN, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthHouse1_Blocks:: INCBIN "maps/blk/NorthHouse1.blk"

SECTION "data/maps/attributes.asm@NorthMart", ROMX
	map_attributes NorthMart, NORTH_MART, 0

NorthMart_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 2, NORTH, wOverworldMapBlocks + 51
	warp_event 5, 7, 2, NORTH, wOverworldMapBlocks + 51

	db 0 ; bg events

	db 3 ; person events
	object_event 1, 3, SPRITE_CLERK, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 5, SPRITE_GIRL, FACE_RIGHT, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 1, SPRITE_POKEFAN_M, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthMart_Blocks:: INCBIN "maps/blk/NorthMart.blk"

SECTION "data/maps/attributes.asm@NorthHouse2", ROMX
	map_attributes NorthHouse2, NORTH_HOUSE_2, 0

NorthHouse2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, NORTH, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, NORTH, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 2, 3, SPRITE_TWIN, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthHouse2_Blocks:: INCBIN "maps/blk/NorthHouse2.blk"

SECTION "data/maps/attributes.asm@NorthPokecenter1F", ROMX
	map_attributes NorthPokecenter1F, NORTH_POKECENTER_1F, 0

NorthPokecenter1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 5, 7, 4, NORTH, wOverworldMapBlocks + 59
	warp_event 6, 7, 4, NORTH, wOverworldMapBlocks + 60
	warp_event 0, 7, 1, NORTH_POKECENTER_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 4 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_24, FACE_RIGHT, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthPokecenter1F_Blocks:: INCBIN "maps/blk/NorthPokecenter1F.blk"

SECTION "data/maps/attributes.asm@NorthPokecenter2F", ROMX
	map_attributes NorthPokecenter2F, NORTH_POKECENTER_2F, 0

NorthPokecenter2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 0, 7, 3, NORTH_POKECENTER_1F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 5, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 2, SPRITE_LINK_RECEPTIONIST, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 7, SPRITE_FISHING_GURU, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NorthPokecenter2F_Blocks:: INCBIN "maps/blk/NorthPokecenter2F.blk"

SECTION "data/maps/attributes.asm@PowerPlant1", ROMX
	map_attributes PowerPlant1, POWER_PLANT_1, 0

PowerPlant1_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PowerPlant1_Blocks:: INCBIN "maps/blk/PowerPlant1.blk"

SECTION "data/maps/attributes.asm@PowerPlant2", ROMX
	map_attributes PowerPlant2, POWER_PLANT_2, 0

PowerPlant2_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PowerPlant2_Blocks:: INCBIN "maps/blk/PowerPlant2.blk"

SECTION "data/maps/attributes.asm@PowerPlant3", ROMX
	map_attributes PowerPlant3, POWER_PLANT_3, 0

PowerPlant3_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PowerPlant3_Blocks:: INCBIN "maps/blk/PowerPlant3.blk"

SECTION "data/maps/attributes.asm@PowerPlant4", ROMX
	map_attributes PowerPlant4, POWER_PLANT_4, 0

PowerPlant4_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PowerPlant4_Blocks:: INCBIN "maps/blk/PowerPlant4.blk"

SECTION "data/maps/attributes.asm@RuinsOfAlphEntrance", ROMX
	map_attributes RuinsOfAlphEntrance, RUINS_OF_ALPH_ENTRANCE, 0

RuinsOfAlphEntrance_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

RuinsOfAlphEntrance_Blocks:: INCBIN "maps/blk/RuinsOfAlphEntrance.blk"

SECTION "data/maps/attributes.asm@RuinsOfAlphMain", ROMX
	map_attributes RuinsOfAlphMain, RUINS_OF_ALPH_MAIN, 0

RuinsOfAlphMain_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

RuinsOfAlphMain_Blocks:: INCBIN "maps/blk/RuinsOfAlphMain.blk"

SECTION "data/maps/attributes.asm@CaveMinecarts1", ROMX
	map_attributes CaveMinecarts1, CAVE_MINECARTS_1, 0

CaveMinecarts1_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts1_Blocks:: INCBIN "maps/blk/CaveMinecarts1.blk"

SECTION "data/maps/attributes.asm@CaveMinecarts2", ROMX
	map_attributes CaveMinecarts2, CAVE_MINECARTS_2, 0

CaveMinecarts2_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts2_Blocks:: INCBIN "maps/blk/CaveMinecarts2.blk"

SECTION "data/maps/attributes.asm@CaveMinecarts3", ROMX
	map_attributes CaveMinecarts3, CAVE_MINECARTS_3, 0

CaveMinecarts3_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts3_Blocks:: INCBIN "maps/blk/CaveMinecarts3.blk"

SECTION "data/maps/attributes.asm@CaveMinecarts4", ROMX
	map_attributes CaveMinecarts4, CAVE_MINECARTS_4, 0

CaveMinecarts4_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts4_Blocks:: INCBIN "maps/blk/CaveMinecarts4.blk"

SECTION "data/maps/attributes.asm@CaveMinecarts5", ROMX
	map_attributes CaveMinecarts5, CAVE_MINECARTS_5, 0

CaveMinecarts5_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts5_Blocks:: INCBIN "maps/blk/CaveMinecarts5.blk"

SECTION "data/maps/attributes.asm@CaveMinecarts6", ROMX
	map_attributes CaveMinecarts6, CAVE_MINECARTS_6, 0

CaveMinecarts6_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts6_Blocks:: INCBIN "maps/blk/CaveMinecarts6.blk"

SECTION "data/maps/attributes.asm@CaveMinecarts7", ROMX
	map_attributes CaveMinecarts7, CAVE_MINECARTS_7, 0

CaveMinecarts7_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

CaveMinecarts7_Blocks:: INCBIN "maps/blk/CaveMinecarts7.blk"

SECTION "data/maps/attributes.asm@Office1", ROMX
	map_attributes Office1, OFFICE_1, 0

Office1_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

Office1_Blocks:: INCBIN "maps/blk/Office1.blk"

SECTION "data/maps/attributes.asm@Office2", ROMX
	map_attributes Office2, OFFICE_2, 0

Office2_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

Office2_Blocks:: INCBIN "maps/blk/Office2.blk"

SECTION "data/maps/attributes.asm@Office3", ROMX
	map_attributes Office3, OFFICE_3, 0

Office3_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

Office3_Blocks:: INCBIN "maps/blk/Office3.blk"

SECTION "data/maps/attributes.asm@SlowpokeWellEntrance", ROMX
	map_attributes SlowpokeWellEntrance, SLOWPOKE_WELL_ENTRANCE, 0

SlowpokeWellEntrance_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

SlowpokeWellEntrance_Blocks:: INCBIN "maps/blk/SlowpokeWellEntrance.blk"

SECTION "data/maps/attributes.asm@SlowpokeWellMain", ROMX
	map_attributes SlowpokeWellMain, SLOWPOKE_WELL_MAIN, 0

SlowpokeWellMain_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

SlowpokeWellMain_Blocks:: INCBIN "maps/blk/SlowpokeWellMain.blk"

SECTION "data/maps/attributes.asm@ShizukanaOka", ROMX
	map_attributes ShizukanaOka, SHIZUKANA_OKA, 0

ShizukanaOka_MapEvents::
	dw $4000 ; unknown

	db 10 ; warp events
	warp_event 49, 28, 1, ROUTE_1_P1, wOverworldMapBlocks + 490
	warp_event 49, 29, 1, ROUTE_1_P1, wOverworldMapBlocks + 490
	warp_event 49, 30, 2, ROUTE_1_P1, wOverworldMapBlocks + 521
	warp_event 49, 31, 2, ROUTE_1_P1, wOverworldMapBlocks + 521
	warp_event 4, 0, 3, ROUTE_1_P2, wOverworldMapBlocks + 34
	warp_event 5, 0, 3, ROUTE_1_P2, wOverworldMapBlocks + 34
	warp_event 6, 0, 3, ROUTE_1_P2, wOverworldMapBlocks + 35
	warp_event 7, 0, 4, ROUTE_1_P2, wOverworldMapBlocks + 35
	warp_event 8, 0, 4, ROUTE_1_P2, wOverworldMapBlocks + 36
	warp_event 9, 0, 4, ROUTE_1_P2, wOverworldMapBlocks + 36

	db 2 ; bg events
	bg_event 9, 2, 0, 1
	bg_event 47, 28, 0, 2

	db 6 ; person events
	object_event 41, 28, SPRITE_ROCKER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 7, SPRITE_YOUNGSTER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 41, 19, SPRITE_YOUNGSTER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0
	object_event 27, 14, SPRITE_FISHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 36, 16, SPRITE_TEACHER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 9, 25, SPRITE_YOUNGSTER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

ShizukanaOka_Blocks:: INCBIN "maps/blk/ShizukanaOka.blk"

SECTION "data/maps/attributes.asm@RouteSilentEastGate", ROMX
	map_attributes RouteSilentEastGate, ROUTE_SILENT_EAST_GATE, 0

RouteSilentEastGate_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 0, 7, 1, ROUTE_SILENT_EAST, wOverworldMapBlocks + 45
	warp_event 1, 7, 1, ROUTE_SILENT_EAST, wOverworldMapBlocks + 45
	warp_event 8, 7, 29, KANTO, wOverworldMapBlocks + 49
	warp_event 9, 7, 29, KANTO, wOverworldMapBlocks + 49

	db 0 ; bg events

	db 0 ; person events

RouteSilentEastGate_Blocks:: INCBIN "maps/blk/RouteSilentEastGate.blk"

SECTION "data/maps/attributes.asm@PlayerHouse1F", ROMX
	map_attributes PlayerHouse1F, PLAYER_HOUSE_1F, 0

PlayerHouse1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 6, 7, 1, SILENT_HILL, wOverworldMapBlocks + 48
	warp_event 7, 7, 1, SILENT_HILL, wOverworldMapBlocks + 48
	warp_event 9, 0, 1, PLAYER_HOUSE_2F, wOverworldMapBlocks + 16

	db 5 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 2, 1, 0, 3
	bg_event 4, 1, 0, 4
	bg_event 5, 1, 0, 5

	db 1 ; person events
	object_event 7, 3, SPRITE_MOM, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

PlayerHouse1F_Blocks:: INCBIN "maps/blk/PlayerHouse1F.blk"

SECTION "data/maps/attributes.asm@PlayerHouse2F", ROMX
	map_attributes PlayerHouse2F, PLAYER_HOUSE_2F, 0

PlayerHouse2F_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 9, 0, 3, PLAYER_HOUSE_1F, wOverworldMapBlocks + 16

	db 5 ; bg events
	bg_event 1, 1, 0, 1
	bg_event 2, 1, 0, 2
	bg_event 3, 1, 0, 3
	bg_event 5, 1, 0, 4
	bg_event 7, 2, 0, 5

	db 2 ; person events
	object_event 8, 1, SPRITE_ROCKER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 1, SPRITE_PIPPI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

PlayerHouse2F_Blocks:: INCBIN "maps/blk/PlayerHouse2F.blk"

SECTION "data/maps/attributes.asm@SilentHillPokecenter", ROMX
	map_attributes SilentHillPokecenter, SILENT_HILL_POKECENTER, 0

SilentHillPokecenter_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 5, 7, 2, SILENT_HILL, wOverworldMapBlocks + 59
	warp_event 6, 7, 2, SILENT_HILL, wOverworldMapBlocks + 60

	db 1 ; bg events
	bg_event 13, 1, 0, 1

	db 5 ; person events
	object_event 5, 1, SPRITE_NURSE, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 6, SPRITE_GENTLEMAN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 4, SPRITE_24, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 1, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 1, SPRITE_SIDON, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillPokecenter_Blocks:: INCBIN "maps/blk/SilentHillPokecenter.blk"

SECTION "data/maps/attributes.asm@SilentHillHouse", ROMX
	map_attributes SilentHillHouse, SILENT_HILL_HOUSE, 0

SilentHillHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, SILENT_HILL, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, SILENT_HILL, wOverworldMapBlocks + 47

	db 6 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 4, 1, 0, 2
	bg_event 5, 1, 0, 3
	bg_event 9, 1, 0, 4
	bg_event 8, 1, 0, 5
	bg_event 2, 0, 0, 6

	db 2 ; person events
	object_event 5, 3, SPRITE_SILVERS_MOM, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 4, SPRITE_ROCKER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillHouse_Blocks:: INCBIN "maps/blk/SilentHillHouse.blk"

SECTION "data/maps/attributes.asm@SilentHillLabFront", ROMX
	map_attributes SilentHillLabFront, SILENT_HILL_LAB_FRONT, 0

SilentHillLabFront_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 3, 15, 4, SILENT_HILL, wOverworldMapBlocks + 82
	warp_event 4, 15, 5, SILENT_HILL, wOverworldMapBlocks + 83
	warp_event 4, 0, 2, SILENT_HILL_LAB_BACK, wOverworldMapBlocks + 13

	db 15 ; bg events
	bg_event 6, 1, 0, 1
	bg_event 2, 0, 0, 2
	bg_event 0, 7, 0, 3
	bg_event 1, 7, 0, 4
	bg_event 2, 7, 0, 5
	bg_event 5, 7, 0, 6
	bg_event 6, 7, 0, 7
	bg_event 7, 7, 0, 8
	bg_event 0, 11, 0, 9
	bg_event 1, 11, 0, 10
	bg_event 2, 11, 0, 11
	bg_event 5, 11, 0, 12
	bg_event 6, 11, 0, 13
	bg_event 7, 11, 0, 14
	bg_event 4, 0, 0, 15

	db 11 ; person events
	object_event 4, 2, SPRITE_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 0, SPRITE_OKIDO, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 4, SPRITE_SILVER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 0, SPRITE_SILVER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 14, SPRITE_BLUE, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 3, SPRITE_BLUE, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 13, SPRITE_NANAMI, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 8, SPRITE_SCIENTIST, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 12, SPRITE_SCIENTIST, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 0, 1, SPRITE_POKEDEX, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 1, 1, SPRITE_POKEDEX, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillLabFront_Blocks:: INCBIN "maps/blk/SilentHillLabFront.blk"

SECTION "data/maps/attributes.asm@SilentHillLabBack", ROMX
	map_attributes SilentHillLabBack, SILENT_HILL_LAB_BACK, 0

SilentHillLabBack_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 3, 7, 3, SILENT_HILL_LAB_FRONT, wOverworldMapBlocks + 42
	warp_event 4, 7, 3, SILENT_HILL_LAB_FRONT, wOverworldMapBlocks + 43

	db 5 ; bg events
	bg_event 0, 1, 0, 1
	bg_event 1, 1, 0, 2
	bg_event 2, 1, 0, 3
	bg_event 3, 1, 0, 4
	bg_event 6, 0, 0, 5

	db 5 ; person events
	object_event 4, 2, SPRITE_OKIDO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 3, 4, SPRITE_SILVER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 2, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillLabBack_Blocks:: INCBIN "maps/blk/SilentHillLabBack.blk"

SECTION "data/maps/attributes.asm@UnusedMap13", ROMX
	map_attributes UnusedMap13, UNUSED_MAP_13, 0

UnusedMap13_MapEvents::
UnusedMap13_Blocks::

SECTION "data/maps/attributes.asm@SilentHill", ROMX
	map_attributes SilentHill, SILENT_HILL, NORTH | WEST | EAST
	connection north, PrinceRoute, PRINCE_ROUTE, 0, 0, 10
	connection west, Route1P1, ROUTE_1_P1, 0, 0, 9
	connection east, RouteSilentEast, ROUTE_SILENT_EAST, 0, 0, 9

SilentHill_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 5, 4, 1, PLAYER_HOUSE_1F, wOverworldMapBlocks + 51
	warp_event 13, 4, 1, SILENT_HILL_POKECENTER, wOverworldMapBlocks + 55
	warp_event 3, 12, 1, SILENT_HILL_HOUSE, wOverworldMapBlocks + 114
	warp_event 14, 11, 1, SILENT_HILL_LAB_FRONT, wOverworldMapBlocks + 104
	warp_event 15, 11, 2, SILENT_HILL_LAB_FRONT, wOverworldMapBlocks + 104

	db 5 ; bg events
	bg_event 8, 4, 0, 1
	bg_event 14, 4, 0, 2
	bg_event 16, 5, 0, 3
	bg_event 10, 11, 0, 4
	bg_event 6, 12, 0, 5

	db 4 ; person events
	object_event 6, 10, SPRITE_SILVER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 9, SPRITE_BLUE, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 6, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 13, SPRITE_SUPER_NERD, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHill_Blocks:: INCBIN "maps/blk/SilentHill.blk"

SECTION "data/maps/attributes.asm@OldCity", ROMX
	map_attributes OldCity, OLD_CITY, SOUTH | WEST
	connection south, Route1P2, ROUTE_1_P2, 5, 0, 10
	connection west, Route2, ROUTE_2, 5, 0, 9

OldCity_MapEvents::
	dw $4000 ; unknown

	db 14 ; warp events
	warp_event 4, 14, 1, OLD_CITY_MUSEUM, wOverworldMapBlocks + 211
	warp_event 5, 14, 2, OLD_CITY_MUSEUM, wOverworldMapBlocks + 211
	warp_event 26, 14, 1, OLD_CITY_GYM, wOverworldMapBlocks + 222
	warp_event 27, 14, 2, OLD_CITY_GYM, wOverworldMapBlocks + 222
	warp_event 11, 17, 1, OLD_CITY_TOWER_1F, wOverworldMapBlocks + 240
	warp_event 12, 17, 2, OLD_CITY_TOWER_1F, wOverworldMapBlocks + 241
	warp_event 30, 22, 1, OLD_CITY_BILLS_HOUSE, wOverworldMapBlocks + 328
	warp_event 3, 26, 1, OLD_CITY_MART, wOverworldMapBlocks + 366
	warp_event 10, 26, 1, OLD_CITY_HOUSE, wOverworldMapBlocks + 370
	warp_event 27, 28, 1, OLD_CITY_POKECENTER_1F, wOverworldMapBlocks + 404
	warp_event 3, 31, 1, OLD_CITY_KURTS_HOUSE, wOverworldMapBlocks + 418
	warp_event 18, 30, 3, ROUTE_1_GATE_1F, wOverworldMapBlocks + 426
	warp_event 19, 30, 4, ROUTE_1_GATE_1F, wOverworldMapBlocks + 426
	warp_event 22, 26, 1, OLD_CITY_SCHOOL, wOverworldMapBlocks + 376

	db 12 ; bg events
	bg_event 8, 14, 0, 1
	bg_event 8, 16, 0, 2
	bg_event 28, 16, 0, 3
	bg_event 20, 22, 0, 4
	bg_event 26, 22, 0, 5
	bg_event 8, 26, 0, 6
	bg_event 28, 28, 0, 7
	bg_event 20, 29, 0, 8
	bg_event 4, 32, 0, 9
	bg_event 30, 22, 0, 10
	bg_event 4, 14, 0, 11
	bg_event 5, 14, 0, 11

	db 5 ; person events
	object_event 8, 30, SPRITE_TWIN, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 20, SPRITE_SUPER_NERD, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 26, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 21, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 17, 19, SPRITE_POKE_BALL, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCity_Blocks:: INCBIN "maps/blk/OldCity.blk"

SECTION "data/maps/attributes.asm@West", ROMX
	map_attributes West, WEST, NORTH | EAST
	connection north, BaadonRoute1, BAADON_ROUTE_1, 5, 0, 10
	connection east, Route2, ROUTE_2, 5, 0, 9

West_MapEvents::
	dw $4000 ; unknown

	db 13 ; warp events
	warp_event 13, 5, 1, WEST_MART_1F, wOverworldMapBlocks + 85
	warp_event 14, 5, 2, WEST_MART_1F, wOverworldMapBlocks + 86
	warp_event 31, 7, 1, WEST_RADIO_TOWER_1F, wOverworldMapBlocks + 120
	warp_event 32, 7, 2, WEST_RADIO_TOWER_1F, wOverworldMapBlocks + 121
	warp_event 18, 12, 1, WEST_ROCKET_RAIDED_HOUSE, wOverworldMapBlocks + 192
	warp_event 25, 14, 1, WEST_POKECENTER_1F, wOverworldMapBlocks + 221
	warp_event 14, 19, 1, WEST_GYM, wOverworldMapBlocks + 268
	warp_event 15, 19, 2, WEST_GYM, wOverworldMapBlocks + 268
	warp_event 26, 19, 1, WEST_HOUSE_1, wOverworldMapBlocks + 274
	warp_event 32, 19, 1, WEST_HOUSE_2, wOverworldMapBlocks + 277
	warp_event 22, 5, 1, BAADON_ROUTE_GATE_WEST, wOverworldMapBlocks + 90
	warp_event 23, 5, 2, BAADON_ROUTE_GATE_WEST, wOverworldMapBlocks + 90
	warp_event 35, 15, 1, ROUTE_2_GATE_1F, wOverworldMapBlocks + 226

	db 6 ; bg events
	bg_event 16, 7, 0, 1
	bg_event 28, 9, 0, 2
	bg_event 12, 10, 0, 3
	bg_event 32, 12, 0, 4
	bg_event 26, 14, 0, 5
	bg_event 18, 20, 0, 6

	db 7 ; person events
	object_event 6, 8, SPRITE_SAILOR, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12, 7, SPRITE_ROCKER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 26, 10, SPRITE_ROCKER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 30, 14, SPRITE_LASS, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 29, 14, SPRITE_PIPPI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22, 19, SPRITE_COOLTRAINER_F, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 18, 13, SPRITE_36, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

West_Blocks:: INCBIN "maps/blk/West.blk"

SECTION "data/maps/attributes.asm@Haiteku", ROMX
	map_attributes Haiteku, HAITEKU, WEST
	connection west, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 0, 0, 9

Haiteku_MapEvents::
	dw $4000 ; unknown

	db 9 ; warp events
	warp_event 31, 10, 1, HAITEKU_POKECENTER_1F, wOverworldMapBlocks + 172
	warp_event 10, 11, 1, HAITEKU_LEAGUE_1F, wOverworldMapBlocks + 162
	warp_event 11, 11, 2, HAITEKU_LEAGUE_1F, wOverworldMapBlocks + 162
	warp_event 31, 16, 1, HAITEKU_MART, wOverworldMapBlocks + 250
	warp_event 7, 17, 1, HAITEKU_HOUSE_1, wOverworldMapBlocks + 238
	warp_event 15, 17, 1, HAITEKU_HOUSE_2, wOverworldMapBlocks + 242
	warp_event 33, 20, 1, HAITEKU_IMPOSTER_OAK_HOUSE, wOverworldMapBlocks + 303
	warp_event 6, 27, 1, HAITEKU_AQUARIUM_1F, wOverworldMapBlocks + 368
	warp_event 7, 27, 2, HAITEKU_AQUARIUM_1F, wOverworldMapBlocks + 368

	db 8 ; bg events
	bg_event 24, 7, 0, 1
	bg_event 12, 12, 0, 2
	bg_event 32, 10, 0, 3
	bg_event 10, 17, 0, 4
	bg_event 32, 16, 0, 5
	bg_event 10, 27, 0, 6
	bg_event 30, 25, 0, 7
	bg_event 24, 28, 0, 8

	db 5 ; person events
	object_event 22, 15, SPRITE_TWIN, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 23, 14, SPRITE_PIPPI, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 23, 24, SPRITE_SAILOR, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 26, 10, SPRITE_SAILOR, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 14, SPRITE_GENTLEMAN, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

Haiteku_Blocks:: INCBIN "maps/blk/Haiteku.blk"

SECTION "data/maps/attributes.asm@Fonto", ROMX
	map_attributes Fonto, FONTO, NORTH | WEST | EAST
	connection north, FontoRoute2, FONTO_ROUTE_2, 0, 0, 10
	connection west, FontoRoute1, FONTO_ROUTE_1, 0, 0, 9
	connection east, FontoRoute3, FONTO_ROUTE_3, 0, 0, 9

Fonto_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 4, 3, 1, FONTO_ROCKET_HOUSE, wOverworldMapBlocks + 35
	warp_event 15, 4, 1, FONTO_MART, wOverworldMapBlocks + 56
	warp_event 3, 7, 1, FONTO_HOUSE, wOverworldMapBlocks + 66
	warp_event 3, 12, 1, FONTO_POKECENTER_1F, wOverworldMapBlocks + 114
	warp_event 16, 13, 1, FONTO_LAB, wOverworldMapBlocks + 121

	db 5 ; bg events
	bg_event 15, 4, 0, 1
	bg_event 14, 6, 0, 2
	bg_event 4, 12, 0, 3
	bg_event 6, 12, 0, 4
	bg_event 10, 12, 0, 5

	db 4 ; person events
	object_event 2, 4, SPRITE_36, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 5, SPRITE_SIDON, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 5, 14, SPRITE_YOUNGSTER, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 16, 8, SPRITE_TWIN, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Fonto_Blocks:: INCBIN "maps/blk/Fonto.blk"

SECTION "data/maps/attributes.asm@Baadon", ROMX
	map_attributes Baadon, BAADON, NORTH | SOUTH | EAST
	connection north, FontoRoute4, FONTO_ROUTE_4, 0, 0, 10
	connection south, BaadonRoute1, BAADON_ROUTE_1, 0, 0, 10
	connection east, BaadonRoute2, BAADON_ROUTE_2, 0, 0, 9

Baadon_MapEvents::
	dw $4000 ; unknown

	db 9 ; warp events
	warp_event 3, 4, 1, BAADON_MART, wOverworldMapBlocks + 50
	warp_event 15, 4, 1, BAADON_POKECENTER_1F, wOverworldMapBlocks + 56
	warp_event 4, 9, 1, BAADON_HOUSE_1, wOverworldMapBlocks + 83
	warp_event 3, 13, 1, BAADON_WALLPAPER_HOUSE, wOverworldMapBlocks + 114
	warp_event 9, 13, 1, BAADON_HOUSE_2, wOverworldMapBlocks + 117
	warp_event 14, 15, 1, BAADON_LEAGUE_1F, wOverworldMapBlocks + 136
	warp_event 15, 15, 2, BAADON_LEAGUE_1F, wOverworldMapBlocks + 136
	warp_event 8, 5, 1, FONTO_ROUTE_GATE_2, wOverworldMapBlocks + 53
	warp_event 9, 5, 2, FONTO_ROUTE_GATE_2, wOverworldMapBlocks + 53

	db 4 ; bg events
	bg_event 4, 4, 0, 1
	bg_event 16, 4, 0, 2
	bg_event 11, 10, 0, 3
	bg_event 6, 14, 0, 4

	db 3 ; person events
	object_event 14, 8, SPRITE_SUPER_NERD, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 9, SPRITE_YOUNGSTER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 14, SPRITE_TWIN, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Baadon_Blocks:: INCBIN "maps/blk/Baadon.blk"

SECTION "data/maps/attributes.asm@Newtype", ROMX
	map_attributes Newtype, NEWTYPE, NORTH | WEST | EAST
	connection north, SugarRoute, SUGAR_ROUTE, 5, 0, 10
	connection west, Route15, ROUTE_15, 0, 0, 9
	connection east, NewtypeRoute, NEWTYPE_ROUTE, 9, 0, 9

Newtype_MapEvents::
	dw $4000 ; unknown

	db 13 ; warp events
	warp_event 7, 8, 1, NEWTYPE_POKECENTER_1F, wOverworldMapBlocks + 134
	warp_event 30, 9, 1, NEWTYPE_LEAGUE_1F, wOverworldMapBlocks + 146
	warp_event 31, 9, 2, NEWTYPE_LEAGUE_1F, wOverworldMapBlocks + 146
	warp_event 23, 13, 1, NEWTYPE_SAILOR_HOUSE, wOverworldMapBlocks + 194
	warp_event 7, 14, 1, NEWTYPE_MART, wOverworldMapBlocks + 212
	warp_event 33, 15, 1, NEWTYPE_DOJO, wOverworldMapBlocks + 225
	warp_event 34, 15, 2, NEWTYPE_DOJO, wOverworldMapBlocks + 226
	warp_event 23, 22, 1, NEWTYPE_HOUSE_1, wOverworldMapBlocks + 324
	warp_event 5, 23, 1, NEWTYPE_DINER, wOverworldMapBlocks + 315
	warp_event 11, 28, 1, NEWTYPE_HOUSE_2, wOverworldMapBlocks + 396
	warp_event 35, 30, 1, NEWTYPE_HOUSE_3, wOverworldMapBlocks + 434
	warp_event 18, 5, 1, SUGAR_ROUTE_GATE, wOverworldMapBlocks + 88
	warp_event 19, 5, 2, SUGAR_ROUTE_GATE, wOverworldMapBlocks + 88

	db 5 ; bg events
	bg_event 0, 8, 0, 1
	bg_event 8, 8, 0, 2
	bg_event 8, 14, 0, 3
	bg_event 30, 15, 0, 4
	bg_event 30, 21, 0, 5

	db 4 ; person events
	object_event 5, 10, SPRITE_SILVER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24, 26, SPRITE_FISHER, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24, 9, SPRITE_ROCKER, FACE_UP, 2, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 30, SPRITE_GIRL, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

Newtype_Blocks:: INCBIN "maps/blk/Newtype.blk"

SECTION "data/maps/attributes.asm@Sugar", ROMX
	map_attributes Sugar, SUGAR, SOUTH
	connection south, SugarRoute, SUGAR_ROUTE, 0, 0, 10

Sugar_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 5, 5, 1, SUGAR_HOUSE, wOverworldMapBlocks + 51
	warp_event 15, 9, 1, SUGAR_HOUSE_2, wOverworldMapBlocks + 88
	warp_event 5, 10, 1, SUGAR_MART, wOverworldMapBlocks + 99
	warp_event 9, 10, 1, SUGAR_POKECENTER_1F, wOverworldMapBlocks + 101

	db 4 ; bg events
	bg_event 14, 6, 0, 1
	bg_event 6, 10, 0, 2
	bg_event 10, 10, 0, 3
	bg_event 10, 14, 0, 4

	db 3 ; person events
	object_event 8, 12, SPRITE_TWIN, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 6, SPRITE_GRANNY, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 11, SPRITE_GRAMPS, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Sugar_Blocks:: INCBIN "maps/blk/Sugar.blk"

SECTION "data/maps/attributes.asm@BullForest", ROMX
	map_attributes BullForest, BULL_FOREST, NORTH | SOUTH | WEST
	connection north, BullForestRoute3, BULL_FOREST_ROUTE_3, 5, 0, 10
	connection south, BullForestRoute2, BULL_FOREST_ROUTE_2, 5, 0, 10
	connection west, BullForestRoute1, BULL_FOREST_ROUTE_1, 9, 0, 9

BullForest_MapEvents::
	dw $4000 ; unknown

	db 8 ; warp events
	warp_event 25, 6, 1, BULL_MART, wOverworldMapBlocks + 117
	warp_event 9, 9, 1, BULL_HOUSE_1, wOverworldMapBlocks + 135
	warp_event 27, 11, 1, BULL_HOUSE_2, wOverworldMapBlocks + 170
	warp_event 19, 13, 1, BULL_HOUSE_3, wOverworldMapBlocks + 192
	warp_event 13, 18, 1, BULL_POKECENTER_1F, wOverworldMapBlocks + 267
	warp_event 26, 21, 1, BULL_LEAGUE_1F, wOverworldMapBlocks + 300
	warp_event 27, 21, 2, BULL_LEAGUE_1F, wOverworldMapBlocks + 300
	warp_event 3, 22, 1, BULL_HOUSE_4, wOverworldMapBlocks + 314

	db 3 ; bg events
	bg_event 26, 6, 0, 1
	bg_event 2, 16, 0, 2
	bg_event 14, 18, 0, 3

	db 5 ; person events
	object_event 21, 9, SPRITE_TWIN, SLOW_STEP_DOWN, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 11, 12, SPRITE_YOUNGSTER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 16, SPRITE_GRANNY, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 20, 19, SPRITE_TEACHER, FACE_UP, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 20, 29, SPRITE_BUG_CATCHER_BOY, FACE_RIGHT, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

BullForest_Blocks:: INCBIN "maps/blk/BullForest.blk"

SECTION "data/maps/attributes.asm@Stand", ROMX
	map_attributes Stand, STAND, NORTH | SOUTH
	connection north, BullForestRoute2, BULL_FOREST_ROUTE_2, 10, 0, 10
	connection south, StandRoute, STAND_ROUTE, 10, 0, 10

Stand_MapEvents::
	dw $4000 ; unknown

	db 10 ; warp events
	warp_event 24, 17, 1, STAND_LAB, wOverworldMapBlocks + 247
	warp_event 33, 20, 1, STAND_POKECENTER_1F, wOverworldMapBlocks + 303
	warp_event 16, 21, 1, STAND_OFFICE, wOverworldMapBlocks + 295
	warp_event 35, 26, 1, STAND_MART, wOverworldMapBlocks + 382
	warp_event 26, 29, 1, STAND_HOUSE, wOverworldMapBlocks + 404
	warp_event 17, 31, 1, STAND_ROCKET_HOUSE_1F, wOverworldMapBlocks + 425
	warp_event 34, 31, 1, STAND_LEAGUE_1F, wOverworldMapBlocks + 434
	warp_event 35, 31, 2, STAND_LEAGUE_1F, wOverworldMapBlocks + 434
	warp_event 30, 13, 1, BULL_FOREST_ROUTE_GATE_STAND, wOverworldMapBlocks + 198
	warp_event 31, 13, 2, BULL_FOREST_ROUTE_GATE_STAND, wOverworldMapBlocks + 198

	db 10 ; bg events
	bg_event 8, 8, 0, 1
	bg_event 14, 8, 0, 2
	bg_event 20, 10, 0, 3
	bg_event 16, 16, 0, 4
	bg_event 10, 20, 0, 5
	bg_event 18, 21, 0, 6
	bg_event 24, 20, 0, 7
	bg_event 34, 20, 0, 8
	bg_event 36, 26, 0, 9
	bg_event 32, 35, 0, 10

	db 9 ; person events
	object_event 10, 10, SPRITE_POKEFAN_M, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 17, SPRITE_TWIN, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 28, 19, SPRITE_ROCKER, FACE_RIGHT, 0, 3, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 30, 31, SPRITE_TEACHER, FACE_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 21, 8, SPRITE_SIDON, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13, 6, SPRITE_PIPPI, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 6, SPRITE_SIDON, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14, 15, SPRITE_POPPO, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 21, SPRITE_SIDON, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

Stand_Blocks:: INCBIN "maps/blk/Stand.blk"

SECTION "data/maps/attributes.asm@Kanto", ROMX
	map_attributes Kanto, KANTO, WEST | EAST
	connection west, RouteSilentEast, ROUTE_SILENT_EAST, 9, 0, 9
	connection east, KantoEastRoute, KANTO_EAST_ROUTE, 9, 0, 9

Kanto_MapEvents::
	dw $4000 ; unknown

	db 30 ; warp events
	warp_event 40, 3, 1, KANTO_CERULEAN_HOUSE, wOverworldMapBlocks + 93
	warp_event 13, 4, 1, KANTO_POKECENTER_1F, wOverworldMapBlocks + 115
	warp_event 4, 5, 1, KANTO_LEAGUE_1F, wOverworldMapBlocks + 111
	warp_event 5, 5, 2, KANTO_LEAGUE_1F, wOverworldMapBlocks + 111
	warp_event 51, 11, 1, KANTO_LAVENDER_HOUSE, wOverworldMapBlocks + 242
	warp_event 14, 17, 1, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 332
	warp_event 15, 17, 1, KANTO_CELADON_MART_1F, wOverworldMapBlocks + 332
	warp_event 3, 18, 1, KANTO_MART, wOverworldMapBlocks + 362
	warp_event 22, 19, 1, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 372
	warp_event 23, 19, 2, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 372
	warp_event 30, 19, 1, KANTO_SILPH_CO, wOverworldMapBlocks + 376
	warp_event 31, 19, 2, KANTO_SILPH_CO, wOverworldMapBlocks + 376
	warp_event 16, 23, 1, KANTO_VIRIDIAN_HOUSE, wOverworldMapBlocks + 441
	warp_event 29, 23, 1, KANTO_GAME_CORNER, wOverworldMapBlocks + 447
	warp_event 34, 23, 1, KANTO_GAME_CORNER_PRIZES, wOverworldMapBlocks + 450
	warp_event 40, 23, 1, KANTO_DINER, wOverworldMapBlocks + 453
	warp_event 52, 23, 1, KANTO_SCHOOL, wOverworldMapBlocks + 459
	warp_event 53, 23, 2, KANTO_SCHOOL, wOverworldMapBlocks + 459
	warp_event 38, 29, 1, KANTO_HOSPITAL, wOverworldMapBlocks + 560
	warp_event 49, 30, 1, KANTO_POKECENTER_2_1F, wOverworldMapBlocks + 601
	warp_event 5, 38, 1, KANTO_REDS_HOUSE, wOverworldMapBlocks + 723
	warp_event 13, 38, 1, KANTO_GREENS_HOUSE_1F, wOverworldMapBlocks + 727
	warp_event 39, 38, 1, KANTO_ELDERS_HOUSE, wOverworldMapBlocks + 740
	warp_event 12, 43, 1, KANTO_OAKS_LAB, wOverworldMapBlocks + 799
	warp_event 13, 43, 2, KANTO_OAKS_LAB, wOverworldMapBlocks + 799
	warp_event 52, 45, 1, KANTO_LEAGUE_2_1F, wOverworldMapBlocks + 855
	warp_event 53, 45, 2, KANTO_LEAGUE_2_1F, wOverworldMapBlocks + 855
	warp_event 45, 46, 1, KANTO_FISHING_GURU, wOverworldMapBlocks + 887
	warp_event 6, 27, 3, ROUTE_SILENT_EAST_GATE, wOverworldMapBlocks + 508
	warp_event 21, 13, 5, KANTO_GAMEFREAK_HQ_1, wOverworldMapBlocks + 263

	db 12 ; bg events
	bg_event 14, 4, 0, 1
	bg_event 42, 4, 0, 2
	bg_event 54, 8, 0, 3
	bg_event 4, 18, 0, 4
	bg_event 18, 18, 0, 5
	bg_event 26, 19, 0, 6
	bg_event 46, 18, 0, 7
	bg_event 8, 38, 0, 8
	bg_event 16, 38, 0, 9
	bg_event 6, 41, 0, 10
	bg_event 12, 45, 0, 11
	bg_event 50, 30, 0, 12

	db 0 ; person events

Kanto_Blocks:: INCBIN "maps/blk/Kanto.blk"

SECTION "data/maps/attributes.asm@Prince", ROMX
	map_attributes Prince, PRINCE, NORTH | SOUTH
	connection north, MtFujiRoute, MT_FUJI_ROUTE, 0, 0, 10
	connection south, PrinceRoute, PRINCE_ROUTE, 0, 0, 10

Prince_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

Prince_Blocks:: INCBIN "maps/blk/Prince.blk"

SECTION "data/maps/attributes.asm@MtFuji", ROMX
	map_attributes MtFuji, MT_FUJI, SOUTH
	connection south, MtFujiRoute, MT_FUJI_ROUTE, 0, 0, 10

MtFuji_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

MtFuji_Blocks:: INCBIN "maps/blk/MtFuji.blk"

SECTION "data/maps/attributes.asm@South", ROMX
	map_attributes South, SOUTH, NORTH | SOUTH | EAST
	connection north, FontoRoute5, FONTO_ROUTE_5, 10, 0, 10
	connection south, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, 10, 0, 10
	connection east, FontoRoute1, FONTO_ROUTE_1, 0, 0, 9

South_MapEvents::
	dw $4000 ; unknown

	db 9 ; warp events
	warp_event 26, 10, 1, SOUTH_HOUSE_1, wOverworldMapBlocks + 170
	warp_event 33, 14, 1, SOUTH_POKECENTER_1F, wOverworldMapBlocks + 225
	warp_event 19, 22, 1, SOUTH_MART, wOverworldMapBlocks + 322
	warp_event 33, 23, 1, SOUTH_HOUSE_2, wOverworldMapBlocks + 329
	warp_event 30, 5, 1, FONTO_ROUTE_GATE_3, wOverworldMapBlocks + 94
	warp_event 31, 5, 2, FONTO_ROUTE_GATE_3, wOverworldMapBlocks + 94
	warp_event 35, 19, 2, FONTO_ROUTE_GATE_1, wOverworldMapBlocks + 278
	warp_event 30, 30, 3, HAITEKU_WEST_ROUTE_GATE, wOverworldMapBlocks + 432
	warp_event 31, 30, 4, HAITEKU_WEST_ROUTE_GATE, wOverworldMapBlocks + 432

	db 5 ; bg events
	bg_event 30, 14, 0, 1
	bg_event 34, 14, 0, 2
	bg_event 28, 17, 0, 3
	bg_event 16, 22, 0, 4
	bg_event 20, 22, 0, 5

	db 4 ; person events
	object_event 25, 21, SPRITE_TWIN, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 24, 21, SPRITE_PIPPI, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22, 16, SPRITE_ROCKER, SLOW_STEP_DOWN, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 30, 11, SPRITE_FISHING_GURU, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

South_Blocks:: INCBIN "maps/blk/South.blk"

SECTION "data/maps/attributes.asm@North", ROMX
	map_attributes North, NORTH, SOUTH
	connection south, BullForestRoute3, BULL_FOREST_ROUTE_3, 0, 0, 10

North_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 5, 5, 1, NORTH_HOUSE_1, wOverworldMapBlocks + 51
	warp_event 15, 6, 1, NORTH_MART, wOverworldMapBlocks + 72
	warp_event 5, 9, 1, NORTH_HOUSE_2, wOverworldMapBlocks + 83
	warp_event 13, 10, 1, NORTH_POKECENTER_1F, wOverworldMapBlocks + 103

	db 4 ; bg events
	bg_event 12, 4, 0, 1
	bg_event 16, 6, 0, 2
	bg_event 14, 10, 0, 3
	bg_event 8, 12, 0, 4

	db 3 ; person events
	object_event 9, 6, SPRITE_GRANNY, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 9, SPRITE_BUG_CATCHER_BOY, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 9, 9, SPRITE_TWIN, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

North_Blocks:: INCBIN "maps/blk/North.blk"

SECTION "data/maps/attributes.asm@Route1P1", ROMX
	map_attributes Route1P1, ROUTE_1_P1, WEST | EAST
	connection west, Route1P2, ROUTE_1_P2, -3, 6, 12
	connection east, SilentHill, SILENT_HILL, 0, 0, 9

Route1P1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 8, 2, SHIZUKANA_OKA, wOverworldMapBlocks + 110
	warp_event 8, 9, 3, SHIZUKANA_OKA, wOverworldMapBlocks + 110

	db 2 ; bg events
	bg_event 12, 7, 0, 1
	bg_event 20, 8, 0, 2

	db 2 ; person events
	object_event 20, 5, SPRITE_SUPER_NERD, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 18, 12, SPRITE_YOUNGSTER, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Route1P1_Blocks:: INCBIN "maps/blk/Route1P1.blk"

SECTION "data/maps/attributes.asm@Route1P2", ROMX
	map_attributes Route1P2, ROUTE_1_P2, NORTH | EAST
	connection north, OldCity, OLD_CITY, -3, 2, 16
	connection east, Route1P1, ROUTE_1_P1, 9, 0, 9

Route1P2_MapEvents::
	dw $4000 ; unknown

	db 4 ; warp events
	warp_event 8, 5, 1, ROUTE_1_GATE_1F, wOverworldMapBlocks + 53
	warp_event 9, 5, 2, ROUTE_1_GATE_1F, wOverworldMapBlocks + 53
	warp_event 8, 25, 6, SHIZUKANA_OKA, wOverworldMapBlocks + 213
	warp_event 9, 25, 9, SHIZUKANA_OKA, wOverworldMapBlocks + 213

	db 1 ; bg events
	bg_event 10, 20, 0, 1

	db 2 ; person events
	object_event 8, 6, SPRITE_SILVER, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 15, SPRITE_TEACHER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0

Route1P2_Blocks:: INCBIN "maps/blk/Route1P2.blk"

SECTION "data/maps/attributes.asm@Route2", ROMX
	map_attributes Route2, ROUTE_2, WEST | EAST
	connection west, West, WEST, -3, 2, 15
	connection east, OldCity, OLD_CITY, -3, 2, 15

Route2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 6, 5, 3, ROUTE_2_GATE_1F, wOverworldMapBlocks + 67
	warp_event 15, 4, 1, ROUTE_2_HOUSE, wOverworldMapBlocks + 71

	db 3 ; bg events
	bg_event 15, 4, 0, 3
	bg_event 14, 5, 0, 1
	bg_event 24, 10, 0, 2

	db 3 ; person events
	object_event 19, 11, SPRITE_YOUNGSTER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 15, 7, SPRITE_YOUNGSTER, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 8, SPRITE_YOUNGSTER, STEP_DOWN, 0, 0, -1, -1, 0, 0, 0, 3, 0, 0

Route2_Blocks:: INCBIN "maps/blk/Route2.blk"

SECTION "data/maps/attributes.asm@HaitekuWestRoute", ROMX
	map_attributes HaitekuWestRoute, HAITEKU_WEST_ROUTE, WEST | EAST
	connection west, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, -3, 15, 12
	connection east, Haiteku, HAITEKU, 0, 0, 12

HaitekuWestRoute_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

HaitekuWestRoute_Blocks:: INCBIN "maps/blk/HaitekuWestRoute.blk"

SECTION "data/maps/attributes.asm@HaitekuWestRouteOcean", ROMX
	map_attributes HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, NORTH | EAST
	connection north, South, SOUTH, -3, 7, 13
	connection east, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 18, 0, 9

HaitekuWestRouteOcean_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 10, 9, 1, HAITEKU_WEST_ROUTE_GATE, wOverworldMapBlocks + 86
	warp_event 11, 9, 2, HAITEKU_WEST_ROUTE_GATE, wOverworldMapBlocks + 86

	db 0 ; bg events

	db 0 ; person events

HaitekuWestRouteOcean_Blocks:: INCBIN "maps/blk/HaitekuWestRouteOcean.blk"

SECTION "data/maps/attributes.asm@FontoRoute1", ROMX
	map_attributes FontoRoute1, FONTO_ROUTE_1, WEST | EAST
	connection west, South, SOUTH, 0, 0, 12
	connection east, Fonto, FONTO, 0, 0, 9

FontoRoute1_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 6, 9, 3, FONTO_ROUTE_GATE_1, wOverworldMapBlocks + 209

	db 0 ; bg events

	db 0 ; person events

FontoRoute1_Blocks:: INCBIN "maps/blk/FontoRoute1.blk"

SECTION "data/maps/attributes.asm@FontoRoute6", ROMX
	map_attributes FontoRoute6, FONTO_ROUTE_6, WEST | EAST
	connection west, FontoRoute5, FONTO_ROUTE_5, 0, 0, 12
	connection east, FontoRoute2, FONTO_ROUTE_2, 0, 0, 12

FontoRoute6_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

FontoRoute6_Blocks:: INCBIN "maps/blk/FontoRoute6.blk"

SECTION "data/maps/attributes.asm@FontoRoute2", ROMX
	map_attributes FontoRoute2, FONTO_ROUTE_2, SOUTH | WEST
	connection south, Fonto, FONTO, 0, 0, 10
	connection west, FontoRoute6, FONTO_ROUTE_6, 0, 0, 9

FontoRoute2_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

FontoRoute2_Blocks:: INCBIN "maps/blk/FontoRoute2.blk"

SECTION "data/maps/attributes.asm@FontoRoute4", ROMX
	map_attributes FontoRoute4, FONTO_ROUTE_4, SOUTH | WEST
	connection south, Baadon, BAADON, 0, 0, 10
	connection west, FontoRoute3, FONTO_ROUTE_3, 0, 0, 9

FontoRoute4_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 30, 3, FONTO_ROUTE_GATE_2, wOverworldMapBlocks + 261
	warp_event 9, 30, 4, FONTO_ROUTE_GATE_2, wOverworldMapBlocks + 261

	db 0 ; bg events

	db 0 ; person events

FontoRoute4_Blocks:: INCBIN "maps/blk/FontoRoute4.blk"

SECTION "data/maps/attributes.asm@FontoRoute3", ROMX
	map_attributes FontoRoute3, FONTO_ROUTE_3, WEST | EAST
	connection west, Fonto, FONTO, 0, 0, 9
	connection east, FontoRoute4, FONTO_ROUTE_4, 0, 0, 12

FontoRoute3_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

FontoRoute3_Blocks:: INCBIN "maps/blk/FontoRoute3.blk"

SECTION "data/maps/attributes.asm@BaadonRoute1", ROMX
	map_attributes BaadonRoute1, BAADON_ROUTE_1, NORTH | SOUTH
	connection north, Baadon, BAADON, 0, 0, 10
	connection south, West, WEST, -3, 2, 16

BaadonRoute1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 12, 48, 3, BAADON_ROUTE_GATE_WEST, wOverworldMapBlocks + 407
	warp_event 13, 48, 4, BAADON_ROUTE_GATE_WEST, wOverworldMapBlocks + 407

	db 0 ; bg events

	db 0 ; person events

BaadonRoute1_Blocks:: INCBIN "maps/blk/BaadonRoute1.blk"

SECTION "data/maps/attributes.asm@BaadonRoute2", ROMX
	map_attributes BaadonRoute2, BAADON_ROUTE_2, WEST | EAST
	connection west, Baadon, BAADON, 0, 0, 9
	connection east, BaadonRoute3, BAADON_ROUTE_3, 0, 0, 12

BaadonRoute2_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

BaadonRoute2_Blocks:: INCBIN "maps/blk/BaadonRoute2.blk"

SECTION "data/maps/attributes.asm@BaadonRoute3", ROMX
	map_attributes BaadonRoute3, BAADON_ROUTE_3, SOUTH | WEST
	connection south, Route15, ROUTE_15, 0, 0, 13
	connection west, BaadonRoute2, BAADON_ROUTE_2, 0, 0, 9

BaadonRoute3_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 30, 3, BAADON_ROUTE_GATE_NEWTYPE, wOverworldMapBlocks + 261
	warp_event 9, 30, 4, BAADON_ROUTE_GATE_NEWTYPE, wOverworldMapBlocks + 261

	db 0 ; bg events

	db 0 ; person events

BaadonRoute3_Blocks:: INCBIN "maps/blk/BaadonRoute3.blk"

SECTION "data/maps/attributes.asm@Route15", ROMX
	map_attributes Route15, ROUTE_15, NORTH | EAST
	connection north, BaadonRoute3, BAADON_ROUTE_3, 0, 0, 10
	connection east, Newtype, NEWTYPE, 0, 0, 12

Route15_MapEvents::
	dw $4000 ; unknown

	db 7 ; warp events
	warp_event 8, 5, 1, BAADON_ROUTE_GATE_NEWTYPE, wOverworldMapBlocks + 68
	warp_event 9, 5, 2, BAADON_ROUTE_GATE_NEWTYPE, wOverworldMapBlocks + 68
	warp_event 9, 10, 1, ROUTE_15_POKECENTER_1F, wOverworldMapBlocks + 131
	warp_event 14, 12, 6, ROUTE_15, wOverworldMapBlocks + 155
	warp_event 14, 13, 7, ROUTE_15, wOverworldMapBlocks + 155
	warp_event 21, 8, 4, ROUTE_15, wOverworldMapBlocks + 116
	warp_event 21, 9, 5, ROUTE_15, wOverworldMapBlocks + 116

	db 0 ; bg events

	db 0 ; person events

Route15_Blocks:: INCBIN "maps/blk/Route15.blk"

SECTION "data/maps/attributes.asm@NewtypeRoute", ROMX
	map_attributes NewtypeRoute, NEWTYPE_ROUTE, WEST | EAST
	connection west, Newtype, NEWTYPE, -3, 6, 12
	connection east, Route18, ROUTE_18, -3, 33, 12

NewtypeRoute_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

NewtypeRoute_Blocks:: INCBIN "maps/blk/NewtypeRoute.blk"

SECTION "data/maps/attributes.asm@Route18", ROMX
	map_attributes Route18, ROUTE_18, NORTH | WEST
	connection north, BullForestRoute1, BULL_FOREST_ROUTE_1, 0, 0, 13
	connection west, NewtypeRoute, NEWTYPE_ROUTE, 36, 0, 9

Route18_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 8, 5, 1, NEWTYPE_ROUTE_GATE, wOverworldMapBlocks + 53
	warp_event 9, 5, 2, NEWTYPE_ROUTE_GATE, wOverworldMapBlocks + 53
	warp_event 13, 28, 1, ROUTE_18_POKECENTER_1F, wOverworldMapBlocks + 247

	db 0 ; bg events

	db 0 ; person events

Route18_Blocks:: INCBIN "maps/blk/Route18.blk"

SECTION "data/maps/attributes.asm@BullForestRoute1", ROMX
	map_attributes BullForestRoute1, BULL_FOREST_ROUTE_1, SOUTH | EAST
	connection south, Route18, ROUTE_18, 0, 0, 10
	connection east, BullForest, BULL_FOREST, -3, 6, 12

BullForestRoute1_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 8, 12, 3, NEWTYPE_ROUTE_GATE, wOverworldMapBlocks + 222
	warp_event 9, 12, 4, NEWTYPE_ROUTE_GATE, wOverworldMapBlocks + 222
	warp_event 9, 5, 1, BULL_FOREST_ROUTE_1_HOUSE, wOverworldMapBlocks + 98

	db 0 ; bg events

	db 0 ; person events

BullForestRoute1_Blocks:: INCBIN "maps/blk/BullForestRoute1.blk"

SECTION "data/maps/attributes.asm@SugarRoute", ROMX
	map_attributes SugarRoute, SUGAR_ROUTE, NORTH | SOUTH
	connection north, Sugar, SUGAR, 0, 0, 10
	connection south, Newtype, NEWTYPE, -3, 2, 16

SugarRoute_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 48, 3, SUGAR_ROUTE_GATE, wOverworldMapBlocks + 405
	warp_event 9, 48, 4, SUGAR_ROUTE_GATE, wOverworldMapBlocks + 405

	db 0 ; bg events

	db 0 ; person events

SugarRoute_Blocks:: INCBIN "maps/blk/SugarRoute.blk"

SECTION "data/maps/attributes.asm@BullForestRoute2", ROMX
	map_attributes BullForestRoute2, BULL_FOREST_ROUTE_2, NORTH | SOUTH
	connection north, BullForest, BULL_FOREST, -3, 2, 16
	connection south, Stand, STAND, -3, 7, 13

BullForestRoute2_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 48, 3, BULL_FOREST_ROUTE_GATE_STAND, wOverworldMapBlocks + 405
	warp_event 9, 48, 4, BULL_FOREST_ROUTE_GATE_STAND, wOverworldMapBlocks + 405

	db 0 ; bg events

	db 0 ; person events

BullForestRoute2_Blocks:: INCBIN "maps/blk/BullForestRoute2.blk"

SECTION "data/maps/attributes.asm@StandRoute", ROMX
	map_attributes StandRoute, STAND_ROUTE, NORTH | SOUTH
	connection north, Stand, STAND, -3, 7, 13
	connection south, KantoEastRoute, KANTO_EAST_ROUTE, -3, 7, 13

StandRoute_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 48, 3, STAND_ROUTE_GATE_KANTO, wOverworldMapBlocks + 405
	warp_event 9, 48, 4, STAND_ROUTE_GATE_KANTO, wOverworldMapBlocks + 405

	db 0 ; bg events

	db 0 ; person events

StandRoute_Blocks:: INCBIN "maps/blk/StandRoute.blk"

SECTION "data/maps/attributes.asm@KantoEastRoute", ROMX
	map_attributes KantoEastRoute, KANTO_EAST_ROUTE, NORTH | WEST
	connection north, StandRoute, STAND_ROUTE, 10, 0, 10
	connection west, Kanto, KANTO, -3, 6, 15

KantoEastRoute_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 28, 5, 1, STAND_ROUTE_GATE_KANTO, wOverworldMapBlocks + 93
	warp_event 29, 5, 2, STAND_ROUTE_GATE_KANTO, wOverworldMapBlocks + 93

	db 0 ; bg events

	db 0 ; person events

KantoEastRoute_Blocks:: INCBIN "maps/blk/KantoEastRoute.blk"

SECTION "data/maps/attributes.asm@RouteSilentEast", ROMX
	map_attributes RouteSilentEast, ROUTE_SILENT_EAST, WEST | EAST
	connection west, SilentHill, SILENT_HILL, 0, 0, 9
	connection east, Kanto, KANTO, -3, 6, 15

RouteSilentEast_MapEvents::
	dw $4000 ; unknown

	db 1 ; warp events
	warp_event 55, 9, 1, ROUTE_SILENT_EAST_GATE, wOverworldMapBlocks + 208

	db 0 ; bg events

	db 0 ; person events

RouteSilentEast_Blocks:: INCBIN "maps/blk/RouteSilentEast.blk"

SECTION "data/maps/attributes.asm@PrinceRoute", ROMX
	map_attributes PrinceRoute, PRINCE_ROUTE, NORTH | SOUTH
	connection north, Prince, PRINCE, 0, 0, 10
	connection south, SilentHill, SILENT_HILL, 0, 0, 10

PrinceRoute_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

PrinceRoute_Blocks:: INCBIN "maps/blk/PrinceRoute.blk"

SECTION "data/maps/attributes.asm@MtFujiRoute", ROMX
	map_attributes MtFujiRoute, MT_FUJI_ROUTE, NORTH | SOUTH
	connection north, MtFuji, MT_FUJI, 0, 0, 10
	connection south, Prince, PRINCE, 0, 0, 10

MtFujiRoute_MapEvents::
	dw $0 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

MtFujiRoute_Blocks:: INCBIN "maps/blk/MtFujiRoute.blk"

SECTION "data/maps/attributes.asm@FontoRoute5", ROMX
	map_attributes FontoRoute5, FONTO_ROUTE_5, SOUTH | EAST
	connection south, South, SOUTH, -3, 7, 13
	connection east, FontoRoute6, FONTO_ROUTE_6, 0, 0, 9

FontoRoute5_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 30, 3, FONTO_ROUTE_GATE_3, wOverworldMapBlocks + 261
	warp_event 9, 30, 4, FONTO_ROUTE_GATE_3, wOverworldMapBlocks + 261

	db 0 ; bg events

	db 0 ; person events

FontoRoute5_Blocks:: INCBIN "maps/blk/FontoRoute5.blk"

SECTION "data/maps/attributes.asm@BullForestRoute3", ROMX
	map_attributes BullForestRoute3, BULL_FOREST_ROUTE_3, NORTH | SOUTH
	connection north, North, NORTH, 0, 0, 10
	connection south, BullForest, BULL_FOREST, -3, 2, 16

BullForestRoute3_MapEvents::
	dw $4000 ; unknown

	db 0 ; warp events

	db 0 ; bg events

	db 0 ; person events

BullForestRoute3_Blocks:: INCBIN "maps/blk/BullForestRoute3.blk"
