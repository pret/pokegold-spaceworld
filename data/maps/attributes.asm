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

SECTION "data/maps/attributes.asm@Route2Gate1F", ROMX
	map_attributes Route2Gate1F, ROUTE_2_GATE_1F, 0

SECTION "data/maps/attributes.asm@Route2Gate2F", ROMX
	map_attributes Route2Gate2F, ROUTE_2_GATE_2F, 0

SECTION "data/maps/attributes.asm@Route2House", ROMX
	map_attributes Route2House, ROUTE_2_HOUSE, 0

SECTION "data/maps/attributes.asm@OldCityMuseum", ROMX
	map_attributes OldCityMuseum, OLD_CITY_MUSEUM, 0

SECTION "data/maps/attributes.asm@OldCityGym", ROMX
	map_attributes OldCityGym, OLD_CITY_GYM, 0

SECTION "data/maps/attributes.asm@OldCityTower1F", ROMX
	map_attributes OldCityTower1F, OLD_CITY_TOWER_1F, 0

SECTION "data/maps/attributes.asm@OldCityTower2F", ROMX
	map_attributes OldCityTower2F, OLD_CITY_TOWER_2F, 0

SECTION "data/maps/attributes.asm@OldCityTower3F", ROMX
	map_attributes OldCityTower3F, OLD_CITY_TOWER_3F, 0

SECTION "data/maps/attributes.asm@OldCityTower4F", ROMX
	map_attributes OldCityTower4F, OLD_CITY_TOWER_4F, 0

SECTION "data/maps/attributes.asm@OldCityTower5F", ROMX
	map_attributes OldCityTower5F, OLD_CITY_TOWER_5F, 0

SECTION "data/maps/attributes.asm@OldCityBillsHouse", ROMX
	map_attributes OldCityBillsHouse, OLD_CITY_BILLS_HOUSE, 0

SECTION "data/maps/attributes.asm@OldCityMart", ROMX
	map_attributes OldCityMart, OLD_CITY_MART, 0

SECTION "data/maps/attributes.asm@OldCityHouse", ROMX
	map_attributes OldCityHouse, OLD_CITY_HOUSE, 0

SECTION "data/maps/attributes.asm@OldCityPokecenter1F", ROMX
	map_attributes OldCityPokecenter1F, OLD_CITY_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@OldCityPokecenter2F", ROMX
	map_attributes OldCityPokecenter2F, OLD_CITY_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@OldCityPokecenterTrade", ROMX
	map_attributes OldCityPokecenterTrade, OLD_CITY_POKECENTER_TRADE, 0

SECTION "data/maps/attributes.asm@OldCityPokecenterBattle", ROMX
	map_attributes OldCityPokecenterBattle, OLD_CITY_POKECENTER_BATTLE, 0

SECTION "data/maps/attributes.asm@OldCityPokecenterTimeMachine", ROMX
	map_attributes OldCityPokecenterTimeMachine, OLD_CITY_POKECENTER_TIME_MACHINE, 0

SECTION "data/maps/attributes.asm@OldCityKurtsHouse", ROMX
	map_attributes OldCityKurtsHouse, OLD_CITY_KURTS_HOUSE, 0

SECTION "data/maps/attributes.asm@OldCitySchool", ROMX
	map_attributes OldCitySchool, OLD_CITY_SCHOOL, 0

SECTION "data/maps/attributes.asm@Route1Gate1F", ROMX
	map_attributes Route1Gate1F, ROUTE_1_GATE_1F, 0

SECTION "data/maps/attributes.asm@Route1Gate2F", ROMX
	map_attributes Route1Gate2F, ROUTE_1_GATE_2F, 0

SECTION "data/maps/attributes.asm@WestMart1F", ROMX
	map_attributes WestMart1F, WEST_MART_1F, 0

SECTION "data/maps/attributes.asm@WestMart2F", ROMX
	map_attributes WestMart2F, WEST_MART_2F, 0

SECTION "data/maps/attributes.asm@WestMart3F", ROMX
	map_attributes WestMart3F, WEST_MART_3F, 0

SECTION "data/maps/attributes.asm@WestMart4F", ROMX
	map_attributes WestMart4F, WEST_MART_4F, 0

SECTION "data/maps/attributes.asm@WestMart5F", ROMX
	map_attributes WestMart5F, WEST_MART_5F, 0

SECTION "data/maps/attributes.asm@WestMart6F", ROMX
	map_attributes WestMart6F, WEST_MART_6F, 0

SECTION "data/maps/attributes.asm@WestMartElevator", ROMX
	map_attributes WestMartElevator, WEST_MART_ELEVATOR, 0

SECTION "data/maps/attributes.asm@WestRadioTower1F", ROMX
	map_attributes WestRadioTower1F, WEST_RADIO_TOWER_1F, 0

SECTION "data/maps/attributes.asm@WestRadioTower2F", ROMX
	map_attributes WestRadioTower2F, WEST_RADIO_TOWER_2F, 0

SECTION "data/maps/attributes.asm@WestRadioTower3F", ROMX
	map_attributes WestRadioTower3F, WEST_RADIO_TOWER_3F, 0

