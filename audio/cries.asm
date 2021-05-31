INCLUDE "constants.asm"

SECTION "audio/cries.asm@Cry Header Pointers", ROMX
CryHeaderPointers::
	dba Cry_00
	dba Cry_01
	dba Cry_02
	dba Cry_03
	dba Cry_04
	dba Cry_05
	dba Cry_06
	dba Cry_07
	dba Cry_08
	dba Cry_09
	dba Cry_0a
	dba Cry_0b
	dba Cry_0c
	dba Cry_0d
	dba Cry_0e
	dba Cry_0f
	dba Cry_10
	dba Cry_11
	dba Cry_12
	dba Cry_13
	dba Cry_14
	dba Cry_15
	dba Cry_16
	dba Cry_17
	dba Cry_18
	dba Cry_19
	dba Cry_1a
	dba Cry_1b
	dba Cry_1c
	dba Cry_1d
	dba Cry_1e
	dba Cry_1f
	dba Cry_20
	dba Cry_21
	dba Cry_22
	dba Cry_23
	dba Cry_24
	dba Cry_25

SECTION "audio/cries.asm@Cries", ROMX
mon_cry: MACRO
; index, pitch, length
	dw \1, \2, \3
ENDM
Cries::
	mon_cry CRY_11,    0,  256 ; MON_RHYDON
	mon_cry CRY_03,    0,  256 ; MON_KANGASKHAN
	mon_cry CRY_00,    0,  256 ; MON_NIDORAN_M
	mon_cry CRY_19,  204,  129 ; MON_CLEFAIRY
	mon_cry CRY_10,    0,  256 ; MON_SPEAROW
	mon_cry CRY_06,  237,  256 ; MON_VOLTORB
	mon_cry CRY_09,    0,  256 ; MON_NIDOKING
	mon_cry CRY_1F,    0,  256 ; MON_SLOWBRO
	mon_cry CRY_0F,   32,  256 ; MON_IVYSAUR
	mon_cry CRY_0D,    0,  256 ; MON_EXEGGUTOR
	mon_cry CRY_0C,    0,  256 ; MON_LICKITUNG
	mon_cry CRY_0B,    0,  256 ; MON_EXEGGCUTE
	mon_cry CRY_05,    0,  256 ; MON_GRIMER
	mon_cry CRY_07,    0,  383 ; MON_GENGAR
	mon_cry CRY_01,    0,  256 ; MON_NIDORAN_F
	mon_cry CRY_0A,    0,  256 ; MON_NIDOQUEEN
	mon_cry CRY_19,    0,  256 ; MON_CUBONE
	mon_cry CRY_04,    0,  256 ; MON_RHYHORN
	mon_cry CRY_1B,    0,  256 ; MON_LAPRAS
	mon_cry CRY_15,    0,  256 ; MON_ARCANINE
	mon_cry CRY_1E,  238,  383 ; MON_MEW
	mon_cry CRY_17,    0,  256 ; MON_GYARADOS
	mon_cry CRY_18,    0,  256 ; MON_SHELLDER
	mon_cry CRY_1A,    0,  256 ; MON_TENTACOOL
	mon_cry CRY_1C,    0,  256 ; MON_GASTLY
	mon_cry CRY_16,    0,  256 ; MON_SCYTHER
	mon_cry CRY_1E,    2,  160 ; MON_STARYU
	mon_cry CRY_13,    0,  256 ; MON_BLASTOISE
	mon_cry CRY_14,    0,  256 ; MON_PINSIR
	mon_cry CRY_12,    0,  256 ; MON_TANGELA
	mon_cry CRY_00,    0,    0 ; MON_KAPOERER
	mon_cry CRY_00,    0,    0 ; MON_PUDIE
	mon_cry CRY_1F,   32,  192 ; MON_GROWLITHE
	mon_cry CRY_17,  255,  320 ; MON_ONIX
	mon_cry CRY_18,   64,  288 ; MON_FEAROW
	mon_cry CRY_0E,  223,  132 ; MON_PIDGEY
	mon_cry CRY_02,    0,  256 ; MON_SLOWPOKE
	mon_cry CRY_1C,  168,  320 ; MON_KADABRA
	mon_cry CRY_24,    0,  256 ; MON_GRAVELER
	mon_cry CRY_14,   10,  320 ; MON_CHANSEY
	mon_cry CRY_1F,   72,  224 ; MON_MACHOKE
	mon_cry CRY_20,    8,  192 ; MON_MRMIME
	mon_cry CRY_12,  128,  320 ; MON_HITMONLEE
	mon_cry CRY_0C,  238,  320 ; MON_HITMONCHAN
	mon_cry CRY_17,  224,  144 ; MON_ARBOK
	mon_cry CRY_1E,   66,  383 ; MON_PARASECT
	mon_cry CRY_21,   32,  224 ; MON_PSYDUCK
	mon_cry CRY_0D,  136,  160 ; MON_DROWZEE
	mon_cry CRY_12,  224,  192 ; MON_GOLEM
	mon_cry CRY_00,    0,    0 ; MON_HANEKO
	mon_cry CRY_04,  255,  176 ; MON_MAGMAR
	mon_cry CRY_00,    0,    0 ; MON_TAIL
	mon_cry CRY_06,  143,  383 ; MON_ELECTABUZZ
	mon_cry CRY_1C,   32,  320 ; MON_MAGNETON
	mon_cry CRY_12,  230,  349 ; MON_KOFFING
	mon_cry CRY_00,    0,    0 ; MON_POPONEKO
	mon_cry CRY_0A,  221,  224 ; MON_MANKEY
	mon_cry CRY_0C,  136,  320 ; MON_SEEL
	mon_cry CRY_0B,  170,  129 ; MON_DIGLETT
	mon_cry CRY_1D,   17,  192 ; MON_TAUROS
	mon_cry CRY_00,    0,    0 ; MON_WATANEKO
	mon_cry CRY_00,    0,    0 ; MON_BARIRINA
	mon_cry CRY_00,    0,    0 ; MON_LIP
	mon_cry CRY_10,  221,  129 ; MON_FARFETCHD
	mon_cry CRY_1A,   68,  192 ; MON_VENONAT
	mon_cry CRY_0F,   60,  320 ; MON_DRAGONITE
	mon_cry CRY_00,  128,   16 ; MON_ELEBABY
	mon_cry CRY_00,    0,    0 ; MON_BOOBY
	mon_cry CRY_1D,  224,    0 ; MON_KIREIHANA
	mon_cry CRY_0B,  187,  129 ; MON_DODUO
	mon_cry CRY_0E,  255,  383 ; MON_POLIWAG
	mon_cry CRY_0D,  255,  383 ; MON_JYNX
	mon_cry CRY_09,  248,  192 ; MON_MOLTRES
	mon_cry CRY_09,  128,  192 ; MON_ARTICUNO
	mon_cry CRY_18,  255,  256 ; MON_ZAPDOS
	mon_cry CRY_0E,  255,  383 ; MON_DITTO
	mon_cry CRY_19,  119,  144 ; MON_MEOWTH
	mon_cry CRY_20,   32,  352 ; MON_KRABBY
	mon_cry CRY_22,  255,   64 ; MON_TSUBOMITTO
	mon_cry CRY_00,    0,    0 ; MON_MILTANK
	mon_cry CRY_0E,  224,   96 ; MON_BOMBSEEKER
	mon_cry CRY_24,   79,  144 ; MON_VULPIX
	mon_cry CRY_24,  136,  224 ; MON_NINETALES
	mon_cry CRY_0F,  238,  129 ; MON_PIKACHU
	mon_cry CRY_09,  238,  136 ; MON_RAICHU
	mon_cry CRY_00,    0,    0 ; MON_GIFT
	mon_cry CRY_00,    0,    0 ; MON_KOTORA
	mon_cry CRY_0F,   96,  192 ; MON_DRATINI
	mon_cry CRY_0F,   64,  256 ; MON_DRAGONAIR
	mon_cry CRY_16,  187,  192 ; MON_KABUTO
	mon_cry CRY_18,  238,  129 ; MON_KABUTOPS
	mon_cry CRY_19,  153,  144 ; MON_HORSEA
	mon_cry CRY_19,   60,  129 ; MON_SEADRA
	mon_cry CRY_0F,   64,  192 ; MON_RAITORA
	mon_cry CRY_0F,   32,  192 ; MON_MADAME
	mon_cry CRY_00,   32,  192 ; MON_SANDSHREW
	mon_cry CRY_00,  255,  383 ; MON_SANDSLASH
	mon_cry CRY_1F,  240,  129 ; MON_OMANYTE
	mon_cry CRY_1F,  255,  192 ; MON_OMASTAR
	mon_cry CRY_0E,  255,  181 ; MON_JIGGLYPUFF
	mon_cry CRY_0E,  104,  224 ; MON_WIGGLYTUFF
	mon_cry CRY_1A,  136,  224 ; MON_EEVEE
	mon_cry CRY_1A,   16,  160 ; MON_FLAREON
	mon_cry CRY_1A,   61,  256 ; MON_JOLTEON
	mon_cry CRY_1A,  170,  383 ; MON_VAPOREON
	mon_cry CRY_1F,  238,  129 ; MON_MACHOP
	mon_cry CRY_1D,  224,  256 ; MON_ZUBAT
	mon_cry CRY_17,   18,  192 ; MON_EKANS
	mon_cry CRY_1E,   32,  352 ; MON_PARAS
	mon_cry CRY_0E,  119,  224 ; MON_POLIWHIRL
	mon_cry CRY_0E,    0,  383 ; MON_POLIWRATH
	mon_cry CRY_15,  238,  129 ; MON_WEEDLE
	mon_cry CRY_13,  255,  129 ; MON_KAKUNA
	mon_cry CRY_13,   96,  256 ; MON_BEEDRILL
	mon_cry CRY_00,    0,    0 ; MON_NOROWARA
	mon_cry CRY_0B,  153,  160 ; MON_DODRIO
	mon_cry CRY_0A,  175,  192 ; MON_PRIMEAPE
	mon_cry CRY_0B,   42,  144 ; MON_DUGTRIO
	mon_cry CRY_1A,   41,  256 ; MON_VENOMOTH
	mon_cry CRY_0C,   35,  383 ; MON_DEWGONG
	mon_cry CRY_00,    0,    0 ; MON_KYONPAN
	mon_cry CRY_00,    0,    0 ; MON_YAMIKARASU
	mon_cry CRY_16,  128,  160 ; MON_CATERPIE
	mon_cry CRY_1C,  204,  129 ; MON_METAPOD
	mon_cry CRY_16,  119,  192 ; MON_BUTTERFREE
	mon_cry CRY_1F,    8,  320 ; MON_MACHAMP
	mon_cry CRY_11,   32,   16 ; MON_HAPPI
	mon_cry CRY_21,  255,  192 ; MON_GOLDUCK
	mon_cry CRY_0D,  238,  192 ; MON_HYPNO
	mon_cry CRY_1D,  250,  256 ; MON_GOLBAT
	mon_cry CRY_1E,  153,  383 ; MON_MEWTWO
	mon_cry CRY_05,   85,  129 ; MON_SNORLAX
	mon_cry CRY_17,  128,  128 ; MON_MAGIKARP
	mon_cry CRY_00,    0,    0 ; MON_SCISSORS
	mon_cry CRY_00,    0,    0 ; MON_PURAKKUSU
	mon_cry CRY_07,  239,  383 ; MON_MUK
	mon_cry CRY_0F,   64,    0 ; MON_DEVIL
	mon_cry CRY_20,  238,  352 ; MON_KINGLER
	mon_cry CRY_18,  111,  352 ; MON_CLOYSTER
	mon_cry CRY_00,    0,    0 ; MON_HELGAA
	mon_cry CRY_06,  168,  272 ; MON_ELECTRODE
	mon_cry CRY_19,  170,  160 ; MON_CLEFABLE
	mon_cry CRY_12,  255,  383 ; MON_WEEZING
	mon_cry CRY_19,  153,  383 ; MON_PERSIAN
	mon_cry CRY_08,   79,  224 ; MON_MAROWAK
	mon_cry CRY_00,    0,    0 ; MON_WOLFMAN
	mon_cry CRY_1C,   48,  192 ; MON_HAUNTER
	mon_cry CRY_1C,  192,  129 ; MON_ABRA
	mon_cry CRY_1C,  152,  383 ; MON_ALAKAZAM
	mon_cry CRY_14,   40,  320 ; MON_PIDGEOTTO
	mon_cry CRY_14,   17,  383 ; MON_PIDGEOT
	mon_cry CRY_1E,    0,  256 ; MON_STARMIE
	mon_cry CRY_0F,  128,  129 ; MON_BULBASAUR
	mon_cry CRY_0F,    0,  320 ; MON_VENUSAUR
	mon_cry CRY_1A,  238,  383 ; MON_TENTACRUEL
	mon_cry CRY_00,    0,    0 ; MON_WARWOLF
	mon_cry CRY_16,  128,  192 ; MON_GOLDEEN
	mon_cry CRY_16,   16,  383 ; MON_SEAKING
	mon_cry CRY_00,    0,    0 ; MON_PORYGON2
	mon_cry CRY_00,    0,    0 ; MON_NAMEIL
	mon_cry CRY_00,    0,    0 ; MON_HAGANEIL
	mon_cry CRY_00,    0,    0 ; MON_KINGDRA
	mon_cry CRY_25,    0,  256 ; MON_PONYTA
	mon_cry CRY_25,   32,  320 ; MON_RAPIDASH
	mon_cry CRY_22,    0,  256 ; MON_RATTATA
	mon_cry CRY_22,   32,  383 ; MON_RATICATE
	mon_cry CRY_00,   44,  320 ; MON_NIDORINO
	mon_cry CRY_01,   44,  352 ; MON_NIDORINA
	mon_cry CRY_24,  240,  144 ; MON_GEODUDE
	mon_cry CRY_25,  170,  383 ; MON_PORYGON
	mon_cry CRY_23,   32,  368 ; MON_AERODACTYL
	mon_cry CRY_00,    0,    0 ; MON_RAI
	mon_cry CRY_1C,  128,  224 ; MON_MAGNEMITE
	mon_cry CRY_00,    0,    0 ; MON_EN
	mon_cry CRY_00,    0,    0 ; MON_SUI
	mon_cry CRY_04,   96,  192 ; MON_CHARMANDER
	mon_cry CRY_1D,   96,  192 ; MON_SQUIRTLE
	mon_cry CRY_04,   32,  192 ; MON_CHARMELEON
	mon_cry CRY_1D,   32,  192 ; MON_WARTORTLE
	mon_cry CRY_04,    0,  256 ; MON_CHARIZARD
	mon_cry CRY_1D,    0,    0 ; MON_NYULA
	mon_cry CRY_00,    0,    0 ; MON_HOUOU
	mon_cry CRY_00,    0,    0 ; MON_TOGEPY
	mon_cry CRY_00,    0,    0 ; MON_BULU
	mon_cry CRY_08,  221,  129 ; MON_ODDISH
	mon_cry CRY_08,  170,  192 ; MON_GLOOM
	mon_cry CRY_23,   34,  383 ; MON_VILEPLUME
	mon_cry CRY_21,   85,  129 ; MON_BELLSPROUT
	mon_cry CRY_25,   68,  160 ; MON_WEEPINBELL
	mon_cry CRY_25,  102,  332 ; MON_VICTREEBEL
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256
	mon_cry CRY_00,    0,  256

