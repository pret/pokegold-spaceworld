INCLUDE "constants.asm"

map_id: MACRO
;\1: map id
	db GROUP_\1, MAP_\1
ENDM

map_attributes: MACRO
;\1: map name
;\2: map id
;\3: connections: combo of NORTH, SOUTH, WEST, and/or EAST, or 0 for none
CURRENT_MAP_WIDTH = \2_WIDTH
CURRENT_MAP_HEIGHT = \2_HEIGHT
\1_MapAttributes::
	db CURRENT_MAP_HEIGHT, CURRENT_MAP_WIDTH
	dw \1_Blocks
	dw \1_Unk
	dw \1_MapScripts
	dw \1_MapEvents
	db \3
ENDM

; Connections go in order: north, south, west, east
connection: MACRO
;\1: direction
;\2: map name
;\3: map id
;\4: final y offset for east/west, x offset for north/south
;\5: map data y offset for east/west, x offset for north/south
;\6: strip length
if "\1" == "north"
	map_id \3
	dw \2_Blocks + \3_WIDTH * (\3_HEIGHT - 3) + \5
	dw wOverworldMapBlocks + \4 + 3
	db \6
	db \3_WIDTH
	db \3_HEIGHT * 2 - 1
	db (\4 - \5) * -2
	dw wOverworldMapBlocks + \3_HEIGHT * (\3_WIDTH + 6) + 1
elif "\1" == "south"
	map_id \3
	dw \2_Blocks + \5
	dw wOverworldMapBlocks + (CURRENT_MAP_HEIGHT + 3) * (CURRENT_MAP_WIDTH + 6) + \4 + 3
	db \6
	db \3_WIDTH
	db 0
	db (\4 - \5) * -2
	dw wOverworldMapBlocks + \3_WIDTH + 7
elif "\1" == "west"
	map_id \3
	dw \2_Blocks + (\3_WIDTH * \5) + \3_WIDTH - 3
	dw wOverworldMapBlocks + (CURRENT_MAP_WIDTH + 6) * (\4 + 3)
	db \6
	db \3_WIDTH
	db (\4 - \5) * -2
	db \3_WIDTH * 2 - 1
	dw wOverworldMapBlocks + \3_WIDTH * 2 + 6
elif "\1" == "east"
	map_id \3
	dw \2_Blocks + (\3_WIDTH * \5)
	dw wOverworldMapBlocks + (CURRENT_MAP_WIDTH + 6) * (\4 + 3 + 1) - 3
	db \6
	db \3_WIDTH
	db (\4 - \5) * -2
	db 0
	dw wOverworldMapBlocks + \3_WIDTH + 7
endc
ENDM

SECTION "Route2Gate1F", ROMX[$4000], BANK[$25]
	map_attributes Route2Gate1F, ROUTE_2_GATE_1F, 0

SECTION "Route2Gate2F", ROMX[$407C], BANK[$25]
	map_attributes Route2Gate2F, ROUTE_2_GATE_2F, 0

SECTION "Route2House", ROMX[$40DC], BANK[$25]
	map_attributes Route2House, ROUTE_2_HOUSE, 0

SECTION "OldCityMuseum", ROMX[$414A], BANK[$25]
	map_attributes OldCityMuseum, OLD_CITY_MUSEUM, 0

SECTION "OldCityGym", ROMX[$41CD], BANK[$25]
	map_attributes OldCityGym, OLD_CITY_GYM, 0

SECTION "OldCityTower1F", ROMX[$4289], BANK[$25]
	map_attributes OldCityTower1F, OLD_CITY_TOWER_1F, 0

SECTION "OldCityTower2F", ROMX[$4319], BANK[$25]
	map_attributes OldCityTower2F, OLD_CITY_TOWER_2F, 0

SECTION "OldCityTower3F", ROMX[$439E], BANK[$25]
	map_attributes OldCityTower3F, OLD_CITY_TOWER_3F, 0

SECTION "OldCityTower4F", ROMX[$4423], BANK[$25]
	map_attributes OldCityTower4F, OLD_CITY_TOWER_4F, 0

SECTION "OldCityTower5F", ROMX[$44A8], BANK[$25]
	map_attributes OldCityTower5F, OLD_CITY_TOWER_5F, 0

SECTION "OldCityBillsHouse", ROMX[$44FC], BANK[$25]
	map_attributes OldCityBillsHouse, OLD_CITY_BILLS_HOUSE, 0

SECTION "OldCityMart", ROMX[$456A], BANK[$25]
	map_attributes OldCityMart, OLD_CITY_MART, 0

SECTION "OldCityHouse", ROMX[$45EE], BANK[$25]
	map_attributes OldCityHouse, OLD_CITY_HOUSE, 0

SECTION "OldCityPokecenter1F", ROMX[$466E], BANK[$25]
	map_attributes OldCityPokecenter1F, OLD_CITY_POKECENTER_1F, 0

SECTION "OldCityPokecenter2F", ROMX[$46FE], BANK[$25]
	map_attributes OldCityPokecenter2F, OLD_CITY_POKECENTER_2F, 0

SECTION "OldCityPokecenterTrade", ROMX[$4826], BANK[$25]
	map_attributes OldCityPokecenterTrade, OLD_CITY_POKECENTER_TRADE, 0

SECTION "OldCityPokecenterBattle", ROMX[$48AC], BANK[$25]
	map_attributes OldCityPokecenterBattle, OLD_CITY_POKECENTER_BATTLE, 0

SECTION "OldCityPokecenterTimeMachine", ROMX[$492F], BANK[$25]
	map_attributes OldCityPokecenterTimeMachine, OLD_CITY_POKECENTER_TIME_MACHINE, 0

SECTION "OldCityKurtsHouse", ROMX[$49AC], BANK[$25]
	map_attributes OldCityKurtsHouse, OLD_CITY_KURTS_HOUSE, 0