SECTION "data/maps/attributes.asm@WestRadioTower4F", ROMX
	map_attributes WestRadioTower4F, WEST_RADIO_TOWER_4F, 0

SECTION "data/maps/attributes.asm@WestRadioTower5F", ROMX
	map_attributes WestRadioTower5F, WEST_RADIO_TOWER_5F, 0

SECTION "data/maps/attributes.asm@WestRocketRaidedHouse", ROMX
	map_attributes WestRocketRaidedHouse, WEST_ROCKET_RAIDED_HOUSE, 0

SECTION "data/maps/attributes.asm@WestPokecenter1F", ROMX
	map_attributes WestPokecenter1F, WEST_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@WestPokecenter2F", ROMX
	map_attributes WestPokecenter2F, WEST_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@WestGym", ROMX
	map_attributes WestGym, WEST_GYM, 0

SECTION "data/maps/attributes.asm@WestHouse1", ROMX
	map_attributes WestHouse1, WEST_HOUSE_1, 0

SECTION "data/maps/attributes.asm@WestHouse2", ROMX
	map_attributes WestHouse2, WEST_HOUSE_2, 0

SECTION "data/maps/attributes.asm@HaitekuWestRouteGate", ROMX
	map_attributes HaitekuWestRouteGate, HAITEKU_WEST_ROUTE_GATE, 0

SECTION "data/maps/attributes.asm@HaitekuPokecenter1F", ROMX
	map_attributes HaitekuPokecenter1F, HAITEKU_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@HaitekuPokecenter2F", ROMX
	map_attributes HaitekuPokecenter2F, HAITEKU_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@HaitekuLeague1F", ROMX
	map_attributes HaitekuLeague1F, HAITEKU_LEAGUE_1F, 0

SECTION "data/maps/attributes.asm@HaitekuLeague2F", ROMX
	map_attributes HaitekuLeague2F, HAITEKU_LEAGUE_2F, 0

SECTION "data/maps/attributes.asm@HaitekuMart", ROMX
	map_attributes HaitekuMart, HAITEKU_MART, 0

SECTION "data/maps/attributes.asm@HaitekuHouse1", ROMX
	map_attributes HaitekuHouse1, HAITEKU_HOUSE_1, 0

SECTION "data/maps/attributes.asm@HaitekuHouse2", ROMX
	map_attributes HaitekuHouse2, HAITEKU_HOUSE_2, 0

SECTION "data/maps/attributes.asm@HaitekuImposterOakHouse", ROMX
	map_attributes HaitekuImposterOakHouse, HAITEKU_IMPOSTER_OAK_HOUSE, 0

SECTION "data/maps/attributes.asm@HaitekuAquarium1F", ROMX
	map_attributes HaitekuAquarium1F, HAITEKU_AQUARIUM_1F, 0

SECTION "data/maps/attributes.asm@HaitekuAquarium2F", ROMX
	map_attributes HaitekuAquarium2F, HAITEKU_AQUARIUM_2F, 0

SECTION "data/maps/attributes.asm@FontoRouteGate1", ROMX
	map_attributes FontoRouteGate1, FONTO_ROUTE_GATE_1, 0

SECTION "data/maps/attributes.asm@FontoRouteGate2", ROMX
	map_attributes FontoRouteGate2, FONTO_ROUTE_GATE_2, 0

SECTION "data/maps/attributes.asm@FontoRouteGate3", ROMX
	map_attributes FontoRouteGate3, FONTO_ROUTE_GATE_3, 0

SECTION "data/maps/attributes.asm@FontoRocketHouse", ROMX
	map_attributes FontoRocketHouse, FONTO_ROCKET_HOUSE, 0

SECTION "data/maps/attributes.asm@FontoMart", ROMX
	map_attributes FontoMart, FONTO_MART, 0

SECTION "data/maps/attributes.asm@FontoHouse", ROMX
	map_attributes FontoHouse, FONTO_HOUSE, 0

SECTION "data/maps/attributes.asm@FontoPokecenter1F", ROMX
	map_attributes FontoPokecenter1F, FONTO_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@FontoPokecenter2F", ROMX
	map_attributes FontoPokecenter2F, FONTO_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@FontoLab", ROMX
	map_attributes FontoLab, FONTO_LAB, 0

SECTION "data/maps/attributes.asm@BaadonMart", ROMX
	map_attributes BaadonMart, BAADON_MART, 0

SECTION "data/maps/attributes.asm@BaadonPokecenter1F", ROMX
	map_attributes BaadonPokecenter1F, BAADON_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@BaadonPokecenter2F", ROMX
	map_attributes BaadonPokecenter2F, BAADON_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@BaadonHouse1", ROMX
	map_attributes BaadonHouse1, BAADON_HOUSE_1, 0

SECTION "data/maps/attributes.asm@BaadonWallpaperHouse", ROMX
	map_attributes BaadonWallpaperHouse, BAADON_WALLPAPER_HOUSE, 0

SECTION "data/maps/attributes.asm@BaadonHouse2", ROMX
	map_attributes BaadonHouse2, BAADON_HOUSE_2, 0

SECTION "data/maps/attributes.asm@BaadonLeague1F", ROMX
	map_attributes BaadonLeague1F, BAADON_LEAGUE_1F, 0