SECTION "audio/cries.asm@CryHeaders", ROMX
Cry_00:
	channel_count 3
	channel 5, Cry_00_Ch5
	channel 6, Cry_00_Ch6
	channel 8, Cry_00_Ch8

Cry_01:
	channel_count 3
	channel 5, Cry_01_Ch5
	channel 6, Cry_01_Ch6
	channel 8, Cry_01_Ch8

Cry_02:
	channel_count 3
	channel 5, Cry_02_Ch5
	channel 6, Cry_02_Ch6
	channel 8, Cry_02_Ch8

Cry_03:
	channel_count 3
	channel 5, Cry_03_Ch5
	channel 6, Cry_03_Ch6
	channel 8, Cry_03_Ch8

Cry_04:
	channel_count 3
	channel 5, Cry_04_Ch5
	channel 6, Cry_04_Ch6
	channel 8, Cry_04_Ch8

Cry_05:
	channel_count 3
	channel 5, Cry_05_Ch5
	channel 6, Cry_05_Ch6
	channel 8, Cry_05_Ch8

Cry_06:
	channel_count 3
	channel 5, Cry_06_Ch5
	channel 6, Cry_06_Ch6
	channel 8, Cry_06_Ch8

Cry_07:
	channel_count 3
	channel 5, Cry_07_Ch5
	channel 6, Cry_07_Ch6
	channel 8, Cry_07_Ch8