SECTION "OldCitySchool", ROMX[$4A26], BANK[$25]
	map_attributes OldCitySchool, OLD_CITY_SCHOOL, 0

SECTION "Route1Gate1F", ROMX[$4000], BANK[$26]
	map_attributes Route1Gate1F, ROUTE_1_GATE_1F, 0

SECTION "Route1Gate2F", ROMX[$40DA], BANK[$26]
	map_attributes Route1Gate2F, ROUTE_1_GATE_2F, 0

SECTION "WestMart1F", ROMX[$4224], BANK[$26]
	map_attributes WestMart1F, WEST_MART_1F, 0

SECTION "WestMart2F", ROMX[$42A0], BANK[$26]
	map_attributes WestMart2F, WEST_MART_2F, 0

SECTION "WestMart3F", ROMX[$4374], BANK[$26]
	map_attributes WestMart3F, WEST_MART_3F, 0

SECTION "WestMart4F", ROMX[$4433], BANK[$26]
	map_attributes WestMart4F, WEST_MART_4F, 0

SECTION "WestMart5F", ROMX[$44F2], BANK[$26]
	map_attributes WestMart5F, WEST_MART_5F, 0

SECTION "WestMart6F", ROMX[$4581], BANK[$26]
	map_attributes WestMart6F, WEST_MART_6F, 0

SECTION "WestMartElevator", ROMX[$460E], BANK[$26]
	map_attributes WestMartElevator, WEST_MART_ELEVATOR, 0

SECTION "WestRadioTower1F", ROMX[$464B], BANK[$26]
	map_attributes WestRadioTower1F, WEST_RADIO_TOWER_1F, 0

SECTION "WestRadioTower2F", ROMX[$46CA], BANK[$26]
	map_attributes WestRadioTower2F, WEST_RADIO_TOWER_2F, 0

SECTION "WestRadioTower3F", ROMX[$4772], BANK[$26]
	map_attributes WestRadioTower3F, WEST_RADIO_TOWER_3F, 0

SECTION "WestRadioTower4F", ROMX[$4827], BANK[$26]
	map_attributes WestRadioTower4F, WEST_RADIO_TOWER_4F, 0

SECTION "WestRadioTower5F", ROMX[$48E9], BANK[$26]
	map_attributes WestRadioTower5F, WEST_RADIO_TOWER_5F, 0

SECTION "WestRocketRaidedHouse", ROMX[$499F], BANK[$26]
	map_attributes WestRocketRaidedHouse, WEST_ROCKET_RAIDED_HOUSE, 0

SECTION "WestPokecenter1F", ROMX[$4A49], BANK[$26]
	map_attributes WestPokecenter1F, WEST_POKECENTER_1F, 0

SECTION "WestPokecenter2F", ROMX[$4AE1], BANK[$26]
	map_attributes WestPokecenter2F, WEST_POKECENTER_2F, 0

SECTION "WestGym", ROMX[$4B5E], BANK[$26]
	map_attributes WestGym, WEST_GYM, 0

SECTION "WestHouse1", ROMX[$4C1A], BANK[$26]
	map_attributes WestHouse1, WEST_HOUSE_1, 0

SECTION "WestHouse2", ROMX[$4C9E], BANK[$26]
	map_attributes WestHouse2, WEST_HOUSE_2, 0

SECTION "HaitekuWestRouteGate", ROMX[$4000], BANK[$27]
	map_attributes HaitekuWestRouteGate, HAITEKU_WEST_ROUTE_GATE, 0

SECTION "HaitekuPokecenter1F", ROMX[$405B], BANK[$27]
	map_attributes HaitekuPokecenter1F, HAITEKU_POKECENTER_1F, 0

SECTION "HaitekuPokecenter2F", ROMX[$40EF], BANK[$27]
	map_attributes HaitekuPokecenter2F, HAITEKU_POKECENTER_2F, 0

SECTION "HaitekuLeague1F", ROMX[$4168], BANK[$27]
	map_attributes HaitekuLeague1F, HAITEKU_LEAGUE_1F, 0

SECTION "HaitekuLeague2F", ROMX[$4209], BANK[$27]
	map_attributes HaitekuLeague2F, HAITEKU_LEAGUE_2F, 0

SECTION "HaitekuMart", ROMX[$42A9], BANK[$27]
	map_attributes HaitekuMart, HAITEKU_MART, 0

SECTION "HaitekuHouse1", ROMX[$4329], BANK[$27]
	map_attributes HaitekuHouse1, HAITEKU_HOUSE_1, 0

SECTION "HaitekuHouse2", ROMX[$4383], BANK[$27]
	map_attributes HaitekuHouse2, HAITEKU_HOUSE_2, 0

SECTION "HaitekuImposterOakHouse", ROMX[$43DD], BANK[$27]
	map_attributes HaitekuImposterOakHouse, HAITEKU_IMPOSTER_OAK_HOUSE, 0

SECTION "HaitekuAquarium1F", ROMX[$4444], BANK[$27]
	map_attributes HaitekuAquarium1F, HAITEKU_AQUARIUM_1F, 0

SECTION "HaitekuAquarium2F", ROMX[$44CB], BANK[$27]
	map_attributes HaitekuAquarium2F, HAITEKU_AQUARIUM_2F, 0

SECTION "FontoRouteGate1", ROMX[$4537], BANK[$27]
	map_attributes FontoRouteGate1, FONTO_ROUTE_GATE_1, 0

SECTION "FontoRouteGate2", ROMX[$4592], BANK[$27]
	map_attributes FontoRouteGate2, FONTO_ROUTE_GATE_2, 0

SECTION "FontoRouteGate3", ROMX[$45ED], BANK[$27]
	map_attributes FontoRouteGate3, FONTO_ROUTE_GATE_3, 0