SECTION "data/maps/attributes.asm@BaadonLeague2F", ROMX
	map_attributes BaadonLeague2F, BAADON_LEAGUE_2F, 0

SECTION "data/maps/attributes.asm@BaadonRouteGateWest", ROMX
	map_attributes BaadonRouteGateWest, BAADON_ROUTE_GATE_WEST, 0

SECTION "data/maps/attributes.asm@BaadonRouteGateNewtype", ROMX
	map_attributes BaadonRouteGateNewtype, BAADON_ROUTE_GATE_NEWTYPE, 0

SECTION "data/maps/attributes.asm@NewtypePokecenter1F", ROMX
	map_attributes NewtypePokecenter1F, NEWTYPE_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@NewtypePokecenter2F", ROMX
	map_attributes NewtypePokecenter2F, NEWTYPE_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@NewtypeLeague1F", ROMX
	map_attributes NewtypeLeague1F, NEWTYPE_LEAGUE_1F, 0

SECTION "data/maps/attributes.asm@NewtypeLeague2F", ROMX
	map_attributes NewtypeLeague2F, NEWTYPE_LEAGUE_2F, 0

SECTION "data/maps/attributes.asm@NewtypeSailorHouse", ROMX
	map_attributes NewtypeSailorHouse, NEWTYPE_SAILOR_HOUSE, 0

SECTION "data/maps/attributes.asm@NewtypeMart", ROMX
	map_attributes NewtypeMart, NEWTYPE_MART, 0

SECTION "data/maps/attributes.asm@NewtypeDojo", ROMX
	map_attributes NewtypeDojo, NEWTYPE_DOJO, 0

SECTION "data/maps/attributes.asm@NewtypeHouse1", ROMX
	map_attributes NewtypeHouse1, NEWTYPE_HOUSE_1, 0

SECTION "data/maps/attributes.asm@NewtypeDiner", ROMX
	map_attributes NewtypeDiner, NEWTYPE_DINER, 0

SECTION "data/maps/attributes.asm@NewtypeHouse2", ROMX
	map_attributes NewtypeHouse2, NEWTYPE_HOUSE_2, 0

SECTION "data/maps/attributes.asm@NewtypeHouse3", ROMX
	map_attributes NewtypeHouse3, NEWTYPE_HOUSE_3, 0

SECTION "data/maps/attributes.asm@Route15Pokecenter1F", ROMX
	map_attributes Route15Pokecenter1F, ROUTE_15_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@Route15Pokecenter2F", ROMX
	map_attributes Route15Pokecenter2F, ROUTE_15_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@NewtypeRouteGate", ROMX
	map_attributes NewtypeRouteGate, NEWTYPE_ROUTE_GATE, 0

SECTION "data/maps/attributes.asm@Route18Pokecenter1F", ROMX
	map_attributes Route18Pokecenter1F, ROUTE_18_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@Route18Pokecenter2F", ROMX
	map_attributes Route18Pokecenter2F, ROUTE_18_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@SugarRouteGate", ROMX
	map_attributes SugarRouteGate, SUGAR_ROUTE_GATE, 0

SECTION "data/maps/attributes.asm@SugarHouse", ROMX
	map_attributes SugarHouse, SUGAR_HOUSE, 0

SECTION "data/maps/attributes.asm@SugarHouse2", ROMX
	map_attributes SugarHouse2, SUGAR_HOUSE_2, 0

SECTION "data/maps/attributes.asm@SugarMart", ROMX
	map_attributes SugarMart, SUGAR_MART, 0

SECTION "data/maps/attributes.asm@SugarPokecenter1F", ROMX
	map_attributes SugarPokecenter1F, SUGAR_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@SugarPokecenter2F", ROMX
	map_attributes SugarPokecenter2F, SUGAR_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@BullForestRoute1House", ROMX
	map_attributes BullForestRoute1House, BULL_FOREST_ROUTE_1_HOUSE, 0

SECTION "data/maps/attributes.asm@BullForestRouteGateStand", ROMX
	map_attributes BullForestRouteGateStand, BULL_FOREST_ROUTE_GATE_STAND, 0

SECTION "data/maps/attributes.asm@BullMart", ROMX
	map_attributes BullMart, BULL_MART, 0

SECTION "data/maps/attributes.asm@BullHouse1", ROMX
	map_attributes BullHouse1, BULL_HOUSE_1, 0

SECTION "data/maps/attributes.asm@BullHouse2", ROMX
	map_attributes BullHouse2, BULL_HOUSE_2, 0

SECTION "data/maps/attributes.asm@BullHouse3", ROMX
	map_attributes BullHouse3, BULL_HOUSE_3, 0

SECTION "data/maps/attributes.asm@BullPokecenter1F", ROMX
	map_attributes BullPokecenter1F, BULL_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@BullPokecenter2F", ROMX
	map_attributes BullPokecenter2F, BULL_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@BullLeague1F", ROMX
	map_attributes BullLeague1F, BULL_LEAGUE_1F, 0

SECTION "data/maps/attributes.asm@BullLeague2F", ROMX
	map_attributes BullLeague2F, BULL_LEAGUE_2F, 0

SECTION "data/maps/attributes.asm@BullHouse4", ROMX
	map_attributes BullHouse4, BULL_HOUSE_4, 0