Cry_08:
	channel_count 3
	channel 5, Cry_08_Ch5
	channel 6, Cry_08_Ch6
	channel 8, Cry_08_Ch8

Cry_09:
	channel_count 3
	channel 5, Cry_09_Ch5
	channel 6, Cry_09_Ch6
	channel 8, Cry_09_Ch8

Cry_0a:
	channel_count 3
	channel 5, Cry_0a_Ch5
	channel 6, Cry_0a_Ch6
	channel 8, Cry_0a_Ch8

Cry_0b:
	channel_count 3
	channel 5, Cry_0b_Ch5
	channel 6, Cry_0b_Ch6
	channel 8, Cry_0b_Ch8

Cry_0c:
	channel_count 3
	channel 5, Cry_0c_Ch5
	channel 6, Cry_0c_Ch6
	channel 8, Cry_0c_Ch8

Cry_0d:
	channel_count 3
	channel 5, Cry_0d_Ch5
	channel 6, Cry_0d_Ch6
	channel 8, Cry_0d_Ch8

Cry_0e:
	channel_count 3
	channel 5, Cry_0e_Ch5
	channel 6, Cry_0e_Ch6
	channel 8, Cry_0e_Ch8

Cry_0f:
	channel_count 3
	channel 5, Cry_0f_Ch5
	channel 6, Cry_0f_Ch6
	channel 8, Cry_0f_Ch8

Cry_10:
	channel_count 3
	channel 5, Cry_10_Ch5
	channel 6, Cry_10_Ch6
	channel 8, Cry_10_Ch8

Cry_11:
	channel_count 3
	channel 5, Cry_11_Ch5
	channel 6, Cry_11_Ch6
	channel 8, Cry_11_Ch8

Cry_12:
	channel_count 3
	channel 5, Cry_12_Ch5
	channel 6, Cry_12_Ch6
	channel 8, Cry_12_Ch8

Cry_13:
	channel_count 3
	channel 5, Cry_13_Ch5
	channel 6, Cry_13_Ch6
	channel 8, Cry_13_Ch8

Cry_14:
	channel_count 3
	channel 5, Cry_14_Ch5
	channel 6, Cry_14_Ch6
	channel 8, Cry_14_Ch8

Cry_15:
	channel_count 3
	channel 5, Cry_15_Ch5
	channel 6, Cry_15_Ch6
	channel 8, Cry_15_Ch8

Cry_16:
	channel_count 3
	channel 5, Cry_16_Ch5
	channel 6, Cry_16_Ch6
	channel 8, Cry_16_Ch8

Cry_17:
	channel_count 3
	channel 5, Cry_17_Ch5
	channel 6, Cry_17_Ch6
	channel 8, Cry_17_Ch8

Cry_18:
	channel_count 3
	channel 5, Cry_18_Ch5
	channel 6, Cry_18_Ch6
	channel 8, Cry_18_Ch8

Cry_19:
	channel_count 3
	channel 5, Cry_19_Ch5
	channel 6, Cry_19_Ch6
	channel 8, Cry_19_Ch8

Cry_1a:
	channel_count 3
	channel 5, Cry_1a_Ch5
	channel 6, Cry_1a_Ch6
	channel 8, Cry_1a_Ch8

Cry_1b:
	channel_count 3
	channel 5, Cry_1b_Ch5
	channel 6, Cry_1b_Ch6
	channel 8, Cry_1b_Ch8

Cry_1c:
	channel_count 3
	channel 5, Cry_1c_Ch5
	channel 6, Cry_1c_Ch6
	channel 8, Cry_1c_Ch8

Cry_1d:
	channel_count 3
	channel 5, Cry_1d_Ch5
	channel 6, Cry_1d_Ch6
	channel 8, Cry_1d_Ch8