SECTION "FontoRocketHouse", ROMX[$4648], BANK[$27]
	map_attributes FontoRocketHouse, FONTO_ROCKET_HOUSE, 0

SECTION "FontoMart", ROMX[$46D5], BANK[$27]
	map_attributes FontoMart, FONTO_MART, 0

SECTION "FontoHouse", ROMX[$4755], BANK[$27]
	map_attributes FontoHouse, FONTO_HOUSE, 0

SECTION "FontoPokecenter1F", ROMX[$47AF], BANK[$27]
	map_attributes FontoPokecenter1F, FONTO_POKECENTER_1F, 0

SECTION "FontoPokecenter2F", ROMX[$4843], BANK[$27]
	map_attributes FontoPokecenter2F, FONTO_POKECENTER_2F, 0

SECTION "FontoLab", ROMX[$48BC], BANK[$27]
	map_attributes FontoLab, FONTO_LAB, 0

SECTION "BaadonMart", ROMX[$4923], BANK[$27]
	map_attributes BaadonMart, BAADON_MART, 0

SECTION "BaadonPokecenter1F", ROMX[$49A3], BANK[$27]
	map_attributes BaadonPokecenter1F, BAADON_POKECENTER_1F, 0

SECTION "BaadonPokecenter2F", ROMX[$4A2A], BANK[$27]
	map_attributes BaadonPokecenter2F, BAADON_POKECENTER_2F, 0

SECTION "BaadonHouse1", ROMX[$4AA3], BANK[$27]
	map_attributes BaadonHouse1, BAADON_HOUSE_1, 0

SECTION "BaadonWallpaperHouse", ROMX[$4AF9], BANK[$27]
	map_attributes BaadonWallpaperHouse, BAADON_WALLPAPER_HOUSE, 0

SECTION "BaadonHouse2", ROMX[$4B42], BANK[$27]
	map_attributes BaadonHouse2, BAADON_HOUSE_2, 0

SECTION "BaadonLeague1F", ROMX[$4B9C], BANK[$27]
	map_attributes BaadonLeague1F, BAADON_LEAGUE_1F, 0

SECTION "BaadonLeague2F", ROMX[$4C3D], BANK[$27]
	map_attributes BaadonLeague2F, BAADON_LEAGUE_2F, 0

SECTION "BaadonRouteGateWest", ROMX[$4CDD], BANK[$27]
	map_attributes BaadonRouteGateWest, BAADON_ROUTE_GATE_WEST, 0

SECTION "BaadonRouteGateNewtype", ROMX[$4D38], BANK[$27]
	map_attributes BaadonRouteGateNewtype, BAADON_ROUTE_GATE_NEWTYPE, 0

SECTION "NewtypePokecenter1F", ROMX[$4D93], BANK[$27]
	map_attributes NewtypePokecenter1F, NEWTYPE_POKECENTER_1F, 0

SECTION "NewtypePokecenter2F", ROMX[$4E27], BANK[$27]
	map_attributes NewtypePokecenter2F, NEWTYPE_POKECENTER_2F, 0

SECTION "NewtypeLeague1F", ROMX[$4EA0], BANK[$27]
	map_attributes NewtypeLeague1F, NEWTYPE_LEAGUE_1F, 0

SECTION "NewtypeLeague2F", ROMX[$4F41], BANK[$27]
	map_attributes NewtypeLeague2F, NEWTYPE_LEAGUE_2F, 0

SECTION "NewtypeSailorHouse", ROMX[$4FE1], BANK[$27]
	map_attributes NewtypeSailorHouse, NEWTYPE_SAILOR_HOUSE, 0

SECTION "NewtypeMart", ROMX[$503B], BANK[$27]
	map_attributes NewtypeMart, NEWTYPE_MART, 0

SECTION "NewtypeDojo", ROMX[$50BB], BANK[$27]
	map_attributes NewtypeDojo, NEWTYPE_DOJO, 0

SECTION "NewtypeHouse1", ROMX[$5155], BANK[$27]
	map_attributes NewtypeHouse1, NEWTYPE_HOUSE_1, 0

SECTION "NewtypeDiner", ROMX[$51AF], BANK[$27]
	map_attributes NewtypeDiner, NEWTYPE_DINER, 0

SECTION "NewtypeHouse2", ROMX[$522C], BANK[$27]
	map_attributes NewtypeHouse2, NEWTYPE_HOUSE_2, 0

SECTION "NewtypeHouse3", ROMX[$5286], BANK[$27]
	map_attributes NewtypeHouse3, NEWTYPE_HOUSE_3, 0

SECTION "Route15Pokecenter1F", ROMX[$52E0], BANK[$27]
	map_attributes Route15Pokecenter1F, ROUTE_15_POKECENTER_1F, 0

SECTION "Route15Pokecenter2F", ROMX[$5374], BANK[$27]
	map_attributes Route15Pokecenter2F, ROUTE_15_POKECENTER_2F, 0

SECTION "NewtypeRouteGate", ROMX[$53C6], BANK[$27]
	map_attributes NewtypeRouteGate, NEWTYPE_ROUTE_GATE, 0

SECTION "Route18Pokecenter1F", ROMX[$5421], BANK[$27]
	map_attributes Route18Pokecenter1F, ROUTE_18_POKECENTER_1F, 0

SECTION "Route18Pokecenter2F", ROMX[$54B5], BANK[$27]
	map_attributes Route18Pokecenter2F, ROUTE_18_POKECENTER_2F, 0

SECTION "SugarRouteGate", ROMX[$5507], BANK[$27]
	map_attributes SugarRouteGate, SUGAR_ROUTE_GATE, 0

SECTION "SugarHouse", ROMX[$5562], BANK[$27]
	map_attributes SugarHouse, SUGAR_HOUSE, 0