SECTION "data/maps/attributes.asm@StandRouteGateKanto", ROMX
	map_attributes StandRouteGateKanto, STAND_ROUTE_GATE_KANTO, 0

SECTION "data/maps/attributes.asm@StandLab", ROMX
	map_attributes StandLab, STAND_LAB, 0

SECTION "data/maps/attributes.asm@StandPokecenter1F", ROMX
	map_attributes StandPokecenter1F, STAND_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@StandPokecenter2F", ROMX
	map_attributes StandPokecenter2F, STAND_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@StandOffice", ROMX
	map_attributes StandOffice, STAND_OFFICE, 0

SECTION "data/maps/attributes.asm@StandMart", ROMX
	map_attributes StandMart, STAND_MART, 0

SECTION "data/maps/attributes.asm@StandHouse", ROMX
	map_attributes StandHouse, STAND_HOUSE, 0

SECTION "data/maps/attributes.asm@StandRocketHouse1F", ROMX
	map_attributes StandRocketHouse1F, STAND_ROCKET_HOUSE_1F, 0

SECTION "data/maps/attributes.asm@StandRocketHouse2F", ROMX
	map_attributes StandRocketHouse2F, STAND_ROCKET_HOUSE_2F, 0

SECTION "data/maps/attributes.asm@StandLeague1F", ROMX
	map_attributes StandLeague1F, STAND_LEAGUE_1F, 0

SECTION "data/maps/attributes.asm@StandLeague2F", ROMX
	map_attributes StandLeague2F, STAND_LEAGUE_2F, 0

SECTION "data/maps/attributes.asm@KantoCeruleanHouse", ROMX
	map_attributes KantoCeruleanHouse, KANTO_CERULEAN_HOUSE, 0

SECTION "data/maps/attributes.asm@KantoPokecenter1F", ROMX
	map_attributes KantoPokecenter1F, KANTO_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@KantoPokecenter2F", ROMX
	map_attributes KantoPokecenter2F, KANTO_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@KantoLeague1F", ROMX
	map_attributes KantoLeague1F, KANTO_LEAGUE_1F, 0

SECTION "data/maps/attributes.asm@KantoLeague2F", ROMX
	map_attributes KantoLeague2F, KANTO_LEAGUE_2F, 0

SECTION "data/maps/attributes.asm@KantoLavenderHouse", ROMX
	map_attributes KantoLavenderHouse, KANTO_LAVENDER_HOUSE, 0

SECTION "data/maps/attributes.asm@KantoCeladonMart1F", ROMX
	map_attributes KantoCeladonMart1F, KANTO_CELADON_MART_1F, 0

SECTION "data/maps/attributes.asm@KantoCeladonMart2F", ROMX
	map_attributes KantoCeladonMart2F, KANTO_CELADON_MART_2F, 0

SECTION "data/maps/attributes.asm@KantoCeladonMart3F", ROMX
	map_attributes KantoCeladonMart3F, KANTO_CELADON_MART_3F, 0

SECTION "data/maps/attributes.asm@KantoCeladonMart4F", ROMX
	map_attributes KantoCeladonMart4F, KANTO_CELADON_MART_4F, 0

SECTION "data/maps/attributes.asm@KantoCeladonMart5F", ROMX
	map_attributes KantoCeladonMart5F, KANTO_CELADON_MART_5F, 0

SECTION "data/maps/attributes.asm@KantoCeladonElevator", ROMX
	map_attributes KantoCeladonElevator, KANTO_CELADON_ELEVATOR, 0

SECTION "data/maps/attributes.asm@KantoMart", ROMX
	map_attributes KantoMart, KANTO_MART, 0

SECTION "data/maps/attributes.asm@KantoGamefreakHQ1", ROMX
	map_attributes KantoGamefreakHQ1, KANTO_GAMEFREAK_HQ_1, 0

SECTION "data/maps/attributes.asm@KantoGamefreakHQ2", ROMX
	map_attributes KantoGamefreakHQ2, KANTO_GAMEFREAK_HQ_2, 0

SECTION "data/maps/attributes.asm@KantoGamefreakHQ3", ROMX
	map_attributes KantoGamefreakHQ3, KANTO_GAMEFREAK_HQ_3, 0

SECTION "data/maps/attributes.asm@KantoGamefreakHQ4", ROMX
	map_attributes KantoGamefreakHQ4, KANTO_GAMEFREAK_HQ_4, 0

SECTION "data/maps/attributes.asm@KantoGamefreakHQ5", ROMX
	map_attributes KantoGamefreakHQ5, KANTO_GAMEFREAK_HQ_5, 0

SECTION "data/maps/attributes.asm@KantoSilphCo", ROMX
	map_attributes KantoSilphCo, KANTO_SILPH_CO, 0

SECTION "data/maps/attributes.asm@KantoViridianHouse", ROMX
	map_attributes KantoViridianHouse, KANTO_VIRIDIAN_HOUSE, 0

SECTION "data/maps/attributes.asm@KantoGameCorner", ROMX
	map_attributes KantoGameCorner, KANTO_GAME_CORNER, 0

