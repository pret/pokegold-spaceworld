; base data struct members (see data/pokemon/base_stats/*.asm)
BASE_DEX_NO      EQUS "(wBaseDexNo - wCurBaseData)"
BASE_STATS       EQUS "(wBaseStats - wCurBaseData)"
BASE_HP          EQUS "(wBaseHP - wCurBaseData)"
BASE_ATK         EQUS "(wBaseAttack - wCurBaseData)"
BASE_SPD         EQUS "(wBaseSpeed - wCurBaseData)"
BASE_SAT         EQUS "(wBaseSpecialAttack - wCurBaseData)"
BASE_SDF         EQUS "(wBaseSpecialDefense - wCurBaseData)"
BASE_TYPES       EQUS "(wBaseType - wCurBaseData)"
BASE_TYPE_1      EQUS "(wBaseType1 - wCurBaseData)"
BASE_TYPE_2      EQUS "(wBaseType2 - wCurBaseData)"
BASE_CATCH_RATE  EQUS "(wBaseCatchRate - wCurBaseData)"
BASE_EXP         EQUS "(wBaseExp - wCurBaseData)"
BASE_ITEMS       EQUS "(wBaseItems - wCurBaseData)"
BASE_ITEM_1      EQUS "(wBaseItem1 - wCurBaseData)"
BASE_ITEM_2      EQUS "(wBaseItem2 - wCurBaseData)"
BASE_GENDER      EQUS "(wBaseGender - wCurBaseData)"
BASE_UNKNOWN_1   EQUS "(wBaseUnknown1 - wCurBaseData)"
BASE_EGG_STEPS   EQUS "(wBaseEggSteps - wCurBaseData)"
BASE_UNKNOWN_2   EQUS "(wBaseUnknown2 - wCurBaseData)"
BASE_PIC_SIZE    EQUS "(wBasePicSize - wCurBaseData)"
BASE_FRONT_PTR   EQUS "(wBaseFrontPtr - wCurBaseData)"
BASE_Back_PTR    EQUS "(wBaseBackPtr - wCurBaseData)"
BASE_GROWTH_RATE EQUS "(wBaseGrowthRate - wCurBaseData)"
BASE_TMHM        EQUS "(wBaseTMHM - wCurBaseData)"
BASE_DATA_SIZE   EQUS "(wCurBaseDataEnd - wCurBaseData)"

; gender ratio constants
GENDER_MALE    EQU 0 percent
GENDER_50_50   EQU 50 percent
GENDER_FEMALE  EQU 100 percent - 1
GENDER_UNKNOWN EQU -1

; growth rates
	const_def
	const GROWTH_MEDIUM_FAST   ; 00
	const GROWTH_SLIGHTLY_FAST ; 01
	const GROWTH_SLIGHTLY_SLOW ; 02
	const GROWTH_MEDIUM_SLOW   ; 03
	const GROWTH_FAST          ; 04
	const GROWTH_SLOW          ; 05


; pokedex entries (see data/pokemon/dex_entries.asm)
NUM_DEX_ENTRY_BANKS EQU 4


; party_struct members (see macros/wram.asm)
MON_SPECIES            EQUS "(wPartyMon1Species - wPartyMon1)"
MON_ITEM               EQUS "(wPartyMon1Item - wPartyMon1)"
MON_MOVES              EQUS "(wPartyMon1Moves - wPartyMon1)"
MON_ID                 EQUS "(wPartyMon1ID - wPartyMon1)"
MON_EXP                EQUS "(wPartyMon1Exp - wPartyMon1)"
MON_STAT_EXP           EQUS "(wPartyMon1StatExp - wPartyMon1)"
MON_HP_EXP             EQUS "(wPartyMon1HPExp - wPartyMon1)"
MON_ATK_EXP            EQUS "(wPartyMon1AtkExp - wPartyMon1)"
MON_DEF_EXP            EQUS "(wPartyMon1DefExp - wPartyMon1)"
MON_SPD_EXP            EQUS "(wPartyMon1SpdExp - wPartyMon1)"
MON_SPC_EXP            EQUS "(wPartyMon1SpcExp - wPartyMon1)"
MON_DVS                EQUS "(wPartyMon1DVs - wPartyMon1)"
MON_PP                 EQUS "(wPartyMon1PP - wPartyMon1)"
MON_HAPPINESS          EQUS "(wPartyMon1Happiness - wPartyMon1)"
MON_PKRUS              EQUS "(wPartyMon1PokerusStatus - wPartyMon1)"
MON_CAUGHTDATA         EQUS "(wPartyMon1CaughtData - wPartyMon1)"
MON_CAUGHTLEVEL        EQUS "(wPartyMon1CaughtLevel - wPartyMon1)"
MON_CAUGHTTIME         EQUS "(wPartyMon1CaughtTime - wPartyMon1)"
MON_CAUGHTGENDER       EQUS "(wPartyMon1CaughtGender - wPartyMon1)"
MON_CAUGHTLOCATION     EQUS "(wPartyMon1CaughtLocation - wPartyMon1)"
MON_LEVEL              EQUS "(wPartyMon1Level - wPartyMon1)"
MON_STATUS             EQUS "(wPartyMon1Status - wPartyMon1)"
MON_HP                 EQUS "(wPartyMon1HP - wPartyMon1)"
MON_MAXHP              EQUS "(wPartyMon1MaxHP - wPartyMon1)"
MON_ATK                EQUS "(wPartyMon1Attack - wPartyMon1)"
MON_DEF                EQUS "(wPartyMon1Defense - wPartyMon1)"
MON_SPD                EQUS "(wPartyMon1Speed - wPartyMon1)"
MON_SAT                EQUS "(wPartyMon1SpclAtk - wPartyMon1)"
MON_SDF                EQUS "(wPartyMon1SpclDef - wPartyMon1)"
BOXMON_STRUCT_LENGTH   EQUS "(wPartyMon1End - wPartyMon1)"
PARTYMON_STRUCT_LENGTH EQUS "(wPartyMon1StatsEnd - wPartyMon1)"

REDMON_STRUCT_LENGTH EQU 44


; caught data

CAUGHT_TIME_MASK  EQU %11000000
CAUGHT_LEVEL_MASK EQU %00111111

CAUGHT_GENDER_MASK   EQU %10000000
CAUGHT_LOCATION_MASK EQU %01111111

CAUGHT_BY_UNKNOWN EQU 0
CAUGHT_BY_GIRL    EQU 1
CAUGHT_BY_BOY     EQU 2

CAUGHT_EGG_LEVEL EQU 1


; maximum number of party pokemon
PARTY_LENGTH EQU 6

; boxes
MONS_PER_BOX EQU 20
NUM_BOXES    EQU 14

; hall of fame
HOF_MON_LENGTH EQUS "(wHallOfFamePokemonListMon1End - wHallOfFamePokemonListMon1)"
HOF_LENGTH EQUS "(wHallOfFamePokemonListEnd - wHallOfFamePokemonList + 1)"
NUM_HOF_TEAMS EQU 30


; evolution types (used in data/pokemon/evos_attacks.asm)
	const_def 1
	const EVOLVE_LEVEL
	const EVOLVE_STONE
	const EVOLVE_ITEM
	const EVOLVE_TRADE


; wild data

NUM_GRASSMON EQU 7 ; data/wild/*_grass.asm table size
NUM_WATERMON EQU 3 ; data/wild/*_water.asm table size

GRASS_WILDDATA_LENGTH EQU (NUM_GRASSMON * 2 + 1) * 3 + 2
WATER_WILDDATA_LENGTH EQU (NUM_WATERMON * 2 + 1) * 1 + 2


; PP
PP_UP_MASK EQU %11000000
PP_UP_ONE  EQU %01000000
PP_MASK    EQU %00111111

; HP
ENEMY_HP_BAR EQU 0
BATTLE_HP_BAR EQU 1
POKEMON_MENU_HP_BAR EQU 2