SECTION "SugarHouse2", ROMX[$55E2], BANK[$27]
	map_attributes SugarHouse2, SUGAR_HOUSE_2, 0

SECTION "SugarMart", ROMX[$5638], BANK[$27]
	map_attributes SugarMart, SUGAR_MART, 0

SECTION "SugarPokecenter1F", ROMX[$56B8], BANK[$27]
	map_attributes SugarPokecenter1F, SUGAR_POKECENTER_1F, 0

SECTION "SugarPokecenter2F", ROMX[$574C], BANK[$27]
	map_attributes SugarPokecenter2F, SUGAR_POKECENTER_2F, 0

SECTION "BullForestRoute1House", ROMX[$57C5], BANK[$27]
	map_attributes BullForestRoute1House, BULL_FOREST_ROUTE_1_HOUSE, 0

SECTION "BullForestRouteGateStand", ROMX[$581F], BANK[$27]
	map_attributes BullForestRouteGateStand, BULL_FOREST_ROUTE_GATE_STAND, 0

SECTION "BullMart", ROMX[$587A], BANK[$27]
	map_attributes BullMart, BULL_MART, 0

SECTION "BullHouse1", ROMX[$58FA], BANK[$27]
	map_attributes BullHouse1, BULL_HOUSE_1, 0

SECTION "BullHouse2", ROMX[$5950], BANK[$27]
	map_attributes BullHouse2, BULL_HOUSE_2, 0

SECTION "BullHouse3", ROMX[$59AA], BANK[$27]
	map_attributes BullHouse3, BULL_HOUSE_3, 0

SECTION "BullPokecenter1F", ROMX[$5A04], BANK[$27]
	map_attributes BullPokecenter1F, BULL_POKECENTER_1F, 0

SECTION "BullPokecenter2F", ROMX[$5A98], BANK[$27]
	map_attributes BullPokecenter2F, BULL_POKECENTER_2F, 0

SECTION "BullLeague1F", ROMX[$5B11], BANK[$27]
	map_attributes BullLeague1F, BULL_LEAGUE_1F, 0

SECTION "BullLeague2F", ROMX[$5BB2], BANK[$27]
	map_attributes BullLeague2F, BULL_LEAGUE_2F, 0

SECTION "BullHouse4", ROMX[$5C52], BANK[$27]
	map_attributes BullHouse4, BULL_HOUSE_4, 0

SECTION "StandRouteGateKanto", ROMX[$5C9F], BANK[$27]
	map_attributes StandRouteGateKanto, STAND_ROUTE_GATE_KANTO, 0

SECTION "StandLab", ROMX[$5CFA], BANK[$27]
	map_attributes StandLab, STAND_LAB, 0

SECTION "StandPokecenter1F", ROMX[$5D50], BANK[$27]
	map_attributes StandPokecenter1F, STAND_POKECENTER_1F, 0

SECTION "StandPokecenter2F", ROMX[$5DE4], BANK[$27]
	map_attributes StandPokecenter2F, STAND_POKECENTER_2F, 0

SECTION "StandOffice", ROMX[$5E5D], BANK[$27]
	map_attributes StandOffice, STAND_OFFICE, 0

SECTION "StandMart", ROMX[$5EDD], BANK[$27]
	map_attributes StandMart, STAND_MART, 0

SECTION "StandHouse", ROMX[$5F5D], BANK[$27]
	map_attributes StandHouse, STAND_HOUSE, 0

SECTION "StandRocketHouse1F", ROMX[$5FB7], BANK[$27]
	map_attributes StandRocketHouse1F, STAND_ROCKET_HOUSE_1F, 0

SECTION "StandRocketHouse2F", ROMX[$6024], BANK[$27]
	map_attributes StandRocketHouse2F, STAND_ROCKET_HOUSE_2F, 0

SECTION "StandLeague1F", ROMX[$6083], BANK[$27]
	map_attributes StandLeague1F, STAND_LEAGUE_1F, 0

SECTION "StandLeague2F", ROMX[$6124], BANK[$27]
	map_attributes StandLeague2F, STAND_LEAGUE_2F, 0

SECTION "KantoCeruleanHouse", ROMX[$61C4], BANK[$27]
	map_attributes KantoCeruleanHouse, KANTO_CERULEAN_HOUSE, 0

SECTION "KantoPokecenter1F", ROMX[$621E], BANK[$27]
	map_attributes KantoPokecenter1F, KANTO_POKECENTER_1F, 0

SECTION "KantoPokecenter2F", ROMX[$62B2], BANK[$27]
	map_attributes KantoPokecenter2F, KANTO_POKECENTER_2F, 0

SECTION "KantoLeague1F", ROMX[$632B], BANK[$27]
	map_attributes KantoLeague1F, KANTO_LEAGUE_1F, 0

SECTION "KantoLeague2F", ROMX[$63CC], BANK[$27]
	map_attributes KantoLeague2F, KANTO_LEAGUE_2F, 0

SECTION "KantoLavenderHouse", ROMX[$646C], BANK[$27]
	map_attributes KantoLavenderHouse, KANTO_LAVENDER_HOUSE, 0

SECTION "KantoCeladonMart1F", ROMX[$64D3], BANK[$27]
	map_attributes KantoCeladonMart1F, KANTO_CELADON_MART_1F, 0

SECTION "KantoCeladonMart2F", ROMX[$6547], BANK[$27]
	map_attributes KantoCeladonMart2F, KANTO_CELADON_MART_2F, 0

SECTION "KantoCeladonMart3F", ROMX[$65C1], BANK[$27]
	map_attributes KantoCeladonMart3F, KANTO_CELADON_MART_3F, 0