SECTION "data/maps/attributes.asm@KantoUnusedArea", ROMX
	map_attributes KantoUnusedArea, KANTO_UNUSED_AREA, 0

SECTION "data/maps/attributes.asm@KantoGameCornerPrizes", ROMX
	map_attributes KantoGameCornerPrizes, KANTO_GAME_CORNER_PRIZES, 0

SECTION "data/maps/attributes.asm@KantoDiner", ROMX
	map_attributes KantoDiner, KANTO_DINER, 0

SECTION "data/maps/attributes.asm@KantoSchool", ROMX
	map_attributes KantoSchool, KANTO_SCHOOL, 0

SECTION "data/maps/attributes.asm@KantoHospital", ROMX
	map_attributes KantoHospital, KANTO_HOSPITAL, 0

SECTION "data/maps/attributes.asm@KantoPokecenter21F", ROMX
	map_attributes KantoPokecenter21F, KANTO_POKECENTER_2_1F, 0

SECTION "data/maps/attributes.asm@KantoPokecenter22F", ROMX
	map_attributes KantoPokecenter22F, KANTO_POKECENTER_2_2F, 0

SECTION "data/maps/attributes.asm@KantoRedsHouse", ROMX
	map_attributes KantoRedsHouse, KANTO_REDS_HOUSE, 0

SECTION "data/maps/attributes.asm@KantoGreensHouse1F", ROMX
	map_attributes KantoGreensHouse1F, KANTO_GREENS_HOUSE_1F, 0

SECTION "data/maps/attributes.asm@KantoGreensHouse2F", ROMX
	map_attributes KantoGreensHouse2F, KANTO_GREENS_HOUSE_2F, 0

SECTION "data/maps/attributes.asm@KantoEldersHouse", ROMX
	map_attributes KantoEldersHouse, KANTO_ELDERS_HOUSE, 0

SECTION "data/maps/attributes.asm@KantoOaksLab", ROMX
	map_attributes KantoOaksLab, KANTO_OAKS_LAB, 0

SECTION "data/maps/attributes.asm@KantoLeague21F", ROMX
	map_attributes KantoLeague21F, KANTO_LEAGUE_2_1F, 0

SECTION "data/maps/attributes.asm@KantoLeague22F", ROMX
	map_attributes KantoLeague22F, KANTO_LEAGUE_2_2F, 0

SECTION "data/maps/attributes.asm@KantoFishingGuru", ROMX
	map_attributes KantoFishingGuru, KANTO_FISHING_GURU, 0

SECTION "data/maps/attributes.asm@SouthHouse1", ROMX
	map_attributes SouthHouse1, SOUTH_HOUSE_1, 0

SECTION "data/maps/attributes.asm@SouthPokecenter1F", ROMX
	map_attributes SouthPokecenter1F, SOUTH_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@SouthPokecenter2F", ROMX
	map_attributes SouthPokecenter2F, SOUTH_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@SouthMart", ROMX
	map_attributes SouthMart, SOUTH_MART, 0

SECTION "data/maps/attributes.asm@SouthHouse2", ROMX
	map_attributes SouthHouse2, SOUTH_HOUSE_2, 0

SECTION "data/maps/attributes.asm@NorthHouse1", ROMX
	map_attributes NorthHouse1, NORTH_HOUSE_1, 0

SECTION "data/maps/attributes.asm@NorthMart", ROMX
	map_attributes NorthMart, NORTH_MART, 0

SECTION "data/maps/attributes.asm@NorthHouse2", ROMX
	map_attributes NorthHouse2, NORTH_HOUSE_2, 0

SECTION "data/maps/attributes.asm@NorthPokecenter1F", ROMX
	map_attributes NorthPokecenter1F, NORTH_POKECENTER_1F, 0

SECTION "data/maps/attributes.asm@NorthPokecenter2F", ROMX
	map_attributes NorthPokecenter2F, NORTH_POKECENTER_2F, 0

SECTION "data/maps/attributes.asm@PowerPlant1", ROMX
	map_attributes PowerPlant1, POWER_PLANT_1, 0

SECTION "data/maps/attributes.asm@PowerPlant2", ROMX
	map_attributes PowerPlant2, POWER_PLANT_2, 0

SECTION "data/maps/attributes.asm@PowerPlant3", ROMX
	map_attributes PowerPlant3, POWER_PLANT_3, 0

SECTION "data/maps/attributes.asm@PowerPlant4", ROMX
	map_attributes PowerPlant4, POWER_PLANT_4, 0

SECTION "data/maps/attributes.asm@RuinsOfAlphEntrance", ROMX
	map_attributes RuinsOfAlphEntrance, RUINS_OF_ALPH_ENTRANCE, 0

SECTION "data/maps/attributes.asm@RuinsOfAlphMain", ROMX
	map_attributes RuinsOfAlphMain, RUINS_OF_ALPH_MAIN, 0

SECTION "data/maps/attributes.asm@CaveMinecarts1", ROMX
	map_attributes CaveMinecarts1, CAVE_MINECARTS_1, 0

SECTION "data/maps/attributes.asm@CaveMinecarts2", ROMX
	map_attributes CaveMinecarts2, CAVE_MINECARTS_2, 0