Cry_1e:
	channel_count 3
	channel 5, Cry_1e_Ch5
	channel 6, Cry_1e_Ch6
	channel 8, Cry_1e_Ch8

Cry_1f:
	channel_count 3
	channel 5, Cry_1f_Ch5
	channel 6, Cry_1f_Ch6
	channel 8, Cry_1f_Ch8

Cry_20:
	channel_count 3
	channel 5, Cry_20_Ch5
	channel 6, Cry_20_Ch6
	channel 8, Cry_20_Ch8

Cry_21:
	channel_count 3
	channel 5, Cry_21_Ch5
	channel 6, Cry_21_Ch6
	channel 8, Cry_21_Ch8

Cry_22:
	channel_count 3
	channel 5, Cry_22_Ch5
	channel 6, Cry_22_Ch6
	channel 8, Cry_22_Ch8

Cry_23:
	channel_count 3
	channel 5, Cry_23_Ch5
	channel 6, Cry_23_Ch6
	channel 8, Cry_23_Ch8

Cry_24:
	channel_count 3
	channel 5, Cry_24_Ch5
	channel 6, Cry_24_Ch6
	channel 8, Cry_24_Ch8

Cry_25:
	channel_count 3
	channel 5, Cry_25_Ch5
	channel 6, Cry_25_Ch6
	channel 8, Cry_25_Ch8

Cry_Unreferenced_Ch5: ; unreferenced
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 14, 0, 1920
	square_note 15, 15, 0, 1924
	square_note 15, 12, 3, 1504
	square_note 15, 12, 4, 1536
	square_note 10, 6, -4, 1920
	square_note 8, 7, 1, 1924
	sound_ret

Cry_Unreferenced_Ch6: ; unreferenced
	duty_cycle_pattern 0, 0, 1, 1
	square_note 15, 10, 0, 1857
	square_note 15, 11, 0, 1859
	square_note 15, 9, 3, 1457
	square_note 15, 9, 4, 1473
	square_note 10, 4, -4, 1857
	square_note 8, 3, 1, 1862
	sound_ret

Cry_Unreferenced_Ch8: ; unreferenced
	noise_note 2, 15, 2, 76
	noise_note 6, 14, 0, 58
	noise_note 15, 13, 0, 58
	noise_note 8, 13, 0, 44
	noise_note 6, 14, 6, 76
	noise_note 12, 7, -5, 76
	noise_note 15, 13, 3, 76
	sound_ret

Cry_09_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 15, 7, 1952
	square_note 6, 14, 6, 1955
	square_note 10, 15, 4, 1952
	duty_cycle_pattern 2, 2, 1, 1
	square_note 10, 15, 6, 2008
	square_note 4, 14, 3, 2007
	square_note 15, 15, 2, 2008
	sound_ret

Cry_09_Ch6:
	duty_cycle_pattern 0, 0, 1, 1
	square_note 2, 0, 8, 0
	square_note 15, 10, 7, 1697
	square_note 6, 8, 6, 1698
	square_note 10, 7, 4, 1697
	duty_cycle_pattern 1, 1, 3, 3
	square_note 10, 7, 6, 1750
	square_note 4, 8, 3, 1753
	square_note 15, 10, 2, 1751
	sound_ret

Cry_09_Ch8:
	noise_note 2, 15, 2, 60
	noise_note 8, 14, 4, 62
	noise_note 15, 13, 7, 60
	noise_note 6, 12, 5, 59
	noise_note 6, 14, 4, 61
	noise_note 8, 11, 6, 60
	noise_note 6, 13, 4, 61
	noise_note 8, 12, 1, 59
	sound_ret

Cry_23_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 15, 7, 1984
	square_note 6, 14, 4, 1985
	square_note 10, 15, 6, 1984
	square_note 4, 13, 3, 1986
	square_note 8, 12, 1, 1984
	sound_ret

Cry_23_Ch6:
	duty_cycle_pattern 1, 1, 3, 3
	square_note 15, 9, 7, 1921
	square_note 6, 8, 4, 1920
	square_note 10, 9, 6, 1921
	square_note 15, 8, 3, 1921
	sound_ret

Cry_23_Ch8:
	noise_note 3, 15, 2, 60
	noise_note 13, 14, 6, 44
	noise_note 15, 13, 7, 60
	noise_note 8, 12, 1, 44
	sound_ret

Cry_24_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 15, 7, 1664
	square_note 10, 14, 6, 1668
	square_note 15, 13, 7, 1680
	square_note 8, 13, 5, 1680
	square_note 6, 12, 4, 1672
	square_note 5, 13, 3, 1648
	square_note 4, 13, 3, 1632
	square_note 8, 12, 1, 1600
	sound_ret

Cry_24_Ch6:
	duty_cycle_pattern 0, 0, 1, 1
	square_note 15, 11, 7, 1601
	square_note 10, 9, 6, 1602
	square_note 15, 10, 7, 1617
	square_note 8, 10, 5, 1617
	square_note 6, 9, 4, 1607
	square_note 5, 10, 3, 1585
	square_note 4, 9, 3, 1570
	square_note 8, 7, 1, 1537
	sound_ret

Cry_24_Ch8:
	noise_note 15, 14, 4, 60
	noise_note 10, 12, 7, 76
	noise_note 10, 12, 7, 60
	noise_note 12, 11, 7, 76
	noise_note 15, 10, 2, 92
	sound_ret

Cry_11_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 6, 15, 7, 1952
	square_note 8, 14, 6, 1956
	square_note 4, 13, 6, 1952
	square_note 15, 13, 3, 1824
	square_note 8, 12, 3, 1827
	square_note 2, 12, 2, 1832
	square_note 8, 11, 1, 1840
	sound_ret

Cry_11_Ch6:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 4, 0, 8, 0
	square_note 6, 10, 7, 1857
	square_note 8, 8, 6, 1859
	square_note 4, 7, 6, 1857
	square_note 13, 8, 3, 1730
	square_note 7, 7, 3, 1729
	square_note 3, 8, 2, 1740
	square_note 8, 7, 1, 1752
	sound_ret

Cry_11_Ch8:
	noise_note 2, 15, 2, 76
	noise_note 6, 14, 6, 58
	noise_note 4, 13, 7, 58
	noise_note 6, 13, 6, 44
	noise_note 8, 14, 5, 60
	noise_note 12, 13, 2, 61
	noise_note 8, 13, 1, 44
	sound_ret

Cry_25_Ch5:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 6, 15, 4, 1856
	square_note 15, 14, 3, 1840
	square_note 4, 15, 4, 1856
	square_note 5, 11, 3, 1864
	square_note 8, 13, 1, 1872
	sound_ret

Cry_25_Ch6:
	duty_cycle_pattern 1, 3, 1, 3
	square_note 6, 12, 3, 1810
	square_note 15, 11, 3, 1796
	square_note 3, 12, 3, 1810
	square_note 4, 12, 3, 1825
	square_note 8, 11, 1, 1842
	sound_ret