SECTION "KantoCeladonMart4F", ROMX[$663B], BANK[$27]
	map_attributes KantoCeladonMart4F, KANTO_CELADON_MART_4F, 0

SECTION "KantoCeladonMart5F", ROMX[$66C2], BANK[$27]
	map_attributes KantoCeladonMart5F, KANTO_CELADON_MART_5F, 0

SECTION "KantoCeladonElevator", ROMX[$6742], BANK[$27]
	map_attributes KantoCeladonElevator, KANTO_CELADON_ELEVATOR, 0

SECTION "KantoMart", ROMX[$677F], BANK[$27]
	map_attributes KantoMart, KANTO_MART, 0

SECTION "KantoGamefreakHQ1", ROMX[$67FF], BANK[$27]
	map_attributes KantoGamefreakHQ1, KANTO_GAMEFREAK_HQ_1, 0

SECTION "KantoGamefreakHQ2", ROMX[$6899], BANK[$27]
	map_attributes KantoGamefreakHQ2, KANTO_GAMEFREAK_HQ_2, 0

SECTION "KantoGamefreakHQ3", ROMX[$6905], BANK[$27]
	map_attributes KantoGamefreakHQ3, KANTO_GAMEFREAK_HQ_3, 0

SECTION "KantoGamefreakHQ4", ROMX[$698B], BANK[$27]
	map_attributes KantoGamefreakHQ4, KANTO_GAMEFREAK_HQ_4, 0

SECTION "KantoGamefreakHQ5", ROMX[$69E3], BANK[$27]
	map_attributes KantoGamefreakHQ5, KANTO_GAMEFREAK_HQ_5, 0

SECTION "KantoSilphCo", ROMX[$6A2C], BANK[$27]
	map_attributes KantoSilphCo, KANTO_SILPH_CO, 0

SECTION "KantoViridianHouse", ROMX[$6ADF], BANK[$27]
	map_attributes KantoViridianHouse, KANTO_VIRIDIAN_HOUSE, 0

SECTION "KantoGameCorner", ROMX[$6B46], BANK[$27]
	map_attributes KantoGameCorner, KANTO_GAME_CORNER, 0

SECTION "KantoUnusedArea", ROMX[$6C55], BANK[$27]
	map_attributes KantoUnusedArea, KANTO_UNUSED_AREA, 0

SECTION "KantoGameCornerPrizes", ROMX[$6C90], BANK[$27]
	map_attributes KantoGameCornerPrizes, KANTO_GAME_CORNER_PRIZES, 0

SECTION "KantoDiner", ROMX[$6D04], BANK[$27]
	map_attributes KantoDiner, KANTO_DINER, 0

SECTION "KantoSchool", ROMX[$6D51], BANK[$27]
	map_attributes KantoSchool, KANTO_SCHOOL, 0

SECTION "KantoHospital", ROMX[$6DEB], BANK[$27]
	map_attributes KantoHospital, KANTO_HOSPITAL, 0

SECTION "KantoPokecenter21F", ROMX[$6E6B], BANK[$27]
	map_attributes KantoPokecenter21F, KANTO_POKECENTER_2_1F, 0

SECTION "KantoPokecenter22F", ROMX[$6EFF], BANK[$27]
	map_attributes KantoPokecenter22F, KANTO_POKECENTER_2_2F, 0

SECTION "KantoRedsHouse", ROMX[$6F78], BANK[$27]
	map_attributes KantoRedsHouse, KANTO_REDS_HOUSE, 0

SECTION "KantoGreensHouse1F", ROMX[$6FDF], BANK[$27]
	map_attributes KantoGreensHouse1F, KANTO_GREENS_HOUSE_1F, 0

SECTION "KantoGreensHouse2F", ROMX[$703C], BANK[$27]
	map_attributes KantoGreensHouse2F, KANTO_GREENS_HOUSE_2F, 0

SECTION "KantoEldersHouse", ROMX[$707E], BANK[$27]
	map_attributes KantoEldersHouse, KANTO_ELDERS_HOUSE, 0

SECTION "KantoOaksLab", ROMX[$70E5], BANK[$27]
	map_attributes KantoOaksLab, KANTO_OAKS_LAB, 0

SECTION "KantoLeague21F", ROMX[$713B], BANK[$27]
	map_attributes KantoLeague21F, KANTO_LEAGUE_2_1F, 0

SECTION "KantoLeague22F", ROMX[$71DC], BANK[$27]
	map_attributes KantoLeague22F, KANTO_LEAGUE_2_2F, 0

SECTION "KantoFishingGuru", ROMX[$727C], BANK[$27]
	map_attributes KantoFishingGuru, KANTO_FISHING_GURU, 0

SECTION "SouthHouse1", ROMX[$72D6], BANK[$27]
	map_attributes SouthHouse1, SOUTH_HOUSE_1, 0

SECTION "SouthPokecenter1F", ROMX[$7330], BANK[$27]
	map_attributes SouthPokecenter1F, SOUTH_POKECENTER_1F, 0

SECTION "SouthPokecenter2F", ROMX[$73C4], BANK[$27]
	map_attributes SouthPokecenter2F, SOUTH_POKECENTER_2F, 0

SECTION "SouthMart", ROMX[$743D], BANK[$27]
	map_attributes SouthMart, SOUTH_MART, 0

SECTION "SouthHouse2", ROMX[$74BD], BANK[$27]
	map_attributes SouthHouse2, SOUTH_HOUSE_2, 0

SECTION "NorthHouse1", ROMX[$7517], BANK[$27]
	map_attributes NorthHouse1, NORTH_HOUSE_1, 0

SECTION "NorthMart", ROMX[$7571], BANK[$27]
	map_attributes NorthMart, NORTH_MART, 0

SECTION "NorthHouse2", ROMX[$75F1], BANK[$27]
	map_attributes NorthHouse2, NORTH_HOUSE_2, 0