SECTION "data/maps/attributes.asm@CaveMinecarts3", ROMX
	map_attributes CaveMinecarts3, CAVE_MINECARTS_3, 0

SECTION "data/maps/attributes.asm@CaveMinecarts4", ROMX
	map_attributes CaveMinecarts4, CAVE_MINECARTS_4, 0

SECTION "data/maps/attributes.asm@CaveMinecarts5", ROMX
	map_attributes CaveMinecarts5, CAVE_MINECARTS_5, 0

SECTION "data/maps/attributes.asm@CaveMinecarts6", ROMX
	map_attributes CaveMinecarts6, CAVE_MINECARTS_6, 0

SECTION "data/maps/attributes.asm@CaveMinecarts7", ROMX
	map_attributes CaveMinecarts7, CAVE_MINECARTS_7, 0

SECTION "data/maps/attributes.asm@Office1", ROMX
	map_attributes Office1, OFFICE_1, 0

SECTION "data/maps/attributes.asm@Office2", ROMX
	map_attributes Office2, OFFICE_2, 0

SECTION "data/maps/attributes.asm@Office3", ROMX
	map_attributes Office3, OFFICE_3, 0

SECTION "data/maps/attributes.asm@SlowpokeWellEntrance", ROMX
	map_attributes SlowpokeWellEntrance, SLOWPOKE_WELL_ENTRANCE, 0

SECTION "data/maps/attributes.asm@SlowpokeWellMain", ROMX
	map_attributes SlowpokeWellMain, SLOWPOKE_WELL_MAIN, 0

SECTION "data/maps/attributes.asm@ShizukanaOka", ROMX
	map_attributes ShizukanaOka, SHIZUKANA_OKA, 0

SECTION "data/maps/attributes.asm@RouteSilentEastGate", ROMX
	map_attributes RouteSilentEastGate, ROUTE_SILENT_EAST_GATE, 0

SECTION "data/maps/attributes.asm@PlayerHouse1F", ROMX
	map_attributes PlayerHouse1F, PLAYER_HOUSE_1F, 0

SECTION "data/maps/attributes.asm@PlayerHouse2F", ROMX
	map_attributes PlayerHouse2F, PLAYER_HOUSE_2F, 0

SECTION "data/maps/attributes.asm@SilentPokecenter", ROMX
	map_attributes SilentPokecenter, SILENT_POKECENTER, 0

SECTION "data/maps/attributes.asm@SilentHillHouse", ROMX
	map_attributes SilentHillHouse, SILENT_HILL_HOUSE, 0

SECTION "data/maps/attributes.asm@SilentHillLab", ROMX
	map_attributes SilentHillLab, SILENT_HILL_LAB, 0

SECTION "data/maps/attributes.asm@SilentHillLab2", ROMX
	map_attributes SilentHillLab2, SILENT_HILL_LAB_2, 0

SECTION "data/maps/attributes.asm@Unused13", ROMX
	map_attributes Unused13, UNUSED_13, 0

SECTION "data/maps/attributes.asm@SilentHill", ROMX
	map_attributes SilentHill, SILENT_HILL, NORTH | WEST | EAST
	connection north, PrinceRoute, PRINCE_ROUTE, 0, 0, 10
	connection west, Route1P1, ROUTE_1_P1, 0, 0, 9
	connection east, RouteSilentEast, ROUTE_SILENT_EAST, 0, 0, 9

SECTION "data/maps/attributes.asm@OldCity", ROMX
	map_attributes OldCity, OLD_CITY, SOUTH | WEST
	connection south, Route1P2, ROUTE_1_P2, 5, 0, 10
	connection west, Route2, ROUTE_2, 5, 0, 9

SECTION "data/maps/attributes.asm@West", ROMX
	map_attributes West, WEST, NORTH | EAST
	connection north, BaadonRoute1, BAADON_ROUTE_1, 5, 0, 10
	connection east, Route2, ROUTE_2, 5, 0, 9

SECTION "data/maps/attributes.asm@Haiteku", ROMX
	map_attributes Haiteku, HAITEKU, WEST
	connection west, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 0, 0, 9

SECTION "data/maps/attributes.asm@Fonto", ROMX
	map_attributes Fonto, FONTO, NORTH | WEST | EAST
	connection north, FontoRoute2, FONTO_ROUTE_2, 0, 0, 10
	connection west, FontoRoute1, FONTO_ROUTE_1, 0, 0, 9
	connection east, FontoRoute3, FONTO_ROUTE_3, 0, 0, 9

SECTION "data/maps/attributes.asm@Baadon", ROMX
	map_attributes Baadon, BAADON, NORTH | SOUTH | EAST
	connection north, FontoRoute4, FONTO_ROUTE_4, 0, 0, 10
	connection south, BaadonRoute1, BAADON_ROUTE_1, 0, 0, 10
	connection east, BaadonRoute2, BAADON_ROUTE_2, 0, 0, 9

SECTION "data/maps/attributes.asm@Newtype", ROMX
	map_attributes Newtype, NEWTYPE, NORTH | WEST | EAST
	connection north, SugarRoute, SUGAR_ROUTE, 5, 0, 10
	connection west, Route15, ROUTE_15, 0, 0, 9
	connection east, NewtypeRoute, NEWTYPE_ROUTE, 9, 0, 9