Cry_25_Ch8:
	noise_note 8, 13, 6, 44
	noise_note 12, 12, 6, 60
	noise_note 10, 11, 6, 44
	noise_note 8, 9, 1, 28
	sound_ret

Cry_03_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 4, 15, 7, 1544
	square_note 6, 14, 6, 1536
	square_note 6, 13, 7, 1520
	square_note 6, 12, 4, 1504
	square_note 5, 13, 3, 1472
	square_note 4, 13, 3, 1440
	square_note 8, 14, 1, 1408
	sound_ret

Cry_03_Ch6:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 4, 12, 7, 1284
	square_note 6, 10, 6, 1282
	square_note 6, 9, 7, 1265
	square_note 4, 11, 4, 1249
	square_note 5, 10, 3, 1218
	square_note 4, 11, 3, 1187
	square_note 8, 12, 1, 1154
	sound_ret

Cry_03_Ch8:
	noise_note 12, 14, 4, 76
	noise_note 10, 12, 7, 92
	noise_note 12, 11, 6, 76
	noise_note 15, 10, 2, 92
	sound_ret

Cry_0f_Ch5:
	duty_cycle_pattern 3, 3, 0, 1
	square_note 4, 15, 7, 1984
	square_note 12, 14, 6, 1986
	square_note 6, 11, 5, 1664
	square_note 4, 12, 4, 1648
	square_note 4, 11, 5, 1632
	square_note 8, 12, 1, 1600
	sound_ret

Cry_0f_Ch6:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 3, 12, 7, 1921
	square_note 12, 11, 6, 1920
	square_note 6, 10, 5, 1601
	square_note 4, 12, 4, 1586
	square_note 6, 11, 5, 1569
	square_note 8, 10, 1, 1538
	sound_ret

Cry_0f_Ch8:
	noise_note 3, 14, 4, 60
	noise_note 12, 13, 6, 44
	noise_note 4, 14, 4, 60
	noise_note 8, 11, 7, 92
	noise_note 15, 12, 2, 93
	sound_ret

Cry_10_Ch5:
	duty_cycle_pattern 3, 0, 2, 1
	square_note 8, 15, 7, 1664
	square_note 2, 15, 7, 1632
	square_note 1, 14, 7, 1600
	square_note 1, 14, 7, 1568
	square_note 15, 13, 1, 1536
	square_note 4, 12, 7, 1856
	square_note 4, 10, 7, 1840
	square_note 15, 9, 1, 1824
	sound_ret

Cry_10_Ch6:
	duty_cycle_pattern 1, 3, 2, 1
	square_note 10, 14, 7, 1666
	square_note 2, 14, 7, 1634
	square_note 1, 13, 7, 1602
	square_note 1, 13, 7, 1570
	square_note 15, 12, 1, 1538
	square_note 4, 11, 7, 1858
	square_note 2, 9, 7, 1842
	square_note 15, 8, 1, 1826
	sound_ret

Cry_10_Ch8:
	noise_note 4, 7, 4, 33
	noise_note 4, 7, 4, 16
	noise_note 4, 7, 1, 32
	sound_ret

Cry_00_Ch5:
	duty_cycle_pattern 3, 3, 1, 1
	square_note 4, 15, 3, 1816
	square_note 15, 14, 5, 1944
	square_note 8, 9, 1, 1880
	sound_ret

Cry_00_Ch6:
	duty_cycle_pattern 2, 2, 0, 0
	square_note 5, 11, 3, 1800
	square_note 15, 12, 5, 1928
	square_note 8, 7, 1, 1864
	sound_ret

Cry_00_Ch8:
	noise_note 3, 10, 1, 28
	noise_note 14, 9, 4, 44
	noise_note 8, 8, 1, 28
	sound_ret

Cry_0e_Ch5:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 4, 14, 1, 1792
	square_note 4, 15, 2, 1920
	square_note 2, 9, 2, 1856
	square_note 8, 14, 1, 1536
	sound_ret

Cry_0e_Ch6:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 4, 11, 1, 1761
	square_note 3, 12, 2, 1761
	square_note 3, 6, 2, 1665
	square_note 8, 11, 1, 1505
	sound_ret

Cry_0e_Ch8:
	noise_note 2, 6, 1, 50
	noise_note 2, 6, 1, 33
	noise_note 8, 6, 1, 17
	sound_ret

Cry_06_Ch5:
	duty_cycle_pattern 3, 3, 2, 2
	square_note 6, 8, 3, 583
	square_note 15, 6, 2, 550
	square_note 4, 5, 2, 581
	square_note 9, 6, 3, 518
	square_note 15, 8, 2, 549
	square_note 15, 4, 2, 519

Cry_06_Ch6:
	sound_ret

Cry_06_Ch8:
	noise_note 8, 13, 4, 140
	noise_note 4, 14, 2, 156
	noise_note 15, 12, 6, 140
	noise_note 8, 14, 4, 172
	noise_note 15, 13, 7, 156
	noise_note 15, 15, 2, 172
	sound_ret

Cry_07_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 4, 15, 3, 1760
	square_note 15, 14, 4, 1600
	square_note 8, 12, 1, 1568
	sound_ret

Cry_07_Ch6:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 3, 12, 3, 1667
	square_note 14, 11, 4, 1538
	square_note 8, 10, 1, 1537
	sound_ret

Cry_07_Ch8:
	noise_note 4, 13, 3, 92
	noise_note 15, 14, 6, 76
	noise_note 8, 11, 1, 92
	sound_ret

Cry_05_Ch5:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 6, 14, 2, 1280
	square_note 6, 14, 3, 1408
	square_note 6, 13, 3, 1392
	square_note 8, 10, 1, 1376
	sound_ret

Cry_05_Ch6:
	duty_cycle_pattern 3, 3, 1, 1
	square_note 6, 14, 2, 1154
	square_note 6, 13, 3, 1281
	square_note 6, 11, 2, 1250
	square_note 8, 8, 1, 1217

Cry_05_Ch8:
	sound_ret

Cry_0b_Ch5:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 4, 15, 1, 1792
	square_note 4, 14, 1, 1920
	square_note 4, 13, 1, 1856
	square_note 4, 14, 1, 1856
	square_note 4, 15, 1, 1920
	square_note 4, 13, 1, 1792
	square_note 4, 15, 1, 1793
	square_note 4, 13, 1, 1922
	square_note 4, 12, 1, 1858
	square_note 8, 11, 1, 1857
	sound_ret

Cry_0b_Ch6:
	duty_cycle_pattern 1, 0, 1, 0
	square_note 12, 0, 8, 0
	square_note 4, 15, 1, 1793
	square_note 4, 14, 1, 1922
	square_note 4, 13, 1, 1857
	square_note 4, 14, 1, 1857
	square_note 4, 15, 1, 1922
	square_note 8, 13, 1, 1793
	sound_ret