SECTION "NorthPokecenter1F", ROMX[$764B], BANK[$27]
	map_attributes NorthPokecenter1F, NORTH_POKECENTER_1F, 0

SECTION "NorthPokecenter2F", ROMX[$76DF], BANK[$27]
	map_attributes NorthPokecenter2F, NORTH_POKECENTER_2F, 0

SECTION "PowerPlant1", ROMX[$4000], BANK[$2F]
	map_attributes PowerPlant1, POWER_PLANT_1, 0

SECTION "PowerPlant2", ROMX[$407D], BANK[$2F]
	map_attributes PowerPlant2, POWER_PLANT_2, 0

SECTION "PowerPlant3", ROMX[$40FA], BANK[$2F]
	map_attributes PowerPlant3, POWER_PLANT_3, 0

SECTION "PowerPlant4", ROMX[$422B], BANK[$2F]
	map_attributes PowerPlant4, POWER_PLANT_4, 0

SECTION "RuinsOfAlphEntrance", ROMX[$435C], BANK[$2F]
	map_attributes RuinsOfAlphEntrance, RUINS_OF_ALPH_ENTRANCE, 0

SECTION "RuinsOfAlphMain", ROMX[$43D9], BANK[$2F]
	map_attributes RuinsOfAlphMain, RUINS_OF_ALPH_MAIN, 0

SECTION "CaveMinecarts1", ROMX[$469F], BANK[$2F]
	map_attributes CaveMinecarts1, CAVE_MINECARTS_1, 0

SECTION "CaveMinecarts2", ROMX[$482A], BANK[$2F]
	map_attributes CaveMinecarts2, CAVE_MINECARTS_2, 0

SECTION "CaveMinecarts3", ROMX[$49B5], BANK[$2F]
	map_attributes CaveMinecarts3, CAVE_MINECARTS_3, 0

SECTION "CaveMinecarts4", ROMX[$4B40], BANK[$2F]
	map_attributes CaveMinecarts4, CAVE_MINECARTS_4, 0

SECTION "CaveMinecarts5", ROMX[$4CCB], BANK[$2F]
	map_attributes CaveMinecarts5, CAVE_MINECARTS_5, 0

SECTION "CaveMinecarts6", ROMX[$4E56], BANK[$2F]
	map_attributes CaveMinecarts6, CAVE_MINECARTS_6, 0

SECTION "CaveMinecarts7", ROMX[$4F2D], BANK[$2F]
	map_attributes CaveMinecarts7, CAVE_MINECARTS_7, 0

SECTION "Office1", ROMX[$5004], BANK[$2F]
	map_attributes Office1, OFFICE_1, 0

SECTION "Office2", ROMX[$5081], BANK[$2F]
	map_attributes Office2, OFFICE_2, 0

SECTION "Office3", ROMX[$51B2], BANK[$2F]
	map_attributes Office3, OFFICE_3, 0

SECTION "SlowpokeWellEntrance", ROMX[$5289], BANK[$2F]
	map_attributes SlowpokeWellEntrance, SLOWPOKE_WELL_ENTRANCE, 0

SECTION "SlowpokeWellMain", ROMX[$5306], BANK[$2F]
	map_attributes SlowpokeWellMain, SLOWPOKE_WELL_MAIN, 0

SECTION "ShizukanaOka", ROMX[$53DD], BANK[$2F]
	map_attributes ShizukanaOka, SHIZUKANA_OKA, 0

SECTION "RouteSilentEastGate", ROMX[$4000], BANK[$34]
	map_attributes RouteSilentEastGate, ROUTE_SILENT_EAST_GATE, 0

SECTION "PlayerHouse1F", ROMX[$4042], BANK[$34]
	map_attributes PlayerHouse1F, PLAYER_HOUSE_1F, 0

SECTION "PlayerHouse2F", ROMX[$4132], BANK[$34]
	map_attributes PlayerHouse2F, PLAYER_HOUSE_2F, 0

SECTION "SilentPokecenter", ROMX[$45FF], BANK[$34]
	map_attributes SilentPokecenter, SILENT_POKECENTER, 0

SECTION "SilentHillHouse", ROMX[$47D5], BANK[$34]
	map_attributes SilentHillHouse, SILENT_HILL_HOUSE, 0

SECTION "SilentHillLab", ROMX[$4AAC], BANK[$34]
	map_attributes SilentHillLab, SILENT_HILL_LAB, 0

SECTION "SilentHillLab2", ROMX[$5BE6], BANK[$34]
	map_attributes SilentHillLab2, SILENT_HILL_LAB_2, 0

SECTION "Unused13", ROMX[$605D], BANK[$34]
	map_attributes Unused13, UNUSED_13, 0

SECTION "SilentHill", ROMX[$4014], BANK[$36]
	map_attributes SilentHill, SILENT_HILL, NORTH | WEST | EAST
	connection north, PrinceRoute, PRINCE_ROUTE, 0, 0, 10
	connection west, Route1P1, ROUTE_1_P1, 0, 0, 9
	connection east, RouteSilentEast, ROUTE_SILENT_EAST, 0, 0, 9

SECTION "OldCity", ROMX[$410D], BANK[$36]
	map_attributes OldCity, OLD_CITY, SOUTH | WEST
	connection south, Route1P2, ROUTE_1_P2, 5, 0, 10
	connection west, Route2, ROUTE_2, 5, 0, 9

SECTION "West", ROMX[$4372], BANK[$36]
	map_attributes West, WEST, NORTH | EAST
	connection north, BaadonRoute1, BAADON_ROUTE_1, 5, 0, 10
	connection east, Route2, ROUTE_2, 5, 0, 9

SECTION "Haiteku", ROMX[$45D2], BANK[$36]
	map_attributes Haiteku, HAITEKU, WEST
	connection west, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 0, 0, 9