SECTION "data/maps/attributes.asm@Sugar", ROMX
	map_attributes Sugar, SUGAR, SOUTH
	connection south, SugarRoute, SUGAR_ROUTE, 0, 0, 10

SECTION "data/maps/attributes.asm@BullForest", ROMX
	map_attributes BullForest, BULL_FOREST, NORTH | SOUTH | WEST
	connection north, BullForestRoute3, BULL_FOREST_ROUTE_3, 5, 0, 10
	connection south, BullForestRoute2, BULL_FOREST_ROUTE_2, 5, 0, 10
	connection west, BullForestRoute1, BULL_FOREST_ROUTE_1, 9, 0, 9

SECTION "data/maps/attributes.asm@Stand", ROMX
	map_attributes Stand, STAND, NORTH | SOUTH
	connection north, BullForestRoute2, BULL_FOREST_ROUTE_2, 10, 0, 10
	connection south, StandRoute, STAND_ROUTE, 10, 0, 10

SECTION "data/maps/attributes.asm@Kanto", ROMX
	map_attributes Kanto, KANTO, WEST | EAST
	connection west, RouteSilentEast, ROUTE_SILENT_EAST, 9, 0, 9
	connection east, KantoEastRoute, KANTO_EAST_ROUTE, 9, 0, 9

SECTION "data/maps/attributes.asm@Prince", ROMX
	map_attributes Prince, PRINCE, NORTH | SOUTH
	connection north, MtFujiRoute, MT_FUJI_ROUTE, 0, 0, 10
	connection south, PrinceRoute, PRINCE_ROUTE, 0, 0, 10

SECTION "data/maps/attributes.asm@MtFuji", ROMX
	map_attributes MtFuji, MT_FUJI, SOUTH
	connection south, MtFujiRoute, MT_FUJI_ROUTE, 0, 0, 10

SECTION "data/maps/attributes.asm@South", ROMX
	map_attributes South, SOUTH, NORTH | SOUTH | EAST
	connection north, FontoRoute5, FONTO_ROUTE_5, 10, 0, 10
	connection south, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, 10, 0, 10
	connection east, FontoRoute1, FONTO_ROUTE_1, 0, 0, 9

SECTION "data/maps/attributes.asm@North", ROMX
	map_attributes North, NORTH, SOUTH
	connection south, BullForestRoute3, BULL_FOREST_ROUTE_3, 0, 0, 10

SECTION "data/maps/attributes.asm@Route1P1", ROMX
	map_attributes Route1P1, ROUTE_1_P1, WEST | EAST
	connection west, Route1P2, ROUTE_1_P2, -3, 6, 12
	connection east, SilentHill, SILENT_HILL, 0, 0, 9

SECTION "data/maps/attributes.asm@Route1P2", ROMX
	map_attributes Route1P2, ROUTE_1_P2, NORTH | EAST
	connection north, OldCity, OLD_CITY, -3, 2, 16
	connection east, Route1P1, ROUTE_1_P1, 9, 0, 9

SECTION "data/maps/attributes.asm@Route2", ROMX
	map_attributes Route2, ROUTE_2, WEST | EAST
	connection west, West, WEST, -3, 2, 15
	connection east, OldCity, OLD_CITY, -3, 2, 15

SECTION "data/maps/attributes.asm@HaitekuWestRoute", ROMX
	map_attributes HaitekuWestRoute, HAITEKU_WEST_ROUTE, WEST | EAST
	connection west, HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, -3, 15, 12
	connection east, Haiteku, HAITEKU, 0, 0, 12

SECTION "data/maps/attributes.asm@HaitekuWestRouteOcean", ROMX
	map_attributes HaitekuWestRouteOcean, HAITEKU_WEST_ROUTE_OCEAN, NORTH | EAST
	connection north, South, SOUTH, -3, 7, 13
	connection east, HaitekuWestRoute, HAITEKU_WEST_ROUTE, 18, 0, 9

SECTION "data/maps/attributes.asm@FontoRoute1", ROMX
	map_attributes FontoRoute1, FONTO_ROUTE_1, WEST | EAST
	connection west, South, SOUTH, 0, 0, 12
	connection east, Fonto, FONTO, 0, 0, 9

SECTION "data/maps/attributes.asm@FontoRoute6", ROMX
	map_attributes FontoRoute6, FONTO_ROUTE_6, WEST | EAST
	connection west, FontoRoute5, FONTO_ROUTE_5, 0, 0, 12
	connection east, FontoRoute2, FONTO_ROUTE_2, 0, 0, 12

SECTION "data/maps/attributes.asm@FontoRoute2", ROMX
	map_attributes FontoRoute2, FONTO_ROUTE_2, SOUTH | WEST
	connection south, Fonto, FONTO, 0, 0, 10
	connection west, FontoRoute6, FONTO_ROUTE_6, 0, 0, 9

SECTION "data/maps/attributes.asm@FontoRoute4", ROMX
	map_attributes FontoRoute4, FONTO_ROUTE_4, SOUTH | WEST
	connection south, Baadon, BAADON, 0, 0, 10
	connection west, FontoRoute3, FONTO_ROUTE_3, 0, 0, 9