Cry_0b_Ch8:
	noise_note 15, 0, 8, 0
	noise_note 4, 0, 8, 0
	noise_note 4, 13, 1, 76
	noise_note 4, 11, 1, 44
	noise_note 4, 13, 1, 60
	noise_note 4, 11, 1, 60
	noise_note 4, 12, 1, 44
	noise_note 8, 10, 1, 76
	sound_ret

Cry_0c_Ch5:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 8, 15, 5, 1536
	square_note 2, 13, 2, 1592
	square_note 2, 12, 2, 1584
	square_note 2, 12, 2, 1576
	square_note 2, 11, 2, 1568
	square_note 2, 11, 2, 1552
	square_note 2, 10, 2, 1560
	square_note 2, 11, 2, 1552
	square_note 8, 12, 1, 1568
	sound_ret

Cry_0c_Ch6:
	duty_cycle_pattern 1, 0, 1, 0
	square_note 12, 12, 3, 1472
	square_note 3, 11, 1, 1529
	square_note 2, 10, 1, 1521
	square_note 2, 10, 1, 1513
	square_note 2, 9, 1, 1505
	square_note 2, 9, 1, 1497
	square_note 2, 8, 1, 1489
	square_note 2, 9, 1, 1497
	square_note 8, 9, 1, 1505

Cry_0c_Ch8:
	sound_ret

Cry_02_Ch5:
	duty_cycle_pattern 0, 0, 0, 0
	square_note 8, 15, 5, 1152
	square_note 2, 14, 1, 1504
	square_note 8, 13, 1, 1500
	sound_ret

Cry_02_Ch6:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 7, 9, 5, 1089
	square_note 2, 8, 1, 1313
	square_note 8, 6, 1, 1306

Cry_02_Ch8:
	sound_ret

Cry_0d_Ch5:
.loop
	duty_cycle_pattern 2, 0, 2, 0
	square_note 5, 15, 2, 1616
	square_note 9, 13, 1, 1632
	square_note 5, 14, 2, 1554
	square_note 9, 12, 1, 1570
	square_note 5, 15, 2, 1552
	square_note 6, 13, 1, 1568
	sound_loop 2, .loop
	sound_ret

Cry_0d_Ch6:
	duty_cycle_pattern 1, 0, 0, 0
	square_note 4, 0, 8, 0
	square_note 5, 15, 2, 1617
	square_note 9, 13, 1, 1633
	square_note 5, 14, 2, 1556
	square_note 8, 12, 1, 1572
	square_note 5, 15, 2, 1553
	square_note 12, 13, 1, 1569
	square_note 5, 14, 2, 1556
	square_note 8, 12, 1, 1572
	square_note 5, 15, 2, 1553
	square_note 4, 13, 1, 1569
	sound_ret

Cry_0d_Ch8:
	noise_note 6, 13, 2, 28
	noise_note 9, 11, 1, 44
	noise_note 8, 12, 2, 44
	noise_note 9, 11, 1, 60
	noise_note 6, 12, 2, 44
	noise_note 9, 10, 2, 60
	noise_note 7, 12, 2, 44
	noise_note 5, 10, 1, 60
	noise_note 9, 12, 2, 44
	noise_note 4, 10, 1, 60
	sound_ret

Cry_01_Ch5:
	duty_cycle_pattern 2, 2, 0, 0
	square_note 4, 15, 3, 1536
	square_note 8, 13, 5, 1888
	square_note 3, 14, 2, 1824
	square_note 8, 13, 1, 1808
	sound_ret

Cry_01_Ch6:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 5, 11, 3, 1777
	square_note 7, 12, 5, 1874
	square_note 3, 10, 2, 1809
	square_note 8, 11, 1, 1537
	sound_ret

Cry_01_Ch8:
	noise_note 3, 10, 2, 60
	noise_note 12, 9, 4, 44
	noise_note 3, 8, 2, 28
	noise_note 8, 7, 1, 44
	sound_ret

Cry_0a_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 8, 15, 7, 1760
	square_note 6, 14, 6, 1765
	square_note 3, 15, 4, 1760
	square_note 3, 15, 6, 1744
	square_note 3, 14, 3, 1728
	square_note 4, 15, 2, 1712
	square_note 15, 10, 2, 1736
	sound_ret

Cry_0a_Ch6:
	duty_cycle_pattern 0, 0, 1, 1
	square_note 3, 0, 8, 0
	square_note 8, 10, 7, 1697
	square_note 6, 8, 6, 1699
	square_note 3, 7, 4, 1697
	square_note 3, 7, 6, 1681
	square_note 3, 8, 3, 1666
	square_note 4, 10, 2, 1649
	square_note 15, 7, 2, 1673
	sound_ret

Cry_0a_Ch8:
	noise_note 2, 15, 2, 60
	noise_note 8, 14, 4, 62
	noise_note 8, 13, 7, 60
	noise_note 5, 12, 5, 59
	noise_note 3, 13, 4, 44
	noise_note 2, 11, 6, 60
	noise_note 3, 10, 4, 44
	noise_note 8, 9, 1, 60
	sound_ret

Cry_08_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 15, 6, 1381
	square_note 10, 14, 4, 1404
	square_note 3, 12, 2, 1372
	square_note 15, 11, 2, 1340
	sound_ret

Cry_08_Ch6:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 14, 13, 6, 1283
	square_note 9, 11, 4, 1307
	square_note 4, 9, 2, 1274
	square_note 15, 10, 2, 1243
	sound_ret

Cry_08_Ch8:
	noise_note 12, 14, 6, 76
	noise_note 11, 13, 7, 92
	noise_note 15, 12, 2, 76
	sound_ret

Cry_04_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 4, 15, 7, 1696
	square_note 8, 14, 6, 1700
	square_note 4, 13, 6, 1696
	square_note 12, 13, 3, 1568
	square_note 8, 12, 3, 1572
	square_note 4, 12, 2, 1568
	square_note 8, 11, 1, 1552
	sound_ret

Cry_04_Ch6:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 4, 14, 7, 1537
	square_note 8, 13, 6, 1539
	square_note 4, 12, 6, 1537
	square_note 12, 12, 3, 1409
	square_note 8, 11, 3, 1411
	square_note 4, 11, 2, 1410
	square_note 8, 10, 1, 1393
	sound_ret

Cry_04_Ch8:
	noise_note 7, 13, 6, 92
	noise_note 8, 14, 6, 76
	noise_note 4, 13, 4, 92
	noise_note 4, 13, 4, 76
	noise_note 7, 12, 3, 76
	noise_note 8, 10, 1, 92
	sound_ret

Cry_19_Ch5:
	duty_cycle_pattern 0, 1, 2, 3
	square_note 7, 13, 2, 1856
	square_note 15, 14, 5, 1888
	square_note 24, 12, 1, 1840
	sound_ret

