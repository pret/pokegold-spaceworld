; base data struct members (see data/pokemon/base_stats/*.asm)
DEF BASE_DEX_NO      EQUS "(wBaseDexNo - wCurBaseData)"
DEF BASE_STATS       EQUS "(wBaseStats - wCurBaseData)"
DEF BASE_HP          EQUS "(wBaseHP - wCurBaseData)"
DEF BASE_ATK         EQUS "(wBaseAttack - wCurBaseData)"
DEF BASE_SPD         EQUS "(wBaseSpeed - wCurBaseData)"
DEF BASE_SAT         EQUS "(wBaseSpecialAttack - wCurBaseData)"
DEF BASE_SDF         EQUS "(wBaseSpecialDefense - wCurBaseData)"
DEF BASE_TYPES       EQUS "(wBaseType - wCurBaseData)"
DEF BASE_TYPE_1      EQUS "(wBaseType1 - wCurBaseData)"
DEF BASE_TYPE_2      EQUS "(wBaseType2 - wCurBaseData)"
DEF BASE_CATCH_RATE  EQUS "(wBaseCatchRate - wCurBaseData)"
DEF BASE_EXP         EQUS "(wBaseExp - wCurBaseData)"
DEF BASE_ITEMS       EQUS "(wBaseItems - wCurBaseData)"
DEF BASE_ITEM_1      EQUS "(wBaseItem1 - wCurBaseData)"
DEF BASE_ITEM_2      EQUS "(wBaseItem2 - wCurBaseData)"
DEF BASE_GENDER      EQUS "(wBaseGender - wCurBaseData)"
DEF BASE_UNKNOWN_1   EQUS "(wBaseUnknown1 - wCurBaseData)"
DEF BASE_EGG_STEPS   EQUS "(wBaseEggSteps - wCurBaseData)"
DEF BASE_UNKNOWN_2   EQUS "(wBaseUnknown2 - wCurBaseData)"
DEF BASE_PIC_SIZE    EQUS "(wBasePicSize - wCurBaseData)"
DEF BASE_FRONT_PTR   EQUS "(wBaseFrontPtr - wCurBaseData)"
DEF BASE_Back_PTR    EQUS "(wBaseBackPtr - wCurBaseData)"
DEF BASE_GROWTH_RATE EQUS "(wBaseGrowthRate - wCurBaseData)"
DEF BASE_TMHM        EQUS "(wBaseTMHM - wCurBaseData)"
DEF BASE_DATA_SIZE   EQUS "(wCurBaseDataEnd - wCurBaseData)"

; gender ratio constants
DEF GENDER_MALE    EQU 0 percent
DEF GENDER_50_50   EQU 50 percent
DEF GENDER_FEMALE  EQU 100 percent - 1
DEF GENDER_UNKNOWN EQU -1

; growth rates
	const_def
	const GROWTH_MEDIUM_FAST   ; 00
	const GROWTH_SLIGHTLY_FAST ; 01
	const GROWTH_SLIGHTLY_SLOW ; 02
	const GROWTH_MEDIUM_SLOW   ; 03
	const GROWTH_FAST          ; 04
	const GROWTH_SLOW          ; 05


; pokedex entries (see data/pokemon/dex_entries.asm)
DEF NUM_DEX_ENTRY_BANKS EQU 4


; party_struct members (see macros/wram.asm)
DEF MON_SPECIES            EQUS "(wPartyMon1Species - wPartyMon1)"
DEF MON_ITEM               EQUS "(wPartyMon1Item - wPartyMon1)"
DEF MON_MOVES              EQUS "(wPartyMon1Moves - wPartyMon1)"
DEF MON_ID                 EQUS "(wPartyMon1ID - wPartyMon1)"
DEF MON_EXP                EQUS "(wPartyMon1Exp - wPartyMon1)"
DEF MON_STAT_EXP           EQUS "(wPartyMon1StatExp - wPartyMon1)"
DEF MON_HP_EXP             EQUS "(wPartyMon1HPExp - wPartyMon1)"
DEF MON_ATK_EXP            EQUS "(wPartyMon1AtkExp - wPartyMon1)"
DEF MON_DEF_EXP            EQUS "(wPartyMon1DefExp - wPartyMon1)"
DEF MON_SPD_EXP            EQUS "(wPartyMon1SpdExp - wPartyMon1)"
DEF MON_SPC_EXP            EQUS "(wPartyMon1SpcExp - wPartyMon1)"
DEF MON_DVS                EQUS "(wPartyMon1DVs - wPartyMon1)"
DEF MON_PP                 EQUS "(wPartyMon1PP - wPartyMon1)"
DEF MON_HAPPINESS          EQUS "(wPartyMon1Happiness - wPartyMon1)"
DEF MON_PKRUS              EQUS "(wPartyMon1PokerusStatus - wPartyMon1)"
DEF MON_CAUGHTDATA         EQUS "(wPartyMon1CaughtData - wPartyMon1)"
DEF MON_CAUGHTLEVEL        EQUS "(wPartyMon1CaughtLevel - wPartyMon1)"
DEF MON_CAUGHTTIME         EQUS "(wPartyMon1CaughtTime - wPartyMon1)"
DEF MON_CAUGHTGENDER       EQUS "(wPartyMon1CaughtGender - wPartyMon1)"
DEF MON_CAUGHTLOCATION     EQUS "(wPartyMon1CaughtLocation - wPartyMon1)"
DEF MON_LEVEL              EQUS "(wPartyMon1Level - wPartyMon1)"
DEF MON_STATUS             EQUS "(wPartyMon1Status - wPartyMon1)"
DEF MON_HP                 EQUS "(wPartyMon1HP - wPartyMon1)"
DEF MON_MAXHP              EQUS "(wPartyMon1MaxHP - wPartyMon1)"
DEF MON_ATK                EQUS "(wPartyMon1Attack - wPartyMon1)"
DEF MON_DEF                EQUS "(wPartyMon1Defense - wPartyMon1)"
DEF MON_SPD                EQUS "(wPartyMon1Speed - wPartyMon1)"
DEF MON_SAT                EQUS "(wPartyMon1SpclAtk - wPartyMon1)"
DEF MON_SDF                EQUS "(wPartyMon1SpclDef - wPartyMon1)"
DEF BOXMON_STRUCT_LENGTH   EQUS "(wPartyMon1End - wPartyMon1)"
DEF PARTYMON_STRUCT_LENGTH EQUS "(wPartyMon1StatsEnd - wPartyMon1)"

DEF REDMON_STRUCT_LENGTH EQU 44


; caught data

DEF CAUGHT_TIME_MASK  EQU %11000000
DEF CAUGHT_LEVEL_MASK EQU %00111111

DEF CAUGHT_GENDER_MASK   EQU %10000000
DEF CAUGHT_LOCATION_MASK EQU %01111111

DEF CAUGHT_BY_UNKNOWN EQU 0
DEF CAUGHT_BY_GIRL    EQU 1
DEF CAUGHT_BY_BOY     EQU 2

DEF CAUGHT_EGG_LEVEL EQU 1


; maximum number of party pokemon
DEF PARTY_LENGTH EQU 6

; boxes
; The Japanese version fits more Pokémon into the boxes, but has less boxes total
DEF MONS_PER_BOX EQU 30
DEF NUM_BOXES EQU 10

; hall of fame
DEF HOF_MON_LENGTH EQUS "(wHallOfFamePokemonListMon1End - wHallOfFamePokemonListMon1)"
DEF HOF_LENGTH EQUS "(wHallOfFamePokemonListEnd - wHallOfFamePokemonList + 1)"
DEF NUM_HOF_TEAMS EQU 30


; evolution types (used in data/pokemon/evos_attacks.asm)
	const_def 1
	const EVOLVE_LEVEL
	const EVOLVE_STONE
	const EVOLVE_ITEM
	const EVOLVE_TRADE


; wild data

DEF NUM_GRASSMON EQU 6 ; data/wild/*_grass.asm table size
DEF NUM_WATERMON EQU 3 ; data/wild/*_water.asm table size

DEF GRASS_WILDDATA_LENGTH EQU (NUM_GRASSMON * 2 + 1) * 3 + 2
DEF WATER_WILDDATA_LENGTH EQU (NUM_WATERMON * 2 + 1) * 1 + 2

DEF BASE_HAPPINESS        EQU 70

; PP
DEF PP_UP_MASK EQU %11000000
DEF PP_UP_ONE  EQU %01000000
DEF PP_MASK    EQU %00111111

; HP
DEF ENEMY_HP_BAR EQU 0
DEF BATTLE_HP_BAR EQU 1
DEF POKEMON_MENU_HP_BAR EQU 2