SECTION "Fonto", ROMX[$47F8], BANK[$36]
	map_attributes Fonto, FONTO, NORTH | WEST | EAST
	connection north, FontoRoute2, FONTO_ROUTE_2, 0, 0, 10
	connection west, FontoRoute1, FONTO_ROUTE_1, 0, 0, 9
	connection east, FontoRoute3, FONTO_ROUTE_3, 0, 0, 9

SECTION "Baadon", ROMX[$48F3], BANK[$36]
	map_attributes Baadon, BAADON, NORTH | SOUTH | EAST
	connection north, FontoRoute4, FONTO_ROUTE_4, 0, 0, 10
	connection south, BaadonRoute1, BAADON_ROUTE_1, 0, 0, 10
	connection east, BaadonRoute2, BAADON_ROUTE_2, 0, 0, 9

SECTION "Newtype", ROMX[$49F9], BANK[$36]
	map_attributes Newtype, NEWTYPE, NORTH | WEST | EAST
	connection north, SugarRoute, SUGAR_ROUTE, 5, 0, 10
	connection west, Route15, ROUTE_15, 0, 0, 9
	connection east, NewtypeRoute, NEWTYPE_ROUTE, 9, 0, 9

SECTION "Sugar", ROMX[$4C3A], BANK[$36]
	map_attributes Sugar, SUGAR, SOUTH
	connection south, SugarRoute, SUGAR_ROUTE, 0, 0, 10

SECTION "BullForest", ROMX[$4D05], BANK[$36]
	map_attributes BullForest, BULL_FOREST, NORTH | SOUTH | WEST
	connection north, BullForestRoute3, BULL_FOREST_ROUTE_3, 5, 0, 10
	connection south, BullForestRoute2, BULL_FOREST_ROUTE_2, 5, 0, 10
	connection west, BullForestRoute1, BULL_FOREST_ROUTE_1, 9, 0, 9

SECTION "Stand", ROMX[$4F28], BANK[$36]
	map_attributes Stand, STAND, NORTH | SOUTH
	connection north, BullForestRoute2, BULL_FOREST_ROUTE_2, 10, 0, 10
	connection south, StandRoute, STAND_ROUTE, 10, 0, 10

SECTION "Kanto", ROMX[$519D], BANK[$36]
	map_attributes Kanto, KANTO, WEST | EAST
	connection west, RouteSilentEast, ROUTE_SILENT_EAST, 9, 0, 9
	connection east, KantoEastRoute, KANTO_EAST_ROUTE, 9, 0, 9

SECTION "Prince", ROMX[$55F3], BANK[$36]
	map_attributes Prince, PRINCE, NORTH | SOUTH
	connection north, MtFujiRoute, MT_FUJI_ROUTE, 0, 0, 10
	connection south, PrinceRoute, PRINCE_ROUTE, 0, 0, 10

SECTION "MtFuji", ROMX[$5677], BANK[$36]
	map_attributes MtFuji, MT_FUJI, SOUTH
	connection south, MtFujiRoute, MT_FUJI_ROUTE, 0, 0, 10

SECTION "South", ROMX[$56EF], BANK[$36]
	map_attributes South, SOUTH, NORTH | SOUTH | EAST
	connection north, FontoRoute5, FONTO_ROUTE_5, 10, 0, 10
	connection south, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, 10, 0, 10
	connection east, FontoRoute1, FONTO_ROUTE_1, 0, 0, 9

SECTION "North", ROMX[$5914], BANK[$36]
	map_attributes North, NORTH, SOUTH
	connection south, BullForestRoute3, BULL_FOREST_ROUTE_3, 0, 0, 10

SECTION "Route1P1", ROMX[$59DF], BANK[$36]
	map_attributes Route1P1, ROUTE_1_P1, WEST | EAST
	connection west, Route1P2, ROUTE_1_P2, -3, 6, 12
	connection east, SilentHill, SILENT_HILL, 0, 0, 9

SECTION "Route1P2", ROMX[$5ABE], BANK[$36]
	map_attributes Route1P2, ROUTE_1_P2, NORTH | EAST
	connection north, OldCity, OLD_CITY, -3, 2, 16
	connection east, Route1P1, ROUTE_1_P1, 9, 0, 9

SECTION "Route2", ROMX[$5BD4], BANK[$36]
	map_attributes Route2, ROUTE_2, WEST | EAST
	connection west, West, WEST, -3, 2, 15
	connection east, OldCity, OLD_CITY, -3, 2, 15

SECTION "HaitekuWestRoute", ROMX[$5CC6], BANK[$36]
	map_attributes HaitekuWestRoute, HAITEKU_WEST_ROUTE, WEST | EAST
	connection west, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, -3, 15, 12
	connection east, Haiteku, HAITEKU, 0, 0, 12

SECTION "HaitekuWestRouteOcean", ROMX[$5DD1], BANK[$36]
	map_attributes HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, NORTH | EAST
	connection north, South, SOUTH, -3, 7, 13
	connection east, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 18, 0, 9

SECTION "FontoRoute1", ROMX[$5F17], BANK[$36]
	map_attributes FontoRoute1, FONTO_ROUTE_1, WEST | EAST
	connection west, South, SOUTH, 0, 0, 12
	connection east, Fonto, FONTO, 0, 0, 9

SECTION "FontoRoute6", ROMX[$6083], BANK[$36]
	map_attributes FontoRoute6, FONTO_ROUTE_6, WEST | EAST
	connection west, FontoRoute5, FONTO_ROUTE_5, 0, 0, 12
	connection east, FontoRoute2, FONTO_ROUTE_2, 0, 0, 12