SECTION "data/maps/attributes.asm@FontoRoute3", ROMX
	map_attributes FontoRoute3, FONTO_ROUTE_3, WEST | EAST
	connection west, Fonto, FONTO, 0, 0, 9
	connection east, FontoRoute4, FONTO_ROUTE_4, 0, 0, 12

SECTION "data/maps/attributes.asm@BaadonRoute1", ROMX
	map_attributes BaadonRoute1, BAADON_ROUTE_1, NORTH | SOUTH
	connection north, Baadon, BAADON, 0, 0, 10
	connection south, West, WEST, -3, 2, 16

SECTION "data/maps/attributes.asm@BaadonRoute2", ROMX
	map_attributes BaadonRoute2, BAADON_ROUTE_2, WEST | EAST
	connection west, Baadon, BAADON, 0, 0, 9
	connection east, BaadonRoute3, BAADON_ROUTE_3, 0, 0, 12

SECTION "data/maps/attributes.asm@BaadonRoute3", ROMX
	map_attributes BaadonRoute3, BAADON_ROUTE_3, SOUTH | WEST
	connection south, Route15, ROUTE_15, 0, 0, 13
	connection west, BaadonRoute2, BAADON_ROUTE_2, 0, 0, 9

SECTION "data/maps/attributes.asm@Route15", ROMX
	map_attributes Route15, ROUTE_15, NORTH | EAST
	connection north, BaadonRoute3, BAADON_ROUTE_3, 0, 0, 10
	connection east, Newtype, NEWTYPE, 0, 0, 12

SECTION "data/maps/attributes.asm@NewtypeRoute", ROMX
	map_attributes NewtypeRoute, NEWTYPE_ROUTE, WEST | EAST
	connection west, Newtype, NEWTYPE, -3, 6, 12
	connection east, Route18, ROUTE_18, -3, 33, 12

SECTION "data/maps/attributes.asm@Route18", ROMX
	map_attributes Route18, ROUTE_18, NORTH | WEST
	connection north, BullForestRoute1, BULL_FOREST_ROUTE_1, 0, 0, 13
	connection west, NewtypeRoute, NEWTYPE_ROUTE, 36, 0, 9

SECTION "data/maps/attributes.asm@BullForestRoute1", ROMX
	map_attributes BullForestRoute1, BULL_FOREST_ROUTE_1, SOUTH | EAST
	connection south, Route18, ROUTE_18, 0, 0, 10
	connection east, BullForest, BULL_FOREST, -3, 6, 12

SECTION "data/maps/attributes.asm@SugarRoute", ROMX
	map_attributes SugarRoute, SUGAR_ROUTE, NORTH | SOUTH
	connection north, Sugar, SUGAR, 0, 0, 10
	connection south, Newtype, NEWTYPE, -3, 2, 16

SECTION "data/maps/attributes.asm@BullForestRoute2", ROMX
	map_attributes BullForestRoute2, BULL_FOREST_ROUTE_2, NORTH | SOUTH
	connection north, BullForest, BULL_FOREST, -3, 2, 16
	connection south, Stand, STAND, -3, 7, 13

SECTION "data/maps/attributes.asm@StandRoute", ROMX
	map_attributes StandRoute, STAND_ROUTE, NORTH | SOUTH
	connection north, Stand, STAND, -3, 7, 13
	connection south, KantoEastRoute, KANTO_EAST_ROUTE, -3, 7, 13

SECTION "data/maps/attributes.asm@KantoEastRoute", ROMX
	map_attributes KantoEastRoute, KANTO_EAST_ROUTE, NORTH | WEST
	connection north, StandRoute, STAND_ROUTE, 10, 0, 10
	connection west, Kanto, KANTO, -3, 6, 15

SECTION "data/maps/attributes.asm@RouteSilentEast", ROMX
	map_attributes RouteSilentEast, ROUTE_SILENT_EAST, WEST | EAST
	connection west, SilentHill, SILENT_HILL, 0, 0, 9
	connection east, Kanto, KANTO, -3, 6, 15

SECTION "data/maps/attributes.asm@PrinceRoute", ROMX
	map_attributes PrinceRoute, PRINCE_ROUTE, NORTH | SOUTH
	connection north, Prince, PRINCE, 0, 0, 10
	connection south, SilentHill, SILENT_HILL, 0, 0, 10

SECTION "data/maps/attributes.asm@MtFujiRoute", ROMX
	map_attributes MtFujiRoute, MT_FUJI_ROUTE, NORTH | SOUTH
	connection north, MtFuji, MT_FUJI, 0, 0, 10
	connection south, Prince, PRINCE, 0, 0, 10

SECTION "data/maps/attributes.asm@FontoRoute5", ROMX
	map_attributes FontoRoute5, FONTO_ROUTE_5, SOUTH | EAST
	connection south, South, SOUTH, -3, 7, 13
	connection east, FontoRoute6, FONTO_ROUTE_6, 0, 0, 9

SECTION "data/maps/attributes.asm@BullForestRoute3", ROMX
	map_attributes BullForestRoute3, BULL_FOREST_ROUTE_3, NORTH | SOUTH
	connection north, North, NORTH, 0, 0, 10
	connection south, BullForest, BULL_FOREST, -3, 2, 16