Cry_19_Ch6:
	duty_cycle_pattern 2, 0, 0, 1
	square_note 2, 12, 2, 1793
	square_note 4, 12, 2, 1800
	square_note 15, 13, 7, 1857
	square_note 24, 10, 2, 1793

Cry_19_Ch8:
	sound_ret

Cry_16_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 15, 13, 7, 1920
	square_note 4, 14, 6, 1952
	square_note 15, 13, 2, 1856
	sound_ret

Cry_16_Ch6:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 15, 12, 7, 1875
	square_note 5, 11, 6, 1906
	square_note 15, 12, 2, 1809
	sound_ret

Cry_16_Ch8:
	noise_note 13, 15, 6, 76
	noise_note 4, 14, 6, 60
	noise_note 15, 15, 2, 76
	sound_ret

Cry_1b_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 6, 15, 7, 1728
	square_note 15, 14, 7, 1792
	square_note 4, 15, 4, 1776
	square_note 4, 14, 4, 1760
	square_note 8, 13, 1, 1744
	sound_ret

Cry_1b_Ch6:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 7, 14, 6, 1665
	square_note 14, 13, 5, 1729
	square_note 4, 12, 4, 1713
	square_note 4, 13, 4, 1697
	square_note 8, 12, 1, 1681
	sound_ret

Cry_1b_Ch8:
	noise_note 10, 10, 6, 60
	noise_note 14, 9, 4, 44
	noise_note 5, 10, 3, 60
	noise_note 8, 9, 1, 44
	sound_ret

Cry_12_Ch5:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 12, 15, 2, 1088
	square_note 15, 14, 3, 1184
	square_note 4, 13, 2, 1168
	square_note 8, 13, 1, 1152
	sound_ret

Cry_12_Ch6:
	duty_cycle_pattern 3, 2, 3, 2
	square_note 11, 13, 2, 1080
	square_note 14, 12, 6, 1176
	square_note 3, 11, 2, 1160
	square_note 8, 11, 1, 1144
	sound_ret

Cry_12_Ch8:
	noise_note 10, 14, 6, 108
	noise_note 15, 13, 2, 92
	noise_note 3, 12, 2, 108
	noise_note 8, 13, 1, 92
	sound_ret

Cry_13_Ch5:
	duty_cycle_pattern 0, 3, 0, 3
	square_note 15, 15, 6, 1472
	square_note 8, 14, 3, 1468
	square_note 6, 13, 2, 1488
	square_note 6, 11, 2, 1504
	square_note 6, 12, 2, 1520
	square_note 8, 11, 1, 1536
	sound_ret

Cry_13_Ch6:
	duty_cycle_pattern 2, 1, 2, 1
	square_note 14, 12, 6, 1201
	square_note 7, 12, 3, 1197
	square_note 5, 11, 2, 1217
	square_note 8, 9, 2, 1233
	square_note 6, 10, 2, 1249
	square_note 8, 9, 1, 1265
	sound_ret

Cry_13_Ch8:
	noise_note 10, 14, 6, 92
	noise_note 10, 13, 6, 108
	noise_note 4, 12, 2, 76
	noise_note 6, 13, 3, 92
	noise_note 8, 11, 3, 76
	noise_note 8, 10, 1, 92
	sound_ret

Cry_14_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 8, 14, 4, 1936
	square_note 15, 15, 5, 1984
	square_note 8, 13, 1, 2008
	sound_ret

Cry_14_Ch6:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 10, 12, 4, 1905
	square_note 15, 11, 6, 1954
	square_note 8, 10, 1, 1975
	sound_ret

Cry_14_Ch8:
	noise_note 8, 14, 4, 76
	noise_note 14, 12, 4, 60
	noise_note 8, 13, 1, 44
	sound_ret

Cry_1e_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 6, 15, 2, 1536
	square_note 6, 14, 2, 1600
	square_note 6, 13, 2, 1664
	square_note 6, 14, 2, 1728
	square_note 6, 13, 2, 1792
	square_note 6, 12, 2, 1856
	square_note 6, 11, 2, 1920
	square_note 8, 10, 1, 1984
	sound_ret

Cry_1e_Ch6:
	duty_cycle_pattern 0, 1, 0, 1
	square_note 3, 0, 8, 1
	square_note 6, 12, 2, 1473
	square_note 6, 11, 2, 1538
	square_note 6, 10, 2, 1601
	square_note 6, 11, 2, 1666
	square_note 6, 10, 2, 1730
	square_note 6, 9, 2, 1793
	square_note 6, 10, 2, 1858
	square_note 8, 8, 1, 1921
	sound_ret

Cry_1e_Ch8:
	noise_note 6, 0, 8, 1
	noise_note 5, 14, 2, 92
	noise_note 5, 12, 2, 76
	noise_note 5, 13, 2, 60
	noise_note 5, 11, 2, 44
	noise_note 5, 12, 2, 28
	noise_note 5, 10, 2, 27
	noise_note 5, 9, 2, 26
	noise_note 8, 8, 1, 24
	sound_ret

Cry_15_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 4, 15, 3, 1920
	square_note 15, 14, 7, 1792
	square_note 8, 13, 3, 1808
	square_note 4, 12, 2, 1792
	square_note 4, 13, 2, 1776
	square_note 8, 12, 1, 1760
	sound_ret

Cry_15_Ch6:
	duty_cycle_pattern 1, 1, 2, 2
	square_note 6, 12, 3, 1793
	square_note 14, 11, 7, 1665
	square_note 7, 11, 3, 1682
	square_note 3, 10, 2, 1665
	square_note 4, 11, 2, 1650
	square_note 8, 10, 1, 1633
	sound_ret

Cry_15_Ch8:
	noise_note 6, 14, 3, 92
	noise_note 14, 13, 6, 76
	noise_note 6, 12, 6, 60
	noise_note 3, 11, 3, 76
	noise_note 3, 10, 2, 92
	noise_note 8, 11, 1, 108
	sound_ret

Cry_17_Ch5:
	duty_cycle_pattern 0, 0, 3, 3
	square_note 15, 15, 7, 1280
	square_note 15, 14, 7, 1288
	square_note 8, 11, 4, 1152
	square_note 15, 10, 2, 1120
	sound_ret

Cry_17_Ch6:
	duty_cycle_pattern 1, 0, 1, 0
	square_note 14, 13, 7, 1153
	square_note 14, 12, 7, 1161
	square_note 10, 11, 4, 1025
	square_note 15, 12, 2, 993
	sound_ret

Cry_17_Ch8:
	noise_note 14, 15, 7, 124
	noise_note 12, 15, 6, 108
	noise_note 9, 14, 4, 124
	noise_note 15, 14, 2, 108
	sound_ret

Cry_1c_Ch5:
	duty_cycle_pattern 3, 3, 1, 1
	square_note 7, 13, 6, 2017
	square_note 6, 12, 6, 2018
	square_note 9, 13, 6, 2017
	square_note 7, 12, 6, 2016
	square_note 5, 11, 6, 2018
	square_note 7, 12, 6, 2017
	square_note 6, 11, 6, 2016
	square_note 8, 10, 1, 2015
	sound_ret