SECTION "FontoRoute2", ROMX[$61E8], BANK[$36]
	map_attributes FontoRoute2, FONTO_ROUTE_2, SOUTH | WEST
	connection south, Fonto, FONTO, 0, 0, 10
	connection west, FontoRoute6, FONTO_ROUTE_6, 0, 0, 9

SECTION "FontoRoute4", ROMX[$62C6], BANK[$36]
	map_attributes FontoRoute4, FONTO_ROUTE_4, SOUTH | WEST
	connection south, Baadon, BAADON, 0, 0, 10
	connection west, FontoRoute3, FONTO_ROUTE_3, 0, 0, 9

SECTION "FontoRoute3", ROMX[$63B2], BANK[$36]
	map_attributes FontoRoute3, FONTO_ROUTE_3, WEST | EAST
	connection west, Fonto, FONTO, 0, 0, 9
	connection east, FontoRoute4, FONTO_ROUTE_4, 0, 0, 12

SECTION "BaadonRoute1", ROMX[$64BD], BANK[$36]
	map_attributes BaadonRoute1, BAADON_ROUTE_1, NORTH | SOUTH
	connection north, Baadon, BAADON, 0, 0, 10
	connection south, West, WEST, -3, 2, 16

SECTION "BaadonRoute2", ROMX[$6603], BANK[$36]
	map_attributes BaadonRoute2, BAADON_ROUTE_2, WEST | EAST
	connection west, Baadon, BAADON, 0, 0, 9
	connection east, BaadonRoute3, BAADON_ROUTE_3, 0, 0, 12

SECTION "BaadonRoute3", ROMX[$67EF], BANK[$36]
	map_attributes BaadonRoute3, BAADON_ROUTE_3, SOUTH | WEST
	connection south, Route15, ROUTE_15, 0, 0, 13
	connection west, BaadonRoute2, BAADON_ROUTE_2, 0, 0, 9

SECTION "Route15", ROMX[$68DB], BANK[$36]
	map_attributes Route15, ROUTE_15, NORTH | EAST
	connection north, BaadonRoute3, BAADON_ROUTE_3, 0, 0, 10
	connection east, Newtype, NEWTYPE, 0, 0, 12

SECTION "NewtypeRoute", ROMX[$69BD], BANK[$36]
	map_attributes NewtypeRoute, NEWTYPE_ROUTE, WEST | EAST
	connection west, Newtype, NEWTYPE, -3, 6, 12
	connection east, Route18, ROUTE_18, -3, 33, 12

SECTION "Route18", ROMX[$6A6E], BANK[$36]
	map_attributes Route18, ROUTE_18, NORTH | WEST
	connection north, BullForestRoute1, BULL_FOREST_ROUTE_1, 0, 0, 13
	connection west, NewtypeRoute, NEWTYPE_ROUTE, 36, 0, 9

SECTION "BullForestRoute1", ROMX[$6C6F], BANK[$36]
	map_attributes BullForestRoute1, BULL_FOREST_ROUTE_1, SOUTH | EAST
	connection south, Route18, ROUTE_18, 0, 0, 10
	connection east, BullForest, BULL_FOREST, -3, 6, 12

SECTION "SugarRoute", ROMX[$6D8F], BANK[$36]
	map_attributes SugarRoute, SUGAR_ROUTE, NORTH | SOUTH
	connection north, Sugar, SUGAR, 0, 0, 10
	connection south, Newtype, NEWTYPE, -3, 2, 16

SECTION "BullForestRoute2", ROMX[$6ED5], BANK[$36]
	map_attributes BullForestRoute2, BULL_FOREST_ROUTE_2, NORTH | SOUTH
	connection north, BullForest, BULL_FOREST, -3, 2, 16
	connection south, Stand, STAND, -3, 7, 13

SECTION "StandRoute", ROMX[$701B], BANK[$36]
	map_attributes StandRoute, STAND_ROUTE, NORTH | SOUTH
	connection north, Stand, STAND, -3, 7, 13
	connection south, KantoEastRoute, KANTO_EAST_ROUTE, -3, 7, 13

SECTION "KantoEastRoute", ROMX[$7161], BANK[$36]
	map_attributes KantoEastRoute, KANTO_EAST_ROUTE, NORTH | WEST
	connection north, StandRoute, STAND_ROUTE, 10, 0, 10
	connection west, Kanto, KANTO, -3, 6, 15

SECTION "RouteSilentEast", ROMX[$724D], BANK[$36]
	map_attributes RouteSilentEast, ROUTE_SILENT_EAST, WEST | EAST
	connection west, SilentHill, SILENT_HILL, 0, 0, 9
	connection east, Kanto, KANTO, -3, 6, 15

SECTION "PrinceRoute", ROMX[$738C], BANK[$36]
	map_attributes PrinceRoute, PRINCE_ROUTE, NORTH | SOUTH
	connection north, Prince, PRINCE, 0, 0, 10
	connection south, SilentHill, SILENT_HILL, 0, 0, 10

SECTION "MtFujiRoute", ROMX[$73E8], BANK[$36]
	map_attributes MtFujiRoute, MT_FUJI_ROUTE, NORTH | SOUTH
	connection north, MtFuji, MT_FUJI, 0, 0, 10
	connection south, Prince, PRINCE, 0, 0, 10

SECTION "FontoRoute5", ROMX[$7444], BANK[$36]
	map_attributes FontoRoute5, FONTO_ROUTE_5, SOUTH | EAST
	connection south, South, SOUTH, -3, 7, 13
	connection east, FontoRoute6, FONTO_ROUTE_6, 0, 0, 9

SECTION "BullForestRoute3", ROMX[$7530], BANK[$36]
	map_attributes BullForestRoute3, BULL_FOREST_ROUTE_3, NORTH | SOUTH
	connection north, North, NORTH, 0, 0, 10
	connection south, BullForest, BULL_FOREST, -3, 2, 16