Cry_1c_Ch6:
	duty_cycle_pattern 1, 0, 1, 0
	square_note 6, 12, 3, 1993
	square_note 6, 11, 3, 1991
	square_note 10, 12, 4, 1987
	square_note 8, 11, 4, 1991
	square_note 6, 12, 3, 1993
	square_note 15, 10, 2, 1989
	sound_ret

Cry_1c_Ch8:
	noise_note 13, 1, -1, 124
	noise_note 13, 15, 7, 140
	noise_note 12, 13, 6, 124
	noise_note 8, 12, 4, 108
	noise_note 15, 11, 3, 92
	sound_ret

Cry_1a_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 6, 15, 7, 1856
	square_note 12, 14, 6, 1860
	square_note 6, 13, 5, 1872
	square_note 4, 12, 3, 1888
	square_note 3, 12, 3, 1920
	square_note 8, 13, 1, 1952
	sound_ret

Cry_1a_Ch6:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 6, 12, 7, 1793
	square_note 11, 11, 6, 1794
	square_note 6, 10, 5, 1809
	square_note 4, 9, 3, 1825
	square_note 3, 10, 3, 1857
	square_note 8, 9, 1, 1890
	sound_ret

Cry_1a_Ch8:
	noise_note 3, 14, 2, 60
	noise_note 8, 13, 6, 76
	noise_note 5, 13, 4, 60
	noise_note 12, 12, 7, 76
	noise_note 2, 14, 2, 60
	noise_note 8, 13, 1, 44
	sound_ret

Cry_1d_Ch5:
	duty_cycle_pattern 3, 3, 1, 0
	square_note 15, 15, 0, 1797
	square_note 10, 14, 0, 1792
	square_note 6, 11, 4, 1808
	square_note 4, 13, 3, 1792
	square_note 6, 11, 2, 1568
	square_note 8, 10, 1, 1572
	sound_ret

Cry_1d_Ch6:
	duty_cycle_pattern 0, 2, 0, 2
	square_note 15, 11, 0, 1731
	square_note 10, 10, 0, 1729
	square_note 6, 8, 4, 1746
	square_note 4, 9, 3, 1729
	square_note 6, 8, 2, 1505
	square_note 8, 6, 1, 1512
	sound_ret

Cry_1d_Ch8:
	noise_note 6, 14, 6, 76
	noise_note 15, 13, 6, 60
	noise_note 10, 12, 5, 74
	noise_note 1, 11, 2, 91
	noise_note 15, 12, 2, 76
	sound_ret

Cry_18_Ch5:
	duty_cycle_pattern 1, 1, 0, 0
	square_note 10, 15, 5, 1664
	square_note 3, 14, 2, 1696
	square_note 3, 15, 2, 1728
	square_note 3, 14, 2, 1760
	square_note 3, 13, 2, 1792
	square_note 3, 12, 2, 1760
	square_note 3, 13, 2, 1728
	square_note 8, 12, 1, 1696
	sound_ret

Cry_18_Ch6:
	duty_cycle_pattern 0, 0, 3, 3
	square_note 9, 13, 5, 1585
	square_note 3, 13, 2, 1618
	square_note 3, 14, 2, 1649
	square_note 3, 11, 2, 1681
	square_note 3, 12, 2, 1714
	square_note 3, 11, 2, 1681
	square_note 3, 12, 2, 1649
	square_note 8, 11, 1, 1617
	sound_ret

Cry_18_Ch8:
	noise_note 6, 14, 3, 76
	noise_note 4, 12, 3, 60
	noise_note 5, 13, 4, 60
	noise_note 4, 12, 4, 44
	noise_note 6, 11, 4, 60
	noise_note 8, 12, 1, 44
	sound_ret

Cry_1f_Ch5:
	duty_cycle_pattern 2, 2, 1, 1
	square_note 3, 15, 4, 1601
	square_note 13, 13, 6, 1825
	square_note 8, 15, 4, 1817
	square_note 8, 12, 1, 1818
	sound_ret

Cry_1f_Ch6:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 4, 15, 4, 1408
	square_note 14, 14, 6, 1760
	square_note 8, 13, 5, 1752
	square_note 8, 13, 1, 1756
	sound_ret

Cry_1f_Ch8:
	noise_note 5, 12, 4, 70
	noise_note 13, 10, 5, 68
	noise_note 8, 12, 4, 69
	noise_note 8, 11, 1, 68
	sound_ret

Cry_20_Ch5:
	duty_cycle_pattern 3, 3, 0, 0
	square_note 13, 15, 1, 1297
	square_note 13, 14, 1, 1301
	square_note 13, 14, 1, 1297
	square_note 8, 13, 1, 1297
	sound_ret

Cry_20_Ch6:
	duty_cycle_pattern 0, 1, 1, 1
	square_note 12, 14, 1, 1292
	square_note 12, 13, 1, 1296
	square_note 14, 12, 1, 1292
	square_note 8, 12, 1, 1290
	sound_ret

Cry_20_Ch8:
	noise_note 14, 15, 2, 101
	noise_note 13, 14, 2, 85
	noise_note 14, 13, 2, 86
	noise_note 8, 13, 1, 102
	sound_ret

Cry_21_Ch5:
	duty_cycle_pattern 0, 1, 2, 3
	square_note 3, 15, 3, 1380
	square_note 2, 14, 2, 1348
	square_note 5, 13, 1, 1314
	square_note 2, 11, 2, 1156
	square_note 8, 13, 1, 1186
	square_note 3, 15, 3, 1316
	square_note 4, 14, 4, 1252
	square_note 8, 13, 1, 1282
	sound_ret

Cry_21_Ch6:
	duty_cycle_pattern 3, 0, 3, 0
	square_note 3, 13, 3, 1376
	square_note 2, 12, 2, 1344
	square_note 5, 12, 1, 1312
	square_note 2, 9, 2, 1152
	square_note 8, 12, 1, 1184
	square_note 3, 13, 3, 1312
	square_note 3, 12, 4, 1248
	square_note 8, 12, 1, 1280

Cry_21_Ch8:
	sound_ret

Cry_22_Ch5:
	duty_cycle_pattern 0, 1, 0, 1
	square_note 2, 3, -5, 897
	square_note 7, 15, 5, 1537
	square_note 1, 12, 2, 1153
	square_note 8, 9, 1, 897
	sound_ret

Cry_22_Ch6:
	duty_cycle_pattern 3, 2, 3, 2
	square_note 2, 3, -6, 1456
	square_note 7, 13, 5, 1885
	square_note 1, 11, 2, 1712
	square_note 8, 6, 1, 1456
	sound_ret

Cry_22_Ch8:
	noise_note 2, 9, 2, 73
	noise_note 7, 11, 5, 41
	noise_note 1, 10, 2, 57
	noise_note 8, 9, 1, 73
	sound_ret

