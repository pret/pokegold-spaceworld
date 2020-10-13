INCLUDE "constants.asm"

SECTION "data/pokemon/evos_attacks.asm", ROMX

; Evolutions for Pokémon available in the demo were removed,
; and have been left in comments.

; Eevee's evolutions were not properly terminated by a 0,
; so its data is corrupt. (See EeveeEvosAttacks.)


INCLUDE "data/pokemon/evos_attacks_pointers.inc"


EvosAttacks::
; Evos+attacks data structure:
; - Evolution methods:
;    * db EVOLVE_LEVEL, level, dex
;    * db EVOLVE_STONE, 1, used item, dex
;    * db EVOLVE_ITEM, 1, held? item, dex
;    * db EVOLVE_TRADE, 1, dex
; - db 0 ; no more evolutions
; - Learnset (in increasing level order):
;    * db level, move
; - db 0 ; no more level-up moves


BulbasaurEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_IVYSAUR
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  2, MOVE_GROWL
	db  4, MOVE_STUN_SPORE
	db  7, MOVE_LEECH_SEED
	db 11, MOVE_VINE_WHIP
	db 16, MOVE_POISONPOWDER
	db 22, MOVE_GROWTH
	db 29, MOVE_RAZOR_LEAF
	db 37, MOVE_SLEEP_POWDER
	db 46, MOVE_SYNTHESIS
	db 56, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

IvysaurEvosAttacks:
	db EVOLVE_LEVEL, 32, DEX_VENUSAUR
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  3, MOVE_GROWL
	db  6, MOVE_STUN_SPORE
	db 10, MOVE_LEECH_SEED
	db 15, MOVE_VINE_WHIP
	db 21, MOVE_POISONPOWDER
	db 28, MOVE_GROWTH
	db 36, MOVE_RAZOR_LEAF
	db 45, MOVE_SLEEP_POWDER
	db 55, MOVE_SYNTHESIS
	db 66, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

VenusaurEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  4, MOVE_GROWL
	db  8, MOVE_STUN_SPORE
	db 13, MOVE_LEECH_SEED
	db 19, MOVE_VINE_WHIP
	db 26, MOVE_POISONPOWDER
	db 34, MOVE_GROWTH
	db 43, MOVE_RAZOR_LEAF
	db 53, MOVE_SLEEP_POWDER
	db 64, MOVE_SYNTHESIS
	db 76, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

CharmanderEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_CHARMELEON
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  3, MOVE_GROWL
	db  6, MOVE_LEER
	db 10, MOVE_EMBER
	db 15, MOVE_RAGE
	db 21, MOVE_FIRE_SPIN
	db 28, MOVE_SLASH
	db 36, MOVE_SCARY_FACE
	db 45, MOVE_AGILITY
	db 55, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

CharmeleonEvosAttacks:
	db EVOLVE_LEVEL, 36, DEX_CHARIZARD
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  4, MOVE_GROWL
	db  8, MOVE_LEER
	db 13, MOVE_EMBER
	db 19, MOVE_RAGE
	db 26, MOVE_FIRE_SPIN
	db 34, MOVE_SLASH
	db 43, MOVE_SCARY_FACE
	db 55, MOVE_AGILITY
	db 64, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

CharizardEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  5, MOVE_GROWL
	db 10, MOVE_LEER
	db 16, MOVE_EMBER
	db 23, MOVE_RAGE
	db 31, MOVE_FIRE_SPIN
	db 36, MOVE_WING_ATTACK
	db 40, MOVE_SLASH
	db 50, MOVE_SCARY_FACE
	db 61, MOVE_AGILITY
	db 73, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

SquirtleEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_WARTORTLE
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_TAIL_WHIP
	db 11, MOVE_BUBBLE
	db 16, MOVE_WITHDRAW
	db 21, MOVE_WATER_GUN
	db 26, MOVE_BITE
	db 31, MOVE_PROTECT
	db 36, MOVE_MIST
	db 36, MOVE_HAZE
	db 41, MOVE_SKULL_BASH
	db 46, MOVE_HYDRO_PUMP
	db 51, MOVE_RAIN_DANCE
	db 0 ; no more level-up moves

WartortleEvosAttacks:
	db EVOLVE_LEVEL, 36, DEX_BLASTOISE
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_TAIL_WHIP
	db 13, MOVE_BUBBLE
	db 19, MOVE_WITHDRAW
	db 25, MOVE_WATER_GUN
	db 31, MOVE_BITE
	db 37, MOVE_PROTECT
	db 43, MOVE_MIST
	db 43, MOVE_HAZE
	db 49, MOVE_SKULL_BASH
	db 55, MOVE_HYDRO_PUMP
	db 61, MOVE_RAIN_DANCE
	db 0 ; no more level-up moves

BlastoiseEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_TAIL_WHIP
	db 15, MOVE_BUBBLE
	db 22, MOVE_WITHDRAW
	db 29, MOVE_WATER_GUN
	db 36, MOVE_BITE
	db 43, MOVE_PROTECT
	db 50, MOVE_MIST
	db 70, MOVE_HAZE
	db 57, MOVE_SKULL_BASH
	db 64, MOVE_HYDRO_PUMP
	db 71, MOVE_RAIN_DANCE
	db 0 ; no more level-up moves

CaterpieEvosAttacks:
	db EVOLVE_LEVEL, 7, DEX_METAPOD
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  1, MOVE_STRING_SHOT
	db 0 ; no more level-up moves

MetapodEvosAttacks:
	db EVOLVE_LEVEL, 10, DEX_BUTTERFREE
	db 0 ; no more evolutions
	db  1, MOVE_HARDEN
	db 0 ; no more level-up moves

ButterfreeEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  1, MOVE_STRING_SHOT
	db 10, MOVE_CONFUSION
	db 12, MOVE_GUST
	db 16, MOVE_STUN_SPORE
	db 16, MOVE_POISONPOWDER
	db 16, MOVE_SLEEP_POWDER
	db 22, MOVE_WHIRLWIND
	db 30, MOVE_SUPERSONIC
	db 40, MOVE_PSYBEAM
	db 0 ; no more level-up moves

WeedleEvosAttacks:
	db EVOLVE_LEVEL, 7, DEX_KAKUNA
	db 0 ; no more evolutions
	db  1, MOVE_POISON_STING
	db  1, MOVE_STRING_SHOT
	db 0 ; no more level-up moves

KakunaEvosAttacks:
	db EVOLVE_LEVEL, 10, DEX_BEEDRILL
	db 0 ; no more evolutions
	db  1, MOVE_HARDEN
	db 0 ; no more level-up moves

BeedrillEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POISON_STING
	db  1, MOVE_STRING_SHOT
	db 10, MOVE_PURSUIT
	db 15, MOVE_FOCUS_ENERGY
	db 20, MOVE_TWINEEDLE
	db 25, MOVE_RAGE
	db 30, MOVE_FURY_ATTACK
	db 35, MOVE_AGILITY
	db 40, MOVE_PIN_MISSILE
	db 0 ; no more level-up moves

PidgeyEvosAttacks:
	; db EVOLVE_LEVEL, 18, DEX_PIDGEOTTO
	db 0 ; no more evolutions
	db  1, MOVE_GUST
	db  6, MOVE_SAND_ATTACK
	db 11, MOVE_QUICK_ATTACK
	db 17, MOVE_WHIRLWIND
	db 23, MOVE_WING_ATTACK
	db 30, MOVE_MUD_SLAP
	db 37, MOVE_AGILITY
	db 45, MOVE_MIRROR_MOVE
	db 0 ; no more level-up moves

PidgeottoEvosAttacks:
	db EVOLVE_LEVEL, 36, DEX_PIDGEOT
	db 0 ; no more evolutions
	db  1, MOVE_GUST
	db  7, MOVE_SAND_ATTACK
	db 13, MOVE_QUICK_ATTACK
	db 20, MOVE_WHIRLWIND
	db 27, MOVE_WING_ATTACK
	db 35, MOVE_MUD_SLAP
	db 43, MOVE_AGILITY
	db 52, MOVE_MIRROR_MOVE
	db 0 ; no more level-up moves

PidgeotEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_GUST
	db  8, MOVE_SAND_ATTACK
	db 15, MOVE_QUICK_ATTACK
	db 23, MOVE_WHIRLWIND
	db 31, MOVE_WING_ATTACK
	db 40, MOVE_MUD_SLAP
	db 49, MOVE_AGILITY
	db 59, MOVE_MIRROR_MOVE
	db 0 ; no more level-up moves

RattataEvosAttacks:
	; db EVOLVE_LEVEL, 20, DEX_RATICATE
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  4, MOVE_TAIL_WHIP
	db  8, MOVE_QUICK_ATTACK
	db 13, MOVE_LEER
	db 19, MOVE_SUPER_FANG
	db 26, MOVE_REVERSAL
	db 34, MOVE_FOCUS_ENERGY
	db 43, MOVE_HYPER_FANG
	db 0 ; no more level-up moves

RaticateEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  5, MOVE_TAIL_WHIP
	db 10, MOVE_QUICK_ATTACK
	db 16, MOVE_LEER
	db 23, MOVE_SUPER_FANG
	db 31, MOVE_REVERSAL
	db 40, MOVE_FOCUS_ENERGY
	db 50, MOVE_HYPER_FANG
	db 0 ; no more level-up moves

SpearowEvosAttacks:
	db EVOLVE_LEVEL, 20, DEX_FEAROW
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  5, MOVE_GROWL
	db 10, MOVE_LEER
	db 16, MOVE_PURSUIT
	db 23, MOVE_FURY_ATTACK
	db 31, MOVE_MIRROR_MOVE
	db 40, MOVE_DRILL_PECK
	db 50, MOVE_DOUBLE_TEAM
	db 61, MOVE_AGILITY
	db 0 ; no more level-up moves

FearowEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  6, MOVE_GROWL
	db 12, MOVE_LEER
	db 19, MOVE_PURSUIT
	db 27, MOVE_FURY_ATTACK
	db 36, MOVE_MIRROR_MOVE
	db 46, MOVE_DRILL_PECK
	db 57, MOVE_DOUBLE_TEAM
	db 69, MOVE_AGILITY
	db 0 ; no more level-up moves

EkansEvosAttacks:
	; db EVOLVE_LEVEL, 22, DEX_ARBOK
	db 0 ; no more evolutions
	db  1, MOVE_WRAP
	db  6, MOVE_LEER
	db 11, MOVE_POISON_STING
	db 17, MOVE_ACID
	db 23, MOVE_BITE
	db 30, MOVE_GLARE
	db 37, MOVE_SCREECH
	db 45, MOVE_SLAM
	db 0 ; no more level-up moves

ArbokEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WRAP
	db  7, MOVE_LEER
	db 13, MOVE_POISON_STING
	db 20, MOVE_ACID
	db 22, MOVE_SCARY_FACE
	db 27, MOVE_BITE
	db 35, MOVE_GLARE
	db 43, MOVE_SCREECH
	db 52, MOVE_SLAM
	db 0 ; no more level-up moves

PikachuEvosAttacks:
	; db EVOLVE_STONE, 1, ITEM_THUNDERSTONE, DEX_RAICHU
	db 0 ; no more evolutions
	db  1, MOVE_GROWL
	db  5, MOVE_THUNDERSHOCK
	db 10, MOVE_TAIL_WHIP
	db 16, MOVE_THUNDER_WAVE
	db 23, MOVE_QUICK_ATTACK
	db 31, MOVE_SWIFT
	db 40, MOVE_SPARK
	db 50, MOVE_AGILITY
	db 61, MOVE_THUNDER
	db 0 ; no more level-up moves

RaichuEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_THUNDERSHOCK
	db  1, MOVE_TAIL_WHIP
	db  1, MOVE_THUNDER_WAVE
	db  1, MOVE_SWIFT
	db 0 ; no more level-up moves

SandshrewEvosAttacks:
	db EVOLVE_LEVEL, 22, DEX_SANDSLASH
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  3, MOVE_DEFENSE_CURL
	db  6, MOVE_SAND_ATTACK
	db 10, MOVE_POISON_STING
	db 15, MOVE_SWIFT
	db 21, MOVE_SLASH
	db 28, MOVE_MUD_SLAP
	db 36, MOVE_FURY_SWIPES
	db 45, MOVE_FOCUS_ENERGY
	db 0 ; no more level-up moves

SandslashEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  4, MOVE_DEFENSE_CURL
	db  8, MOVE_SAND_ATTACK
	db 13, MOVE_POISON_STING
	db 19, MOVE_SWIFT
	db 22, MOVE_PIN_MISSILE
	db 26, MOVE_SLASH
	db 34, MOVE_MUD_SLAP
	db 43, MOVE_FURY_SWIPES
	db 53, MOVE_FOCUS_ENERGY
	db 0 ; no more level-up moves

NidoranFEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_NIDORINA
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  4, MOVE_GROWL
	db  8, MOVE_SCRATCH
	db 13, MOVE_POISON_STING
	db 19, MOVE_DOUBLE_KICK
	db 26, MOVE_TAIL_WHIP
	db 34, MOVE_BITE
	db 43, MOVE_FURY_SWIPES
	db 0 ; no more level-up moves

NidorinaEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_MOON_STONE, DEX_NIDOQUEEN
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_GROWL
	db 12, MOVE_SCRATCH
	db 19, MOVE_POISON_STING
	db 27, MOVE_DOUBLE_KICK
	db 36, MOVE_TAIL_WHIP
	db 46, MOVE_BITE
	db 57, MOVE_FURY_SWIPES
	db 0 ; no more level-up moves

NidoqueenEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  1, MOVE_DOUBLE_KICK
	db  1, MOVE_TAIL_WHIP
	db 27, MOVE_BODY_SLAM
	db 46, MOVE_ATTRACT
	db 0 ; no more level-up moves

NidoranMEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_NIDORINO
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  4, MOVE_LEER
	db  8, MOVE_POISON_STING
	db 13, MOVE_HORN_ATTACK
	db 19, MOVE_DOUBLE_KICK
	db 26, MOVE_FOCUS_ENERGY
	db 34, MOVE_HORN_DRILL
	db 43, MOVE_FURY_ATTACK
	db 0 ; no more level-up moves

NidorinoEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_MOON_STONE, DEX_NIDOKING
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_LEER
	db 12, MOVE_POISON_STING
	db 19, MOVE_HORN_ATTACK
	db 27, MOVE_DOUBLE_KICK
	db 36, MOVE_FOCUS_ENERGY
	db 46, MOVE_HORN_DRILL
	db 57, MOVE_FURY_ATTACK
	db 0 ; no more level-up moves

NidokingEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_HORN_ATTACK
	db  1, MOVE_DOUBLE_KICK
	db  1, MOVE_FOCUS_ENERGY
	db 27, MOVE_THRASH
	db 46, MOVE_ATTRACT
	db 0 ; no more level-up moves

ClefairyEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_MOON_STONE, DEX_CLEFABLE
	db 0 ; no more evolutions
	db  1, MOVE_GROWL
	db  4, MOVE_POUND
	db  8, MOVE_SING
	db 13, MOVE_DEFENSE_CURL
	db 19, MOVE_DOUBLESLAP
	db 26, MOVE_MINIMIZE
	db 34, MOVE_METRONOME
	db 43, MOVE_LIGHT_SCREEN
	db 53, MOVE_MIMIC
	db 64, MOVE_MOONLIGHT
	db 0 ; no more level-up moves

ClefableEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SING
	db  1, MOVE_DOUBLESLAP
	db  1, MOVE_MINIMIZE
	db  1, MOVE_METRONOME
	db 0 ; no more level-up moves

VulpixEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_FIRE_STONE, DEX_NINETALES
	db 0 ; no more evolutions
	db  1, MOVE_TAIL_WHIP
	db  6, MOVE_QUICK_ATTACK
	db 11, MOVE_ROAR
	db 17, MOVE_EMBER
	db 23, MOVE_FORESIGHT
	db 30, MOVE_FIRE_SPIN
	db 37, MOVE_CONFUSE_RAY
	db 45, MOVE_DOUBLE_TEAM
	db 53, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

NinetalesEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_QUICK_ATTACK
	db  1, MOVE_FIRE_SPIN
	db  1, MOVE_CONFUSE_RAY
	db  1, MOVE_DOUBLE_TEAM
	db 0 ; no more level-up moves

JigglypuffEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_MOON_STONE, DEX_WIGGLYTUFF
	db 0 ; no more evolutions
	db  1, MOVE_GROWL
	db  6, MOVE_SING
	db 12, MOVE_POUND
	db 18, MOVE_DISABLE
	db 24, MOVE_DEFENSE_CURL
	db 30, MOVE_DOUBLESLAP
	db 36, MOVE_REST
	db 42, MOVE_BODY_SLAM
	db 48, MOVE_PAIN_SPLIT
	db 54, MOVE_PERISH_SONG
	db 60, MOVE_DOUBLE_EDGE
	db 0 ; no more level-up moves

WigglytuffEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SING
	db  1, MOVE_DEFENSE_CURL
	db  1, MOVE_DOUBLESLAP
	db  1, MOVE_PAIN_SPLIT
	db 0 ; no more level-up moves

ZubatEvosAttacks:
	db EVOLVE_LEVEL, 22, DEX_GOLBAT
	db 0 ; no more evolutions
	db  1, MOVE_LEECH_LIFE
	db  7, MOVE_SUPERSONIC
	db 14, MOVE_BITE
	db 21, MOVE_HAZE
	db 28, MOVE_SCREECH
	db 35, MOVE_STALKER
	db 42, MOVE_WING_ATTACK
	db 49, MOVE_CONFUSE_RAY
	db 0 ; no more level-up moves

GolbatEvosAttacks:
	db EVOLVE_LEVEL, 44, DEX_EKSING
	db 0 ; no more evolutions
	db  1, MOVE_LEECH_LIFE
	db  8, MOVE_SUPERSONIC
	db 16, MOVE_BITE
	db 24, MOVE_HAZE
	db 32, MOVE_SCREECH
	db 40, MOVE_STALKER
	db 48, MOVE_WING_ATTACK
	db 56, MOVE_CONFUSE_RAY
	db 0 ; no more level-up moves

OddishEvosAttacks:
	db EVOLVE_LEVEL, 21, DEX_GLOOM
	db 0 ; no more evolutions
	db  1, MOVE_ABSORB
	db  5, MOVE_STUN_SPORE
	db  8, MOVE_POISONPOWDER
	db 11, MOVE_SLEEP_POWDER
	db 15, MOVE_ACID
	db 22, MOVE_GROWTH
	db 29, MOVE_PETAL_DANCE
	db 36, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

GloomEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_LEAF_STONE, DEX_VILEPLUME
	db EVOLVE_STONE, 1, ITEM_POISON_STONE, DEX_KIREIHANA
	db 0 ; no more evolutions
	db  1, MOVE_ABSORB
	db  6, MOVE_STUN_SPORE
	db 10, MOVE_POISONPOWDER
	db 14, MOVE_SLEEP_POWDER
	db 19, MOVE_ACID
	db 28, MOVE_GROWTH
	db 37, MOVE_PETAL_DANCE
	db 46, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

VileplumeEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_ABSORB
	db  1, MOVE_STUN_SPORE
	db  1, MOVE_ACID
	db  1, MOVE_PETAL_DANCE
	db 0 ; no more level-up moves

ParasEvosAttacks:
	db EVOLVE_LEVEL, 24, DEX_PARASECT
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  4, MOVE_STUN_SPORE
	db  8, MOVE_LEECH_LIFE
	db 13, MOVE_POISONPOWDER
	db 19, MOVE_GROWTH
	db 26, MOVE_FURY_SWIPES
	db 34, MOVE_SLASH
	db 43, MOVE_SPORE
	db 0 ; no more level-up moves

ParasectEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  5, MOVE_STUN_SPORE
	db 10, MOVE_LEECH_LIFE
	db 16, MOVE_POISONPOWDER
	db 23, MOVE_GROWTH
	db 31, MOVE_FURY_SWIPES
	db 40, MOVE_SLASH
	db 50, MOVE_SPORE
	db 0 ; no more level-up moves

VenonatEvosAttacks:
	db EVOLVE_LEVEL, 31, DEX_VENOMOTH
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_DISABLE
	db 14, MOVE_SUPERSONIC
	db 21, MOVE_POISONPOWDER
	db 28, MOVE_STUN_SPORE
	db 35, MOVE_LEECH_LIFE
	db 42, MOVE_PSYBEAM
	db 49, MOVE_SLEEP_POWDER
	db 56, MOVE_PSYCHIC
	db 0 ; no more level-up moves

VenomothEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_DISABLE
	db 16, MOVE_SUPERSONIC
	db 24, MOVE_POISONPOWDER
	db 32, MOVE_STUN_SPORE
	db 40, MOVE_LEECH_LIFE
	db 48, MOVE_PSYBEAM
	db 56, MOVE_SLEEP_POWDER
	db 64, MOVE_PSYCHIC
	db 0 ; no more level-up moves

DiglettEvosAttacks:
	db EVOLVE_LEVEL, 26, DEX_DUGTRIO
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  4, MOVE_GROWL
	db  8, MOVE_SAND_ATTACK
	db 13, MOVE_MAGNITUDE
	db 19, MOVE_DIG
	db 26, MOVE_MUD_SLAP
	db 34, MOVE_SLASH
	db 43, MOVE_SANDSTORM
	db 53, MOVE_EARTHQUAKE
	db 0 ; no more level-up moves

DugtrioEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  5, MOVE_GROWL
	db 10, MOVE_SAND_ATTACK
	db 16, MOVE_MAGNITUDE
	db 23, MOVE_DIG
	db 31, MOVE_MUD_SLAP
	db 40, MOVE_SLASH
	db 50, MOVE_SANDSTORM
	db 61, MOVE_EARTHQUAKE
	db 0 ; no more level-up moves

MeowthEvosAttacks:
	db EVOLVE_LEVEL, 28, DEX_PERSIAN
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  5, MOVE_GROWL
	db  9, MOVE_TAIL_WHIP
	db 14, MOVE_SAND_ATTACK
	db 19, MOVE_PAY_DAY
	db 25, MOVE_BITE
	db 31, MOVE_FURY_SWIPES
	db 38, MOVE_THIEF
	db 45, MOVE_SCREECH
	db 53, MOVE_SLASH
	db 61, MOVE_COIN_HURL
	db 0 ; no more level-up moves

PersianEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  6, MOVE_GROWL
	db 11, MOVE_TAIL_WHIP
	db 17, MOVE_SAND_ATTACK
	db 23, MOVE_PAY_DAY
	db 30, MOVE_BITE
	db 37, MOVE_FURY_SWIPES
	db 45, MOVE_THIEF
	db 53, MOVE_SCREECH
	db 62, MOVE_SLASH
	db 71, MOVE_COIN_HURL
	db 0 ; no more level-up moves

PsyduckEvosAttacks:
	db EVOLVE_LEVEL, 33, DEX_GOLDUCK
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  8, MOVE_TAIL_WHIP
	db 15, MOVE_WATER_GUN
	db 22, MOVE_CONFUSION
	db 29, MOVE_DISABLE
	db 36, MOVE_PSYBEAM
	db 43, MOVE_FURY_SWIPES
	db 50, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

GolduckEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  9, MOVE_TAIL_WHIP
	db 17, MOVE_WATER_GUN
	db 25, MOVE_CONFUSION
	db 33, MOVE_DISABLE
	db 41, MOVE_PSYBEAM
	db 49, MOVE_FURY_SWIPES
	db 57, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

MankeyEvosAttacks:
	db EVOLVE_LEVEL, 28, DEX_PRIMEAPE
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  7, MOVE_LEER
	db 13, MOVE_RAGE
	db 19, MOVE_KARATE_CHOP
	db 25, MOVE_ROCK_HEAD
	db 31, MOVE_FOCUS_ENERGY
	db 37, MOVE_SEISMIC_TOSS
	db 43, MOVE_FURY_SWIPES
	db 49, MOVE_SCARY_FACE
	db 55, MOVE_THRASH
	db 0 ; no more level-up moves

PrimeapeEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  8, MOVE_LEER
	db 15, MOVE_RAGE
	db 22, MOVE_KARATE_CHOP
	db 29, MOVE_ROCK_HEAD
	db 36, MOVE_FOCUS_ENERGY
	db 43, MOVE_SEISMIC_TOSS
	db 50, MOVE_FURY_SWIPES
	db 57, MOVE_SCARY_FACE
	db 64, MOVE_THRASH
	db 0 ; no more level-up moves

GrowlitheEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_FIRE_STONE, DEX_ARCANINE
	db 0 ; no more evolutions
	db  1, MOVE_EMBER
	db  7, MOVE_ROAR
	db 13, MOVE_QUICK_ATTACK
	db 20, MOVE_BITE
	db 27, MOVE_LEER
	db 35, MOVE_SACRED_FIRE
	db 43, MOVE_TAKE_DOWN
	db 52, MOVE_AGILITY
	db 61, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

ArcanineEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_QUICK_ATTACK
	db  1, MOVE_BITE
	db  1, MOVE_LEER
	db  1, MOVE_SACRED_FIRE
	db 0 ; no more level-up moves

PoliwagEvosAttacks:
	db EVOLVE_LEVEL, 25, DEX_POLIWHIRL
	db 0 ; no more evolutions
	db  1, MOVE_BUBBLE
	db  6, MOVE_HYPNOSIS
	db 11, MOVE_WATER_GUN
	db 17, MOVE_DOUBLESLAP
	db 23, MOVE_RAIN_DANCE
	db 30, MOVE_BODY_SLAM
	db 37, MOVE_AMNESIA
	db 45, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

PoliwhirlEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_WATER_STONE, DEX_POLIWRATH
	db EVOLVE_STONE, 1, ITEM_HEART_STONE, DEX_NYOROTONO
	db 0 ; no more evolutions
	db  1, MOVE_BUBBLE
	db  8, MOVE_HYPNOSIS
	db 15, MOVE_WATER_GUN
	db 23, MOVE_DOUBLESLAP
	db 31, MOVE_RAIN_DANCE
	db 40, MOVE_BODY_SLAM
	db 49, MOVE_AMNESIA
	db 59, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

PoliwrathEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_HYPNOSIS
	db  1, MOVE_WATER_GUN
	db  1, MOVE_DOUBLESLAP
	db 25, MOVE_LOW_KICK
	db 0 ; no more level-up moves

AbraEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_KADABRA
	db 0 ; no more evolutions
	db  1, MOVE_TELEPORT
	db 0 ; no more level-up moves

KadabraEvosAttacks:
	db EVOLVE_TRADE, 1, DEX_ALAKAZAM
	db 0 ; no more evolutions
	db  1, MOVE_TELEPORT
	db 16, MOVE_CONFUSION
	db 16, MOVE_KINESIS
	db 21, MOVE_DISABLE
	db 26, MOVE_SYNCHRONIZE
	db 31, MOVE_PSYBEAM
	db 36, MOVE_RECOVER
	db 41, MOVE_REFLECT
	db 41, MOVE_LIGHT_SCREEN
	db 46, MOVE_PSYCHIC
	db 0 ; no more level-up moves

AlakazamEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TELEPORT
	db 16, MOVE_CONFUSION
	db 16, MOVE_KINESIS
	db 21, MOVE_DISABLE
	db 26, MOVE_SYNCHRONIZE
	db 31, MOVE_PSYBEAM
	db 36, MOVE_RECOVER
	db 41, MOVE_REFLECT
	db 41, MOVE_LIGHT_SCREEN
	db 46, MOVE_PSYCHIC
	db 0 ; no more level-up moves

MachopEvosAttacks:
	db EVOLVE_LEVEL, 28, DEX_MACHOKE
	db 0 ; no more evolutions
	db  1, MOVE_KARATE_CHOP
	db  5, MOVE_LEER
	db  9, MOVE_FOCUS_ENERGY
	db 14, MOVE_LOW_KICK
	db 19, MOVE_MEDITATE
	db 25, MOVE_SEISMIC_TOSS
	db 31, MOVE_ENDURE
	db 38, MOVE_VITAL_THROW
	db 45, MOVE_SUBMISSION
	db 0 ; no more level-up moves

MachokeEvosAttacks:
	db EVOLVE_TRADE, 1, DEX_MACHAMP
	db 0 ; no more evolutions
	db  1, MOVE_KARATE_CHOP
	db  7, MOVE_LEER
	db 13, MOVE_FOCUS_ENERGY
	db 20, MOVE_LOW_KICK
	db 27, MOVE_MEDITATE
	db 35, MOVE_SEISMIC_TOSS
	db 43, MOVE_ENDURE
	db 52, MOVE_VITAL_THROW
	db 61, MOVE_SUBMISSION
	db 0 ; no more level-up moves

MachampEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_KARATE_CHOP
	db  7, MOVE_LEER
	db 13, MOVE_FOCUS_ENERGY
	db 20, MOVE_LOW_KICK
	db 27, MOVE_MEDITATE
	db 28, MOVE_COMET_PUNCH
	db 35, MOVE_SEISMIC_TOSS
	db 43, MOVE_ENDURE
	db 52, MOVE_VITAL_THROW
	db 61, MOVE_SUBMISSION
	db 0 ; no more level-up moves

BellsproutEvosAttacks:
	db EVOLVE_LEVEL, 21, DEX_WEEPINBELL
	db 0 ; no more evolutions
	db  1, MOVE_GROWTH
	db  5, MOVE_VINE_WHIP
	db  9, MOVE_WRAP
	db 13, MOVE_POISONPOWDER
	db 17, MOVE_SLEEP_POWDER
	db 21, MOVE_STUN_SPORE
	db 25, MOVE_ACID
	db 29, MOVE_RAZOR_LEAF
	db 33, MOVE_FALSE_SWIPE
	db 37, MOVE_SLAM
	db 0 ; no more level-up moves

WeepinbellEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_LEAF_STONE, DEX_VICTREEBEL
	db EVOLVE_STONE, 1, ITEM_POISON_STONE, DEX_TSUBOMITTO
	db 0 ; no more evolutions
	db  1, MOVE_GROWTH
	db  6, MOVE_VINE_WHIP
	db 11, MOVE_WRAP
	db 16, MOVE_POISONPOWDER
	db 21, MOVE_SLEEP_POWDER
	db 26, MOVE_STUN_SPORE
	db 31, MOVE_ACID
	db 36, MOVE_RAZOR_LEAF
	db 41, MOVE_FALSE_SWIPE
	db 46, MOVE_SLAM
	db 0 ; no more level-up moves

VictreebelEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WRAP
	db  1, MOVE_POISONPOWDER
	db  1, MOVE_ACID
	db  1, MOVE_RAZOR_LEAF
	db 0 ; no more level-up moves

TentacoolEvosAttacks:
	db EVOLVE_LEVEL, 30, DEX_TENTACRUEL
	db 0 ; no more evolutions
	db  1, MOVE_POISON_STING
	db  3, MOVE_SUPERSONIC
	db  6, MOVE_CONSTRICT
	db 10, MOVE_WATER_GUN
	db 15, MOVE_ACID
	db 21, MOVE_HAZE
	db 28, MOVE_WRAP
	db 36, MOVE_BARRIER
	db 45, MOVE_SCREECH
	db 55, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

TentacruelEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POISON_STING
	db  4, MOVE_SUPERSONIC
	db  8, MOVE_CONSTRICT
	db 13, MOVE_WATER_GUN
	db 19, MOVE_ACID
	db 26, MOVE_HAZE
	db 34, MOVE_WRAP
	db 43, MOVE_BARRIER
	db 53, MOVE_SCREECH
	db 64, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

GeodudeEvosAttacks:
	db EVOLVE_LEVEL, 25, DEX_GRAVELER
	db 0 ; no more evolutions
	db  1, MOVE_DEFENSE_CURL
	db  4, MOVE_TACKLE
	db  7, MOVE_ROCK_THROW
	db 11, MOVE_ROLLOUT
	db 15, MOVE_HARDEN
	db 20, MOVE_SELFDESTRUCT
	db 25, MOVE_MEGA_PUNCH
	db 31, MOVE_SANDSTORM
	db 37, MOVE_EARTHQUAKE
	db 44, MOVE_EXPLOSION
	db 0 ; no more level-up moves

GravelerEvosAttacks:
	db EVOLVE_TRADE, 1, DEX_GOLEM
	db 0 ; no more evolutions
	db  1, MOVE_DEFENSE_CURL
	db  6, MOVE_TACKLE
	db 11, MOVE_ROCK_THROW
	db 17, MOVE_ROLLOUT
	db 23, MOVE_HARDEN
	db 30, MOVE_SELFDESTRUCT
	db 37, MOVE_MEGA_PUNCH
	db 45, MOVE_SANDSTORM
	db 53, MOVE_EARTHQUAKE
	db 62, MOVE_EXPLOSION
	db 0 ; no more level-up moves

GolemEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_DEFENSE_CURL
	db  6, MOVE_TACKLE
	db 11, MOVE_ROCK_THROW
	db 17, MOVE_ROLLOUT
	db 23, MOVE_HARDEN
	db 30, MOVE_SELFDESTRUCT
	db 37, MOVE_MEGA_PUNCH
	db 45, MOVE_SANDSTORM
	db 53, MOVE_EARTHQUAKE
	db 62, MOVE_EXPLOSION
	db 0 ; no more level-up moves

PonytaEvosAttacks:
	db EVOLVE_LEVEL, 40, DEX_RAPIDASH
	db 0 ; no more evolutions
	db  1, MOVE_TAIL_WHIP
	db  8, MOVE_EMBER
	db 16, MOVE_QUICK_ATTACK
	db 24, MOVE_GROWL
	db 32, MOVE_STOMP
	db 40, MOVE_FLAME_WHEEL
	db 48, MOVE_AGILITY
	db 56, MOVE_FIRE_SPIN
	db 64, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

RapidashEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TAIL_WHIP
	db  9, MOVE_EMBER
	db 18, MOVE_QUICK_ATTACK
	db 27, MOVE_GROWL
	db 36, MOVE_STOMP
	db 45, MOVE_FLAME_WHEEL
	db 54, MOVE_AGILITY
	db 63, MOVE_FIRE_SPIN
	db 72, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

SlowpokeEvosAttacks:
	db EVOLVE_LEVEL, 37, DEX_SLOWBRO
	db 0 ; no more evolutions
	db  1, MOVE_CONFUSION
	db  7, MOVE_DISABLE
	db 14, MOVE_GROWL
	db 22, MOVE_WATER_GUN
	db 31, MOVE_HEADBUTT
	db 41, MOVE_AMNESIA
	db 52, MOVE_PSYCHIC
	db 0 ; no more level-up moves

SlowbroEvosAttacks:
	db EVOLVE_ITEM, 1, ITEM_KINGS_ROCK, DEX_YADOKING
	db 0 ; no more evolutions
	db  1, MOVE_CONFUSION
	db  9, MOVE_DISABLE
	db 18, MOVE_GROWL
	db 28, MOVE_WATER_GUN
	db 37, MOVE_WITHDRAW
	db 39, MOVE_HEADBUTT
	db 51, MOVE_AMNESIA
	db 64, MOVE_PSYCHIC
	db 0 ; no more level-up moves

MagnemiteEvosAttacks:
	db EVOLVE_LEVEL, 30, DEX_RAREMAGNEMITE
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_THUNDER_WAVE
	db 13, MOVE_THUNDERSHOCK
	db 20, MOVE_SONICBOOM
	db 27, MOVE_SUPERSONIC
	db 35, MOVE_LOCK_ON
	db 43, MOVE_SCREECH
	db 52, MOVE_SWIFT
	db 61, MOVE_ZAP_CANNON
	db 0 ; no more level-up moves

MagnetonEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_THUNDER_WAVE
	db 15, MOVE_THUNDERSHOCK
	db 23, MOVE_SONICBOOM
	db 31, MOVE_SUPERSONIC
	db 40, MOVE_LOCK_ON
	db 49, MOVE_SCREECH
	db 59, MOVE_SWIFT
	db 69, MOVE_ZAP_CANNON
	db 0 ; no more level-up moves

FarfetchdEvosAttacks:
	db EVOLVE_LEVEL, 24, DEX_MADAME
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  6, MOVE_SAND_ATTACK
	db 11, MOVE_LEER
	db 16, MOVE_FURY_ATTACK
	db 21, MOVE_WING_ATTACK
	db 26, MOVE_SWORDS_DANCE
	db 31, MOVE_FALSE_SWIPE
	db 36, MOVE_AGILITY
	db 41, MOVE_SLASH
	db 46, MOVE_FURY_CUTTER
	db 0 ; no more level-up moves

DoduoEvosAttacks:
	db EVOLVE_LEVEL, 31, DEX_DODRIO
	db 0 ; no more evolutions
	db  1, MOVE_GROWL
	db  6, MOVE_PECK
	db 11, MOVE_QUICK_ATTACK
	db 17, MOVE_RAGE
	db 23, MOVE_PURSUIT
	db 30, MOVE_FURY_ATTACK
	db 37, MOVE_AGILITY
	db 45, MOVE_TRI_ATTACK
	db 53, MOVE_DRILL_PECK
	db 0 ; no more level-up moves

DodrioEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_GROWL
	db  7, MOVE_PECK
	db 13, MOVE_QUICK_ATTACK
	db 20, MOVE_RAGE
	db 27, MOVE_PURSUIT
	db 35, MOVE_FURY_ATTACK
	db 43, MOVE_AGILITY
	db 52, MOVE_TRI_ATTACK
	db 61, MOVE_DRILL_PECK
	db 0 ; no more level-up moves

SeelEvosAttacks:
	db EVOLVE_LEVEL, 34, DEX_DEWGONG
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_GROWL
	db 14, MOVE_WATER_GUN
	db 14, MOVE_POWDER_SNOW
	db 21, MOVE_SING
	db 28, MOVE_HEADBUTT
	db 35, MOVE_LIGHT_SCREEN
	db 42, MOVE_AURORA_BEAM
	db 49, MOVE_TAKE_DOWN
	db 56, MOVE_ICE_BEAM
	db 0 ; no more level-up moves

DewgongEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_GROWL
	db 16, MOVE_WATER_GUN
	db 16, MOVE_POWDER_SNOW
	db 24, MOVE_SING
	db 32, MOVE_HEADBUTT
	db 40, MOVE_LIGHT_SCREEN
	db 48, MOVE_AURORA_BEAM
	db 56, MOVE_TAKE_DOWN
	db 64, MOVE_ICE_BEAM
	db 0 ; no more level-up moves

GrimerEvosAttacks:
	db EVOLVE_LEVEL, 38, DEX_MUK
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  3, MOVE_POISON_GAS
	db  6, MOVE_DISABLE
	db 10, MOVE_ACID
	db 15, MOVE_MINIMIZE
	db 21, MOVE_DISABLE
	db 28, MOVE_SLUDGE
	db 36, MOVE_HAZE
	db 45, MOVE_SCREECH
	db 55, MOVE_ACID_ARMOR
	db 66, MOVE_SLUDGE_BOMB
	db 0 ; no more level-up moves

MukEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  4, MOVE_POISON_GAS
	db  8, MOVE_DISABLE
	db 13, MOVE_ACID
	db 19, MOVE_MINIMIZE
	db 26, MOVE_DISABLE
	db 34, MOVE_SLUDGE
	db 43, MOVE_HAZE
	db 53, MOVE_SCREECH
	db 64, MOVE_ACID_ARMOR
	db 76, MOVE_SLUDGE_BOMB
	db 0 ; no more level-up moves

ShellderEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_WATER_STONE, DEX_CLOYSTER
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_WITHDRAW
	db 15, MOVE_SUPERSONIC
	db 22, MOVE_CLAMP
	db 29, MOVE_AURORA_BEAM
	db 36, MOVE_LEER
	db 43, MOVE_PROTECT
	db 50, MOVE_ENDURE
	db 57, MOVE_ICE_BEAM
	db 0 ; no more level-up moves

CloysterEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WITHDRAW
	db  1, MOVE_AURORA_BEAM
	db  1, MOVE_ENDURE
	db 57, MOVE_SPIKE_CANNON
	db 0 ; no more level-up moves

GastlyEvosAttacks:
	db EVOLVE_LEVEL, 25, DEX_HAUNTER
	db 0 ; no more evolutions
	db  1, MOVE_LICK
	db  5, MOVE_POISON_GAS
	db 10, MOVE_SPITE
	db 15, MOVE_DESTINY_BOND
	db 20, MOVE_NIGHT_SHADE
	db 25, MOVE_CONFUSE_RAY
	db 30, MOVE_SUBSTITUTE
	db 35, MOVE_HYPNOSIS
	db 40, MOVE_DREAM_EATER
	db 45, MOVE_NIGHTMARE
	db 0 ; no more level-up moves

HaunterEvosAttacks:
	db EVOLVE_TRADE, 1, DEX_GENGAR
	db 0 ; no more evolutions
	db  1, MOVE_LICK
	db  7, MOVE_POISON_GAS
	db 14, MOVE_SPITE
	db 21, MOVE_DESTINY_BOND
	db 28, MOVE_NIGHT_SHADE
	db 35, MOVE_CONFUSE_RAY
	db 42, MOVE_SUBSTITUTE
	db 49, MOVE_HYPNOSIS
	db 56, MOVE_DREAM_EATER
	db 63, MOVE_NIGHTMARE
	db 0 ; no more level-up moves

GengarEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_LICK
	db  7, MOVE_POISON_GAS
	db 14, MOVE_SPITE
	db 21, MOVE_DESTINY_BOND
	db 28, MOVE_NIGHT_SHADE
	db 35, MOVE_CONFUSE_RAY
	db 42, MOVE_SUBSTITUTE
	db 49, MOVE_HYPNOSIS
	db 56, MOVE_DREAM_EATER
	db 63, MOVE_NIGHTMARE
	db 0 ; no more level-up moves

OnixEvosAttacks:
	db EVOLVE_LEVEL, 38, DEX_HAGANEIL
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  5, MOVE_HARDEN
	db  9, MOVE_BIND
	db 14, MOVE_RAGE
	db 19, MOVE_ROCK_THROW
	db 25, MOVE_SCREECH
	db 31, MOVE_DIG
	db 38, MOVE_SANDSTORM
	db 45, MOVE_SLAM
	db 53, MOVE_IRON_TAIL
	db 0 ; no more level-up moves

DrowzeeEvosAttacks:
	db EVOLVE_LEVEL, 26, DEX_HYPNO
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  6, MOVE_HYPNOSIS
	db 11, MOVE_DISABLE
	db 16, MOVE_HEADBUTT
	db 21, MOVE_CONFUSION
	db 26, MOVE_POISON_GAS
	db 31, MOVE_MEDITATE
	db 36, MOVE_STALKER
	db 41, MOVE_PSYCHIC
	db 46, MOVE_CONFUSE_RAY
	db 0 ; no more level-up moves

HypnoEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  7, MOVE_HYPNOSIS
	db 13, MOVE_DISABLE
	db 19, MOVE_HEADBUTT
	db 25, MOVE_CONFUSION
	db 31, MOVE_POISON_GAS
	db 37, MOVE_MEDITATE
	db 43, MOVE_STALKER
	db 49, MOVE_PSYCHIC
	db 55, MOVE_CONFUSE_RAY
	db 0 ; no more level-up moves

KrabbyEvosAttacks:
	db EVOLVE_LEVEL, 28, DEX_KINGLER
	db 0 ; no more evolutions
	db  1, MOVE_BUBBLE
	db  3, MOVE_LEER
	db  6, MOVE_VICEGRIP
	db 10, MOVE_WATER_GUN
	db 15, MOVE_FALSE_SWIPE
	db 21, MOVE_HARDEN
	db 28, MOVE_VICEGRIP
	db 36, MOVE_STOMP
	db 45, MOVE_GUILLOTINE
	db 55, MOVE_CRABHAMMER
	db 0 ; no more level-up moves

KinglerEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_BUBBLE
	db  4, MOVE_LEER
	db  8, MOVE_VICEGRIP
	db 13, MOVE_WATER_GUN
	db 19, MOVE_FALSE_SWIPE
	db 26, MOVE_HARDEN
	db 34, MOVE_VICEGRIP
	db 43, MOVE_STOMP
	db 53, MOVE_GUILLOTINE
	db 64, MOVE_CRABHAMMER
	db 0 ; no more level-up moves

VoltorbEvosAttacks:
	db EVOLVE_LEVEL, 30, DEX_ELECTRODE
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  9, MOVE_THUNDER_WAVE
	db 17, MOVE_SONICBOOM
	db 25, MOVE_SELFDESTRUCT
	db 33, MOVE_SWIFT
	db 41, MOVE_SCREECH
	db 49, MOVE_LIGHT_SCREEN
	db 57, MOVE_EXPLOSION
	db 0 ; no more level-up moves

ElectrodeEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db 10, MOVE_THUNDER_WAVE
	db 19, MOVE_SONICBOOM
	db 28, MOVE_SELFDESTRUCT
	db 37, MOVE_SWIFT
	db 46, MOVE_SCREECH
	db 55, MOVE_LIGHT_SCREEN
	db 64, MOVE_EXPLOSION
	db 0 ; no more level-up moves

ExeggcuteEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_LEAF_STONE, DEX_EXEGGUTOR
	db 0 ; no more evolutions
	db  1, MOVE_BARRAGE
	db  6, MOVE_HYPNOSIS
	db 11, MOVE_CONFUSION
	db 17, MOVE_LEECH_SEED
	db 23, MOVE_REFLECT
	db 30, MOVE_POISONPOWDER
	db 37, MOVE_STUN_SPORE
	db 45, MOVE_SLEEP_POWDER
	db 53, MOVE_TEMPT
	db 62, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

ExeggutorEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_BARRAGE
	db  1, MOVE_CONFUSION
	db  1, MOVE_LEECH_SEED
	db  1, MOVE_SLEEP_POWDER
	db 62, MOVE_STOMP
	db 0 ; no more level-up moves

CuboneEvosAttacks:
	db EVOLVE_LEVEL, 28, DEX_MAROWAK
	db 0 ; no more evolutions
	db  1, MOVE_BONE_CLUB
	db  7, MOVE_GROWL
	db 13, MOVE_LEER
	db 19, MOVE_RAGE
	db 25, MOVE_BONEMERANG
	db 31, MOVE_CHARM
	db 37, MOVE_THRASH
	db 43, MOVE_FOCUS_ENERGY
	db 49, MOVE_BONE_LOCK
	db 0 ; no more level-up moves

MarowakEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_BONE_CLUB
	db  8, MOVE_GROWL
	db 15, MOVE_LEER
	db 22, MOVE_RAGE
	db 29, MOVE_BONEMERANG
	db 36, MOVE_CHARM
	db 43, MOVE_THRASH
	db 50, MOVE_FOCUS_ENERGY
	db 57, MOVE_BONE_LOCK
	db 0 ; no more level-up moves

HitmonleeEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_ROLLING_KICK
	db 11, MOVE_DOUBLE_KICK
	db 17, MOVE_MEDITATE
	db 23, MOVE_JUMP_KICK
	db 30, MOVE_DETECT
	db 37, MOVE_FORESIGHT
	db 45, MOVE_HI_JUMP_KICK
	db 53, MOVE_FOCUS_ENERGY
	db 62, MOVE_MEGA_KICK
	db 71, MOVE_REVERSAL
	db 0 ; no more level-up moves

HitmonchanEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_MACH_PUNCH
	db 15, MOVE_FIRE_PUNCH
	db 15, MOVE_THUNDERPUNCH
	db 15, MOVE_ICE_PUNCH
	db 23, MOVE_AGILITY
	db 31, MOVE_MEGA_PUNCH
	db 40, MOVE_MIND_READER
	db 49, MOVE_COUNTER
	db 59, MOVE_COMET_PUNCH
	db 69, MOVE_DYNAMICPUNCH
	db 0 ; no more level-up moves

LickitungEvosAttacks:
	db EVOLVE_LEVEL, 32, DEX_NAMEIL
	db 0 ; no more evolutions
	db  1, MOVE_LICK
	db  6, MOVE_SUPERSONIC
	db 12, MOVE_DISABLE
	db 19, MOVE_STOMP
	db 27, MOVE_WRAP
	db 36, MOVE_DEFENSE_CURL
	db 46, MOVE_SLAM
	db 57, MOVE_AMNESIA
	db 69, MOVE_SCREECH
	db 0 ; no more level-up moves

KoffingEvosAttacks:
	db EVOLVE_LEVEL, 35, DEX_WEEZING
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_SMOG
	db 16, MOVE_SLUDGE
	db 24, MOVE_SELFDESTRUCT
	db 32, MOVE_SMOKESCREEN
	db 40, MOVE_HAZE
	db 48, MOVE_SLUDGE
	db 56, MOVE_EXPLOSION
	db 0 ; no more level-up moves

WeezingEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  9, MOVE_SMOG
	db 18, MOVE_SLUDGE
	db 27, MOVE_SELFDESTRUCT
	db 36, MOVE_SMOKESCREEN
	db 45, MOVE_HAZE
	db 54, MOVE_SLUDGE_BOMB
	db 63, MOVE_EXPLOSION
	db 0 ; no more level-up moves

RhyhornEvosAttacks:
	db EVOLVE_LEVEL, 42, DEX_RHYDON
	db 0 ; no more evolutions
	db  1, MOVE_HORN_ATTACK
	db  8, MOVE_STOMP
	db 15, MOVE_LEER
	db 23, MOVE_FURY_ATTACK
	db 31, MOVE_ENDURE
	db 40, MOVE_HORN_DRILL
	db 49, MOVE_ROCK_HEAD
	db 59, MOVE_MUD_SLAP
	db 69, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

RhydonEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_HORN_ATTACK
	db  9, MOVE_STOMP
	db 17, MOVE_LEER
	db 26, MOVE_FURY_ATTACK
	db 35, MOVE_ENDURE
	db 45, MOVE_HORN_DRILL
	db 55, MOVE_ROCK_HEAD
	db 66, MOVE_MUD_SLAP
	db 77, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

ChanseyEvosAttacks:
	db EVOLVE_LEVEL, 45, DEX_HAPPI
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  5, MOVE_TAIL_WHIP
	db 10, MOVE_GROWL
	db 16, MOVE_DEFENSE_CURL
	db 23, MOVE_DOUBLESLAP
	db 31, MOVE_SING
	db 40, MOVE_MINIMIZE
	db 50, MOVE_LIGHT_SCREEN
	db 61, MOVE_DOUBLE_EDGE
	db 73, MOVE_PAIN_SPLIT
	db 0 ; no more level-up moves

TangelaEvosAttacks:
	db EVOLVE_LEVEL, 44, DEX_JARANRA
	db 0 ; no more evolutions
	db  1, MOVE_CONSTRICT
	db  6, MOVE_ABSORB
	db 12, MOVE_BIND
	db 19, MOVE_GROWTH
	db 27, MOVE_VINE_WHIP
	db 32, MOVE_SLEEP_POWDER
	db 36, MOVE_STUN_SPORE
	db 40, MOVE_POISONPOWDER
	db 46, MOVE_NIGHT_SHADE
	db 57, MOVE_SLAM
	db 0 ; no more level-up moves

KangaskhanEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_BITE
	db  8, MOVE_TAIL_WHIP
	db 15, MOVE_LEER
	db 22, MOVE_RAGE
	db 29, MOVE_DIZZY_PUNCH
	db 36, MOVE_PROTECT
	db 43, MOVE_MEGA_PUNCH
	db 50, MOVE_ENDURE
	db 57, MOVE_COMET_PUNCH
	db 0 ; no more level-up moves

HorseaEvosAttacks:
	db EVOLVE_LEVEL, 32, DEX_SEADRA
	db 0 ; no more evolutions
	db  1, MOVE_BUBBLE
	db  7, MOVE_SMOKESCREEN
	db 13, MOVE_LEER
	db 19, MOVE_WATER_GUN
	db 25, MOVE_QUICK_ATTACK
	db 31, MOVE_DRAGONBREATH
	db 37, MOVE_AGILITY
	db 43, MOVE_OCTAZOOKA
	db 49, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

SeadraEvosAttacks:
	db EVOLVE_ITEM, 1, ITEM_DRAGON_SCALE, DEX_KINGDRA
	db 0 ; no more evolutions
	db  1, MOVE_BUBBLE
	db  9, MOVE_SMOKESCREEN
	db 17, MOVE_LEER
	db 25, MOVE_WATER_GUN
	db 32, MOVE_PIN_MISSILE
	db 33, MOVE_QUICK_ATTACK
	db 41, MOVE_DRAGONBREATH
	db 49, MOVE_AGILITY
	db 57, MOVE_OCTAZOOKA
	db 65, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

GoldeenEvosAttacks:
	db EVOLVE_LEVEL, 33, DEX_SEAKING
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  4, MOVE_TAIL_WHIP
	db  8, MOVE_SUPERSONIC
	db 13, MOVE_FLAIL
	db 19, MOVE_HORN_ATTACK
	db 26, MOVE_FURY_ATTACK
	db 34, MOVE_HORN_DRILL
	db 43, MOVE_WATERFALL
	db 53, MOVE_AGILITY
	db 0 ; no more level-up moves

SeakingEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  5, MOVE_TAIL_WHIP
	db 10, MOVE_SUPERSONIC
	db 16, MOVE_FLAIL
	db 23, MOVE_HORN_ATTACK
	db 31, MOVE_FURY_ATTACK
	db 40, MOVE_HORN_DRILL
	db 50, MOVE_WATERFALL
	db 61, MOVE_AGILITY
	db 0 ; no more level-up moves

StaryuEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_WATER_STONE, DEX_STARMIE
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_WATER_GUN
	db 11, MOVE_HARDEN
	db 17, MOVE_RAPID_SPIN
	db 23, MOVE_MINIMIZE
	db 30, MOVE_SWIFT
	db 37, MOVE_SYNCHRONIZE
	db 45, MOVE_LIGHT_SCREEN
	db 53, MOVE_RECOVER
	db 62, MOVE_CONFUSE_RAY
	db 71, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

StarmieEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WATER_GUN
	db  1, MOVE_SWIFT
	db  1, MOVE_RECOVER
	db  1, MOVE_CONFUSE_RAY
	db 0 ; no more level-up moves

MrMimeEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_CONFUSION
	db  7, MOVE_BARRIER
	db 14, MOVE_ENCORE
	db 21, MOVE_DOUBLESLAP
	db 28, MOVE_LIGHT_SCREEN
	db 28, MOVE_REFLECT
	db 28, MOVE_SAFEGUARD
	db 35, MOVE_PSYBEAM
	db 42, MOVE_BATON_PASS
	db 49, MOVE_MEDITATE
	db 56, MOVE_SUBSTITUTE
	db 0 ; no more level-up moves

ScytherEvosAttacks:
	db EVOLVE_LEVEL, 41, DEX_SCISSORS
	db 0 ; no more evolutions
	db  1, MOVE_QUICK_ATTACK
	db  4, MOVE_LEER
	db  8, MOVE_FOCUS_ENERGY
	db 13, MOVE_DOUBLE_TEAM
	db 19, MOVE_SLASH
	db 26, MOVE_FALSE_SWIPE
	db 34, MOVE_PURSUIT
	db 43, MOVE_SWORDS_DANCE
	db 53, MOVE_FURY_CUTTER
	db 64, MOVE_AGILITY
	db 0 ; no more level-up moves

JynxEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  7, MOVE_SING
	db 14, MOVE_POWDER_SNOW
	db 21, MOVE_DOUBLESLAP
	db 28, MOVE_MEDITATE
	db 35, MOVE_ICE_PUNCH
	db 42, MOVE_LOVELY_KISS
	db 42, MOVE_SWEET_KISS
	db 49, MOVE_PERISH_SONG
	db 56, MOVE_BLIZZARD
	db 0 ; no more level-up moves

ElectabuzzEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_QUICK_ATTACK
	db  7, MOVE_LEER
	db 14, MOVE_THUNDER_WAVE
	db 21, MOVE_THUNDERSHOCK
	db 28, MOVE_SPARK
	db 35, MOVE_LIGHT_SCREEN
	db 42, MOVE_THUNDERPUNCH
	db 49, MOVE_SCREECH
	db 56, MOVE_THUNDER
	db 0 ; no more level-up moves

MagmarEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  7, MOVE_LEER
	db 14, MOVE_SMOG
	db 21, MOVE_EMBER
	db 28, MOVE_FLAME_WHEEL
	db 35, MOVE_FIRE_PUNCH
	db 42, MOVE_SMOKESCREEN
	db 49, MOVE_CONFUSE_RAY
	db 56, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

PinsirEvosAttacks:
	db EVOLVE_LEVEL, 42, DEX_PURAKKUSU
	db 0 ; no more evolutions
	db  1, MOVE_VICEGRIP
	db  6, MOVE_FOCUS_ENERGY
	db 12, MOVE_HARDEN
	db 19, MOVE_SEISMIC_TOSS
	db 27, MOVE_ENDURE
	db 36, MOVE_SLASH
	db 46, MOVE_CROSS_CUTTER
	db 57, MOVE_SWORDS_DANCE
	db 69, MOVE_GUILLOTINE
	db 0 ; no more level-up moves

TaurosEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_TAIL_WHIP
	db 16, MOVE_RAGE
	db 25, MOVE_LEER
	db 35, MOVE_STOMP
	db 46, MOVE_THRASH
	db 58, MOVE_SWAGGER
	db 71, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

MagikarpEvosAttacks:
	db EVOLVE_LEVEL, 20, DEX_GYARADOS
	db 0 ; no more evolutions
	db  1, MOVE_SPLASH
	db 15, MOVE_TACKLE
	db 30, MOVE_FLAIL
	db 0 ; no more level-up moves

GyaradosEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db 15, MOVE_BITE
	db 25, MOVE_LEER
	db 30, MOVE_DRAGON_RAGE
	db 40, MOVE_TWISTER
	db 55, MOVE_THRASH
	db 65, MOVE_HYDRO_PUMP
	db 70, MOVE_HYPER_BEAM
	db 0 ; no more level-up moves

LaprasEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WATER_GUN
	db  9, MOVE_GROWL
	db 17, MOVE_SING
	db 25, MOVE_BODY_SLAM
	db 33, MOVE_MIST
	db 33, MOVE_HAZE
	db 41, MOVE_ICE_BEAM
	db 49, MOVE_CONFUSE_RAY
	db 57, MOVE_PERISH_SONG
	db 65, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

DittoEvosAttacks:
	db EVOLVE_ITEM, 1, ITEM_METAL_COAT, DEX_ANIMON
	db 0 ; no more evolutions
	db  1, MOVE_TRANSFORM
	db 0 ; no more level-up moves

EeveeEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_WATER_STONE, DEX_VAPOREON
	db EVOLVE_STONE, 1, ITEM_THUNDERSTONE, DEX_JOLTEON
	db EVOLVE_STONE, 1, ITEM_FIRE_STONE, DEX_FLAREON
	db EVOLVE_STONE, 1, ITEM_HEART_STONE, DEX_EIFIE
	db EVOLVE_STONE, 1, ITEM_POISON_STONE, DEX_BLACKY
	db EVOLVE_STONE, 1, ITEM_LEAF_STONE, DEX_LEAFY
	; db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_BITE
	db 35, MOVE_MUD_SLAP
	db 42, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

VaporeonEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_WATER_GUN
	db 35, MOVE_BITE
	db 42, MOVE_ACID_ARMOR
	db 49, MOVE_HAZE
	db 56, MOVE_MIST
	db 63, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

JolteonEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_THUNDERSHOCK
	db 35, MOVE_THUNDER_WAVE
	db 42, MOVE_DOUBLE_KICK
	db 49, MOVE_AGILITY
	db 56, MOVE_PIN_MISSILE
	db 63, MOVE_THUNDER
	db 0 ; no more level-up moves

FlareonEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_EMBER
	db 35, MOVE_BITE
	db 42, MOVE_LEER
	db 49, MOVE_FIRE_SPIN
	db 56, MOVE_RAGE
	db 63, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

PorygonEvosAttacks:
	db EVOLVE_ITEM, 1, ITEM_UP_GRADE, DEX_PORYGON2
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_SHARPEN
	db 15, MOVE_CONVERSION
	db 15, MOVE_CONVERSION2
	db 22, MOVE_PSYBEAM
	db 29, MOVE_TRI_ATTACK
	db 36, MOVE_RECOVER
	db 43, MOVE_AGILITY
	db 50, MOVE_HYPER_BEAM
	db 0 ; no more level-up moves

OmanyteEvosAttacks:
	db EVOLVE_LEVEL, 40, DEX_OMASTAR
	db 0 ; no more evolutions
	db  1, MOVE_WATER_GUN
	db  7, MOVE_WITHDRAW
	db 14, MOVE_BIND
	db 22, MOVE_HORN_ATTACK
	db 31, MOVE_LEER
	db 41, MOVE_PROTECT
	db 52, MOVE_SPIKE_CANNON
	db 64, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

OmastarEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WATER_GUN
	db  8, MOVE_WITHDRAW
	db 16, MOVE_BIND
	db 25, MOVE_HORN_ATTACK
	db 35, MOVE_LEER
	db 46, MOVE_PROTECT
	db 58, MOVE_SPIKE_CANNON
	db 71, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

KabutoEvosAttacks:
	db EVOLVE_LEVEL, 40, DEX_KABUTOPS
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  7, MOVE_ABSORB
	db 14, MOVE_HARDEN
	db 22, MOVE_WATER_GUN
	db 31, MOVE_SLASH
	db 41, MOVE_LEER
	db 52, MOVE_FURY_CUTTER
	db 64, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

KabutopsEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  8, MOVE_ABSORB
	db 16, MOVE_HARDEN
	db 25, MOVE_WATER_GUN
	db 35, MOVE_SLASH
	db 46, MOVE_LEER
	db 58, MOVE_FURY_CUTTER
	db 71, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

AerodactylEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_GUST
	db  8, MOVE_SUPERSONIC
	db 16, MOVE_LEER
	db 25, MOVE_BITE
	db 35, MOVE_WING_ATTACK
	db 46, MOVE_AGILITY
	db 58, MOVE_TAKE_DOWN
	db 71, MOVE_HYPER_BEAM
	db 0 ; no more level-up moves

SnorlaxEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_HARDEN
	db 15, MOVE_HEADBUTT
	db 22, MOVE_AMNESIA
	db 29, MOVE_REST
	db 36, MOVE_BODY_SLAM
	db 43, MOVE_SNORE
	db 43, MOVE_SLEEP_TALK
	db 50, MOVE_BELLY_DRUM
	db 57, MOVE_DOUBLE_EDGE
	db 64, MOVE_PROTECT
	db 71, MOVE_HYPER_BEAM
	db 0 ; no more level-up moves

ArticunoEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db 10, MOVE_LEER
	db 20, MOVE_MIST
	db 30, MOVE_AURORA_BEAM
	db 40, MOVE_HAZE
	db 50, MOVE_SAFEGUARD
	db 60, MOVE_ICE_BEAM
	db 70, MOVE_AGILITY
	db 80, MOVE_BLIZZARD
	db 0 ; no more level-up moves

ZapdosEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db 10, MOVE_THUNDER_WAVE
	db 20, MOVE_THUNDERSHOCK
	db 30, MOVE_LEER
	db 40, MOVE_LIGHT_SCREEN
	db 50, MOVE_DRILL_PECK
	db 60, MOVE_AGILITY
	db 70, MOVE_THUNDER
	db 80, MOVE_SCARY_FACE
	db 0 ; no more level-up moves

MoltresEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db 10, MOVE_EMBER
	db 20, MOVE_LEER
	db 30, MOVE_FIRE_SPIN
	db 40, MOVE_DOUBLE_TEAM
	db 50, MOVE_SACRED_FIRE
	db 60, MOVE_AGILITY
	db 70, MOVE_SCARY_FACE
	db 80, MOVE_SKY_ATTACK
	db 0 ; no more level-up moves

DratiniEvosAttacks:
	db EVOLVE_LEVEL, 30, DEX_DRAGONAIR
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  3, MOVE_LEER
	db  6, MOVE_WRAP
	db 10, MOVE_WATER_GUN
	db 15, MOVE_THUNDER_WAVE
	db 21, MOVE_DRAGON_RAGE
	db 28, MOVE_TWISTER
	db 36, MOVE_AGILITY
	db 45, MOVE_SLAM
	db 55, MOVE_OUTRAGE
	db 66, MOVE_HYPER_BEAM
	db 0 ; no more level-up moves

DragonairEvosAttacks:
	db EVOLVE_LEVEL, 55, DEX_DRAGONITE
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  4, MOVE_LEER
	db  8, MOVE_WRAP
	db 13, MOVE_WATER_GUN
	db 19, MOVE_THUNDER_WAVE
	db 26, MOVE_DRAGON_RAGE
	db 34, MOVE_TWISTER
	db 43, MOVE_AGILITY
	db 53, MOVE_SLAM
	db 64, MOVE_OUTRAGE
	db 76, MOVE_HYPER_BEAM
	db 0 ; no more level-up moves

DragoniteEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  5, MOVE_LEER
	db 10, MOVE_WRAP
	db 16, MOVE_WATER_GUN
	db 23, MOVE_THUNDER_WAVE
	db 31, MOVE_DRAGON_RAGE
	db 40, MOVE_TWISTER
	db 50, MOVE_AGILITY
	db 61, MOVE_SLAM
	db 73, MOVE_OUTRAGE
	db 86, MOVE_HYPER_BEAM
	db 0 ; no more level-up moves

MewtwoEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_CONFUSION
	db  8, MOVE_DISABLE
	db 16, MOVE_MIST
	db 25, MOVE_SWIFT
	db 35, MOVE_PSYBEAM
	db 46, MOVE_RECOVER
	db 58, MOVE_SAFEGUARD
	db 71, MOVE_BARRIER
	db 85, MOVE_PSYCHIC
	db 100, MOVE_AMNESIA
	db 0 ; no more level-up moves

MewEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  1, MOVE_TRANSFORM
	db  1, MOVE_METRONOME
	db 0 ; no more level-up moves

HappaEvosAttacks:
	; db EVOLVE_LEVEL, 16, DEX_HANAMOGURA
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  3, MOVE_GROWTH
	db  6, MOVE_LEECH_SEED
	db 10, MOVE_RAZOR_LEAF
	db 15, MOVE_STUN_SPORE
	db 21, MOVE_SLEEP_POWDER
	db 28, MOVE_SLAM
	db 36, MOVE_POISONPOWDER
	db 45, MOVE_MORNING_SUN
	db 55, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

HanamoguraEvosAttacks:
	db EVOLVE_LEVEL, 32, DEX_HANARYU
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  4, MOVE_GROWTH
	db  8, MOVE_LEECH_SEED
	db 13, MOVE_RAZOR_LEAF
	db 19, MOVE_STUN_SPORE
	db 26, MOVE_SLEEP_POWDER
	db 34, MOVE_SLAM
	db 43, MOVE_POISONPOWDER
	db 53, MOVE_MORNING_SUN
	db 64, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

HanaryuEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  5, MOVE_GROWTH
	db 10, MOVE_LEECH_SEED
	db 16, MOVE_RAZOR_LEAF
	db 23, MOVE_STUN_SPORE
	db 31, MOVE_SLEEP_POWDER
	db 40, MOVE_SLAM
	db 50, MOVE_POISONPOWDER
	db 61, MOVE_MORNING_SUN
	db 73, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

HonogumaEvosAttacks:
	; db EVOLVE_LEVEL, 16, DEX_VOLBEAR
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  5, MOVE_LEER
	db  9, MOVE_EMBER
	db 14, MOVE_ROAR
	db 19, MOVE_BITE
	db 25, MOVE_REST
	db 31, MOVE_FLAME_WHEEL
	db 38, MOVE_SCARY_FACE
	db 45, MOVE_FURY_SWIPES
	db 53, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

VolbearEvosAttacks:
	db EVOLVE_LEVEL, 32, DEX_DYNABEAR
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  6, MOVE_LEER
	db 11, MOVE_ROAR
	db 17, MOVE_EMBER
	db 23, MOVE_BITE
	db 30, MOVE_REST
	db 37, MOVE_FLAME_WHEEL
	db 45, MOVE_SCARY_FACE
	db 53, MOVE_FURY_SWIPES
	db 62, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

DynabearEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  7, MOVE_LEER
	db 13, MOVE_ROAR
	db 20, MOVE_EMBER
	db 27, MOVE_BITE
	db 35, MOVE_REST
	db 43, MOVE_FLAME_WHEEL
	db 52, MOVE_SCARY_FACE
	db 61, MOVE_FURY_SWIPES
	db 71, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

KurusuEvosAttacks:
	; db EVOLVE_LEVEL, 16, DEX_AQUA
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  4, MOVE_GROWL
	db  8, MOVE_WATER_GUN
	db 13, MOVE_BITE
	db 19, MOVE_MIST
	db 26, MOVE_AURORA_BEAM
	db 34, MOVE_SAFEGUARD
	db 43, MOVE_BODY_SLAM
	db 53, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

AquaEvosAttacks:
	db EVOLVE_LEVEL, 32, DEX_AQUARIA
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  5, MOVE_GROWL
	db 10, MOVE_WATER_GUN
	db 16, MOVE_BITE
	db 23, MOVE_MIST
	db 31, MOVE_AURORA_BEAM
	db 40, MOVE_SAFEGUARD
	db 50, MOVE_BODY_SLAM
	db 61, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

AquariaEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_GROWL
	db 12, MOVE_WATER_GUN
	db 19, MOVE_BITE
	db 27, MOVE_MIST
	db 36, MOVE_AURORA_BEAM
	db 46, MOVE_SAFEGUARD
	db 57, MOVE_BODY_SLAM
	db 69, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

HohoEvosAttacks:
	; db EVOLVE_LEVEL, 20, DEX_BOBO
	db 0 ; no more evolutions
	db  1, MOVE_GROWL
	db  3, MOVE_TACKLE
	db  6, MOVE_FORESIGHT
	db 10, MOVE_HYPNOSIS
	db 15, MOVE_WING_ATTACK
	db 21, MOVE_MEGAPHONE
	db 28, MOVE_MOONLIGHT
	db 36, MOVE_TAKE_DOWN
	db 45, MOVE_STALKER
	db 0 ; no more level-up moves

BoboEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_GROWL
	db  4, MOVE_TACKLE
	db  8, MOVE_FORESIGHT
	db 13, MOVE_HYPNOSIS
	db 19, MOVE_WING_ATTACK
	db 26, MOVE_MEGAPHONE
	db 35, MOVE_MOONLIGHT
	db 46, MOVE_TAKE_DOWN
	db 59, MOVE_STALKER
	db 0 ; no more level-up moves

PachimeeEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_MOKOKO
	db 0 ; no more evolutions
	db  1, MOVE_THUNDERSHOCK
	db  3, MOVE_GROWL
	db  6, MOVE_TAIL_WHIP
	db 10, MOVE_HYPNOSIS
	db 15, MOVE_SWIFT
	db 21, MOVE_COTTON_SPORE
	db 28, MOVE_SCREECH
	db 36, MOVE_LIGHT_SCREEN
	db 45, MOVE_THUNDERBOLT
	db 0 ; no more level-up moves

MokokoEvosAttacks:
	db EVOLVE_LEVEL, 32, DEX_DENRYU
	db 0 ; no more evolutions
	db  1, MOVE_THUNDERSHOCK
	db  4, MOVE_GROWL
	db  8, MOVE_TAIL_WHIP
	db 13, MOVE_HYPNOSIS
	db 19, MOVE_SWIFT
	db 26, MOVE_COTTON_SPORE
	db 34, MOVE_SCREECH
	db 43, MOVE_LIGHT_SCREEN
	db 53, MOVE_THUNDERBOLT
	db 0 ; no more level-up moves

DenryuEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_THUNDERSHOCK
	db  5, MOVE_GROWL
	db 10, MOVE_TAIL_WHIP
	db 16, MOVE_HYPNOSIS
	db 23, MOVE_SWIFT
	db 31, MOVE_COTTON_SPORE
	db 32, MOVE_THUNDERPUNCH
	db 40, MOVE_SCREECH
	db 50, MOVE_LIGHT_SCREEN
	db 61, MOVE_THUNDERBOLT
	db 0 ; no more level-up moves

MikonEvosAttacks:
	db EVOLVE_LEVEL, 13, DEX_VULPIX
	db 0 ; no more evolutions
	db  1, MOVE_TAIL_WHIP
	db  4, MOVE_QUICK_ATTACK
	db  7, MOVE_ROAR
	db 11, MOVE_EMBER
	db 15, MOVE_FORESIGHT
	db 20, MOVE_FIRE_SPIN
	db 25, MOVE_CONFUSE_RAY
	db 31, MOVE_DOUBLE_TEAM
	db 37, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

MonjaEvosAttacks:
	db EVOLVE_LEVEL, 22, DEX_TANGELA
	db 0 ; no more evolutions
	db  1, MOVE_CONSTRICT
	db  4, MOVE_ABSORB
	db  8, MOVE_BIND
	db 13, MOVE_GROWTH
	db 19, MOVE_VINE_WHIP
	db 23, MOVE_SLEEP_POWDER
	db 26, MOVE_STUN_SPORE
	db 29, MOVE_POISONPOWDER
	db 34, MOVE_NIGHT_SHADE
	db 43, MOVE_SLAM
	db 0 ; no more level-up moves

JaranraEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_CONSTRICT
	db  7, MOVE_ABSORB
	db 14, MOVE_BIND
	db 22, MOVE_GROWTH
	db 31, MOVE_VINE_WHIP
	db 36, MOVE_SLEEP_POWDER
	db 41, MOVE_STUN_SPORE
	db 46, MOVE_POISONPOWDER
	db 52, MOVE_NIGHT_SHADE
	db 64, MOVE_SLAM
	db 0 ; no more level-up moves

HaneeiEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db 10, MOVE_WATER_GUN
	db 19, MOVE_FLAIL
	db 29, MOVE_CONFUSE_RAY
	db 39, MOVE_THRASH
	db 50, MOVE_SLAM
	db 61, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

PukuEvosAttacks:
	db EVOLVE_LEVEL, 18, DEX_SHIBIREFUGU
	db 0 ; no more evolutions
	db  1, MOVE_POISON_STING
	db  6, MOVE_TAIL_WHIP
	db 12, MOVE_WATER_GUN
	db 19, MOVE_SELFDESTRUCT
	db 27, MOVE_THUNDER_WAVE
	db 36, MOVE_PIN_MISSILE
	db 46, MOVE_SMOKESCREEN
	db 57, MOVE_EXPLOSION
	db 0 ; no more level-up moves

ShibirefuguEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POISON_STING
	db  7, MOVE_TAIL_WHIP
	db 14, MOVE_WATER_GUN
	db 22, MOVE_SELFDESTRUCT
	db 31, MOVE_THUNDER_WAVE
	db 41, MOVE_PIN_MISSILE
	db 52, MOVE_SMOKESCREEN
	db 64, MOVE_EXPLOSION
	db 0 ; no more level-up moves

PichuEvosAttacks:
	db EVOLVE_LEVEL, 12, DEX_PIKACHU
	db 0 ; no more evolutions
	db  1, MOVE_CHARM
	db  3, MOVE_THUNDERSHOCK
	db  6, MOVE_TAIL_WHIP
	db 10, MOVE_THUNDER_WAVE
	db 15, MOVE_QUICK_ATTACK
	db 21, MOVE_SWIFT
	db 28, MOVE_SPARK
	db 36, MOVE_AGILITY
	db 45, MOVE_THUNDER
	db 0 ; no more level-up moves

PyEvosAttacks:
	db EVOLVE_LEVEL, 12, DEX_CLEFAIRY
	db 0 ; no more evolutions
	db  1, MOVE_CHARM
	db  2, MOVE_POUND
	db  4, MOVE_SING
	db  7, MOVE_DEFENSE_CURL
	db 11, MOVE_DOUBLESLAP
	db 16, MOVE_MINIMIZE
	db 22, MOVE_METRONOME
	db 29, MOVE_LIGHT_SCREEN
	db 37, MOVE_MIMIC
	db 46, MOVE_MOONLIGHT
	db 0 ; no more level-up moves

PupurinEvosAttacks:
	db EVOLVE_LEVEL, 12, DEX_JIGGLYPUFF
	db 0 ; no more evolutions
	db  1, MOVE_CHARM
	db  4, MOVE_SING
	db  8, MOVE_POUND
	db 12, MOVE_DISABLE
	db 16, MOVE_DEFENSE_CURL
	db 20, MOVE_DOUBLESLAP
	db 24, MOVE_REST
	db 28, MOVE_BODY_SLAM
	db 32, MOVE_PAIN_SPLIT
	db 36, MOVE_PERISH_SONG
	db 40, MOVE_DOUBLE_EDGE
	db 0 ; no more level-up moves

MizuuoEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  7, MOVE_DEFENSE_CURL
	db 13, MOVE_WATER_GUN
	db 19, MOVE_RAIN_DANCE
	db 25, MOVE_DOUBLESLAP
	db 31, MOVE_MUD_SLAP
	db 37, MOVE_REST
	db 43, MOVE_SNORE
	db 49, MOVE_SLAM
	db 0 ; no more level-up moves

NatyEvosAttacks:
	db EVOLVE_STONE, 1, ITEM_HEART_STONE, DEX_NATIO
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  6, MOVE_CONFUSION
	db 12, MOVE_STALKER
	db 18, MOVE_SPITE
	db 24, MOVE_QUICK_ATTACK
	db 30, MOVE_PSYBEAM
	db 36, MOVE_PURSUIT
	db 42, MOVE_SYNCHRONIZE
	db 48, MOVE_DRILL_PECK
	db 0 ; no more level-up moves

NatioEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  1, MOVE_STALKER
	db  1, MOVE_SPITE
	db  1, MOVE_PSYBEAM
	db 0 ; no more level-up moves

GyopinEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_GOLDEEN
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  3, MOVE_TAIL_WHIP
	db  6, MOVE_SUPERSONIC
	db 10, MOVE_FLAIL
	db 15, MOVE_HORN_ATTACK
	db 21, MOVE_FURY_ATTACK
	db 28, MOVE_HORN_DRILL
	db 36, MOVE_WATERFALL
	db 45, MOVE_AGILITY
	db 0 ; no more level-up moves

MarilEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  6, MOVE_TAIL_WHIP
	db 12, MOVE_DEFENSE_CURL
	db 19, MOVE_WATER_GUN
	db 0 ; no more level-up moves

Manbo1EvosAttacks:
	db EVOLVE_LEVEL, 19, DEX_IKARI
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  5, MOVE_LEER
	db 10, MOVE_RAGE
	db 15, MOVE_WATER_GUN
	db 20, MOVE_SLAM
	db 25, MOVE_DOUBLE_TEAM
	db 30, MOVE_SCARY_FACE
	db 35, MOVE_THRASH
	db 40, MOVE_IRON_TAIL
	db 45, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

IkariEvosAttacks:
	db EVOLVE_LEVEL, 38, DEX_GROTESS
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_LEER
	db 12, MOVE_RAGE
	db 18, MOVE_WATER_GUN
	db 24, MOVE_SLAM
	db 30, MOVE_DOUBLE_TEAM
	db 36, MOVE_SCARY_FACE
	db 42, MOVE_THRASH
	db 48, MOVE_IRON_TAIL
	db 54, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

GrotessEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_LEER
	db 14, MOVE_RAGE
	db 21, MOVE_WATER_GUN
	db 28, MOVE_SLAM
	db 35, MOVE_DOUBLE_TEAM
	db 43, MOVE_SCARY_FACE
	db 49, MOVE_THRASH
	db 56, MOVE_IRON_TAIL
	db 63, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

EksingEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_LEECH_LIFE
	db  9, MOVE_SUPERSONIC
	db 18, MOVE_BITE
	db 27, MOVE_HAZE
	db 36, MOVE_SCREECH
	db 44, MOVE_MOONLIGHT
	db 45, MOVE_STALKER
	db 54, MOVE_WING_ATTACK
	db 63, MOVE_CONFUSE_RAY
	db 0 ; no more level-up moves

ParaEvosAttacks:
	db EVOLVE_LEVEL, 12, DEX_PARAS
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  3, MOVE_STUN_SPORE
	db  6, MOVE_LEECH_LIFE
	db 10, MOVE_POISONPOWDER
	db 15, MOVE_GROWTH
	db 21, MOVE_FURY_SWIPES
	db 28, MOVE_SLASH
	db 36, MOVE_SPORE
	db 0 ; no more level-up moves

KokumoEvosAttacks:
	db EVOLVE_LEVEL, 23, DEX_TWOHEAD
	db 0 ; no more evolutions
	db  1, MOVE_LEECH_LIFE
	db  4, MOVE_STRING_SHOT
	db  8, MOVE_POISON_STING
	db 13, MOVE_CONFUSION
	db 19, MOVE_BIND
	db 26, MOVE_BITE
	db 34, MOVE_SPIDER_WEB
	db 43, MOVE_NIGHT_SHADE
	db 53, MOVE_PSYCHIC
	db 0 ; no more level-up moves

TwoheadEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_LEECH_LIFE
	db  5, MOVE_STRING_SHOT
	db 10, MOVE_POISON_STING
	db 16, MOVE_CONFUSION
	db 23, MOVE_BIND
	db 31, MOVE_BITE
	db 40, MOVE_SPIDER_WEB
	db 50, MOVE_NIGHT_SHADE
	db 61, MOVE_PSYCHIC
	db 0 ; no more level-up moves

YoroidoriEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  8, MOVE_LEER
	db 15, MOVE_HARDEN
	db 22, MOVE_STEEL_WING
	db 29, MOVE_WHIRLWIND
	db 36, MOVE_MUD_SLAP
	db 43, MOVE_PROTECT
	db 50, MOVE_DRILL_PECK
	db 57, MOVE_AGILITY
	db 0 ; no more level-up moves

AnimonEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TRANSFORM
	db 0 ; no more level-up moves

HinazuEvosAttacks:
	db EVOLVE_LEVEL, 16, DEX_DODUO
	db 0 ; no more evolutions
	db  1, MOVE_GROWL
	db  5, MOVE_PECK
	db  9, MOVE_QUICK_ATTACK
	db 14, MOVE_RAGE
	db 19, MOVE_PURSUIT
	db 25, MOVE_FURY_ATTACK
	db 31, MOVE_AGILITY
	db 38, MOVE_TRI_ATTACK
	db 45, MOVE_DRILL_PECK
	db 0 ; no more level-up moves

SunnyEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_ABSORB
	db  7, MOVE_SING
	db 13, MOVE_LEECH_SEED
	db 20, MOVE_GROWTH
	db 27, MOVE_RAZOR_LEAF
	db 35, MOVE_ENCORE
	db 43, MOVE_MORNING_SUN
	db 52, MOVE_PETAL_DANCE
	db 61, MOVE_SOLARBEAM
	db 0 ; no more level-up moves

PaonEvosAttacks:
	db EVOLVE_LEVEL, 33, DEX_DONPHAN
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_DEFENSE_CURL
	db 15, MOVE_STOMP
	db 22, MOVE_ENDURE
	db 29, MOVE_PROTECT
	db 36, MOVE_SLAM
	db 43, MOVE_SCARY_FACE
	db 50, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

DonphanEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  9, MOVE_DEFENSE_CURL
	db 17, MOVE_STOMP
	db 25, MOVE_ENDURE
	db 33, MOVE_PROTECT
	db 33, MOVE_HORN_DRILL
	db 41, MOVE_SLAM
	db 49, MOVE_SCARY_FACE
	db 57, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

TwinzEvosAttacks:
	db EVOLVE_LEVEL, 29, DEX_KIRINRIKI
	db 0 ; no more evolutions
	db  1, MOVE_DOUBLE_KICK
	db  6, MOVE_GROWL
	db 11, MOVE_SAND_ATTACK
	db 0 ; no more level-up moves

KirinrikiEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_DOUBLE_KICK
	db  6, MOVE_GROWL
	db 11, MOVE_SAND_ATTACK
	db 0 ; no more level-up moves

PainterEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SKETCH
	db 10, MOVE_SKETCH
	db 20, MOVE_SKETCH
	db 30, MOVE_SKETCH
	db 40, MOVE_SKETCH
	db 50, MOVE_SKETCH
	db 60, MOVE_SKETCH
	db 70, MOVE_SKETCH
	db 80, MOVE_SKETCH
	db 90, MOVE_SKETCH
	db 100, MOVE_SKETCH
	db 0 ; no more level-up moves

KounyaEvosAttacks:
	db EVOLVE_LEVEL, 14, DEX_MEOWTH
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  4, MOVE_GROWL
	db  7, MOVE_TAIL_WHIP
	db 11, MOVE_SAND_ATTACK
	db 15, MOVE_PAY_DAY
	db 20, MOVE_BITE
	db 25, MOVE_FURY_SWIPES
	db 31, MOVE_THIEF
	db 37, MOVE_SCREECH
	db 44, MOVE_SLASH
	db 51, MOVE_COIN_HURL
	db 0 ; no more level-up moves

RinrinEvosAttacks:
	db EVOLVE_LEVEL, 28, DEX_BERURUN
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  4, MOVE_GROWL
	db  8, MOVE_TAIL_WHIP
	db 13, MOVE_BELL_CHIME
	db 19, MOVE_FAINT_ATTACK
	db 26, MOVE_SCREECH
	db 34, MOVE_LOVELY_KISS
	db 34, MOVE_SWEET_KISS
	db 43, MOVE_FURY_SWIPES
	db 53, MOVE_ATTRACT
	db 0 ; no more level-up moves

BerurunEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  5, MOVE_GROWL
	db 10, MOVE_TAIL_WHIP
	db 16, MOVE_BELL_CHIME
	db 23, MOVE_FAINT_ATTACK
	db 31, MOVE_SCREECH
	db 40, MOVE_LOVELY_KISS
	db 40, MOVE_SWEET_KISS
	db 50, MOVE_FURY_SWIPES
	db 61, MOVE_ATTRACT
	db 0 ; no more level-up moves

NyorotonoEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_HYPNOSIS
	db  1, MOVE_WATER_GUN
	db  1, MOVE_DOUBLESLAP
	db 0 ; no more level-up moves

YadokingEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_CONFUSION
	db  9, MOVE_DISABLE
	db 18, MOVE_GROWL
	db 28, MOVE_WATER_GUN
	db 37, MOVE_WITHDRAW
	db 37, MOVE_SWAGGER
	db 39, MOVE_HEADBUTT
	db 51, MOVE_AMNESIA
	db 64, MOVE_PSYCHIC
	db 0 ; no more level-up moves

AnnonEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PSYWAVE
	db 0 ; no more level-up moves

RedibaEvosAttacks:
	; db EVOLVE_LEVEL, 18, DEX_MITSUBOSHI
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  8, MOVE_QUICK_ATTACK
	db 16, MOVE_SWIFT
	db 24, MOVE_REFLECT
	db 32, MOVE_AGILITY
	db 40, MOVE_FURY_SWIPES
	db 48, MOVE_DOUBLE_TEAM
	db 56, MOVE_TRI_ATTACK
	db 0 ; no more level-up moves

MitsuboshiEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_AGILITY
	db  1, MOVE_QUICK_ATTACK
	db  1, MOVE_BITE
	db 0 ; no more level-up moves

PuchicornEvosAttacks:
	db EVOLVE_LEVEL, 20, DEX_PONYTA
	db 0 ; no more evolutions
	db  1, MOVE_TAIL_WHIP
	db  7, MOVE_EMBER
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_GROWL
	db 28, MOVE_STOMP
	db 35, MOVE_FLAME_WHEEL
	db 42, MOVE_AGILITY
	db 49, MOVE_FIRE_SPIN
	db 56, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

EifieEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_CONFUSION
	db 35, MOVE_BITE
	db 42, MOVE_AGILITY
	db 49, MOVE_REFLECT
	db 56, MOVE_LIGHT_SCREEN
	db 63, MOVE_PSYCHIC
	db 0 ; no more level-up moves

BlackyEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_SMOG
	db 35, MOVE_ACID
	db 42, MOVE_ACID_ARMOR
	db 49, MOVE_SLUDGE
	db 56, MOVE_SMOKESCREEN
	db 63, MOVE_SLUDGE_BOMB
	db 0 ; no more level-up moves

TurbanEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_HARDEN
	db  1, MOVE_BODY_SLAM
	db  1, MOVE_WATER_GUN
	db 0 ; no more level-up moves

BetbabyEvosAttacks:
	db EVOLVE_LEVEL, 19, DEX_GRIMER
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  2, MOVE_POISON_GAS
	db  4, MOVE_DISABLE
	db  7, MOVE_ACID
	db 11, MOVE_MINIMIZE
	db 16, MOVE_HARDEN
	db 22, MOVE_SLUDGE
	db 29, MOVE_HAZE
	db 37, MOVE_SCREECH
	db 46, MOVE_ACID_ARMOR
	db 56, MOVE_SLUDGE_BOMB
	db 0 ; no more level-up moves

TeppouoEvosAttacks:
	db EVOLVE_LEVEL, 34, DEX_OKUTANK
	db 0 ; no more evolutions
	db  1, MOVE_WATER_GUN
	db 10, MOVE_FOCUS_ENERGY
	db 31, MOVE_AURORA_BEAM
	db 31, MOVE_PSYBEAM
	db 31, MOVE_BUBBLEBEAM
	db 56, MOVE_LOCK_ON
	db 70, MOVE_ZAP_CANNON
	db 0 ; no more level-up moves

OkutankEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WATER_GUN
	db 10, MOVE_FOCUS_ENERGY
	db 20, MOVE_OCTAZOOKA
	db 31, MOVE_WRAP
	db 43, MOVE_PROTECT
	db 56, MOVE_LOCK_ON
	db 70, MOVE_ZAP_CANNON
	db 0 ; no more level-up moves

GonguEvosAttacks:
	db EVOLVE_LEVEL, 15, DEX_HITMONLEE
	db EVOLVE_LEVEL, 15, DEX_HITMONCHAN
	db EVOLVE_LEVEL, 15, DEX_KAPOERER
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db 0 ; no more level-up moves

KapoererEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_LEER
	db 13, MOVE_RAPID_SPIN
	db 20, MOVE_PURSUIT
	db 27, MOVE_MEDITATE
	db 35, MOVE_ROLLING_KICK
	db 43, MOVE_DETECT
	db 52, MOVE_MIND_READER
	db 61, MOVE_TRIPLE_KICK
	db 71, MOVE_FOCUS_ENERGY
	db 0 ; no more level-up moves

PudieEvosAttacks:
	db EVOLVE_LEVEL, 13, DEX_GROWLITHE
	db 0 ; no more evolutions
	db  1, MOVE_EMBER
	db  5, MOVE_ROAR
	db  9, MOVE_QUICK_ATTACK
	db 14, MOVE_BITE
	db 19, MOVE_LEER
	db 25, MOVE_SACRED_FIRE
	db 31, MOVE_TAKE_DOWN
	db 38, MOVE_AGILITY
	db 45, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

HanekoEvosAttacks:
	; db EVOLVE_LEVEL, 18, DEX_POPONEKO
	db 0 ; no more evolutions
	db  1, MOVE_ABSORB
	db  4, MOVE_POUND
	db  8, MOVE_GROWTH
	db 13, MOVE_LEECH_SEED
	db 19, MOVE_RAZOR_LEAF
	db 26, MOVE_COTTON_SPORE
	db 34, MOVE_SLAM
	db 43, MOVE_SYNTHESIS
	db 53, MOVE_MEGA_DRAIN
	db 0 ; no more level-up moves

PoponekoEvosAttacks:
	db EVOLVE_LEVEL, 40, DEX_WATANEKO
	db 0 ; no more evolutions
	db  1, MOVE_ABSORB
	db  5, MOVE_POUND
	db 10, MOVE_GROWTH
	db 16, MOVE_LEECH_SEED
	db 23, MOVE_RAZOR_LEAF
	db 31, MOVE_COTTON_SPORE
	db 40, MOVE_SLAM
	db 50, MOVE_SYNTHESIS
	db 61, MOVE_MEGA_DRAIN
	db 0 ; no more level-up moves

WatanekoEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_ABSORB
	db  6, MOVE_POUND
	db 12, MOVE_GROWTH
	db 19, MOVE_LEECH_SEED
	db 27, MOVE_RAZOR_LEAF
	db 36, MOVE_COTTON_SPORE
	db 46, MOVE_SLAM
	db 57, MOVE_SYNTHESIS
	db 69, MOVE_MEGA_DRAIN
	db 0 ; no more level-up moves

BaririnaEvosAttacks:
	db EVOLVE_LEVEL, 15, DEX_MRMIME
	db 0 ; no more evolutions
	db  1, MOVE_CONFUSION
	db  6, MOVE_BARRIER
	db 12, MOVE_ENCORE
	db 18, MOVE_DOUBLESLAP
	db 24, MOVE_LIGHT_SCREEN
	db 24, MOVE_REFLECT
	db 24, MOVE_SAFEGUARD
	db 30, MOVE_PSYBEAM
	db 36, MOVE_BATON_PASS
	db 42, MOVE_MEDITATE
	db 48, MOVE_SUBSTITUTE
	db 0 ; no more level-up moves

LipEvosAttacks:
	db EVOLVE_LEVEL, 15, DEX_JYNX
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  6, MOVE_SING
	db 12, MOVE_POWDER_SNOW
	db 18, MOVE_DOUBLESLAP
	db 24, MOVE_MEDITATE
	db 30, MOVE_ICE_PUNCH
	db 36, MOVE_LOVELY_KISS
	db 36, MOVE_SWEET_KISS
	db 42, MOVE_PERISH_SONG
	db 48, MOVE_BLIZZARD
	db 0 ; no more level-up moves

ElebabyEvosAttacks:
	db EVOLVE_LEVEL, 15, DEX_ELECTABUZZ
	db 0 ; no more evolutions
	db  1, MOVE_QUICK_ATTACK
	db  6, MOVE_LEER
	db 12, MOVE_THUNDER_WAVE
	db 18, MOVE_THUNDERSHOCK
	db 24, MOVE_SPARK
	db 30, MOVE_LIGHT_SCREEN
	db 36, MOVE_THUNDERPUNCH
	db 42, MOVE_SCREECH
	db 48, MOVE_THUNDER
	db 0 ; no more level-up moves

BoobyEvosAttacks:
	db EVOLVE_LEVEL, 15, DEX_MAGMAR
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  6, MOVE_LEER
	db 12, MOVE_SMOG
	db 18, MOVE_EMBER
	db 24, MOVE_FLAME_WHEEL
	db 30, MOVE_FIRE_PUNCH
	db 36, MOVE_SMOKESCREEN
	db 42, MOVE_CONFUSE_RAY
	db 48, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

KireihanaEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_ABSORB
	db  1, MOVE_STUN_SPORE
	db  1, MOVE_ACID
	db  1, MOVE_PETAL_DANCE
	db 0 ; no more level-up moves

TsubomittoEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WRAP
	db  1, MOVE_POISONPOWDER
	db  1, MOVE_ACID
	db  1, MOVE_RAZOR_LEAF
	db 0 ; no more level-up moves

MiltankEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_TAIL_WHIP
	db 16, MOVE_BIDE
	db 25, MOVE_CHARM
	db 35, MOVE_STOMP
	db 46, MOVE_BODY_SLAM
	db 58, MOVE_MILK_DRINK
	db 71, MOVE_TAKE_DOWN
	db 0 ; no more level-up moves

BombseekerEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  9, MOVE_TAIL_WHIP
	db 17, MOVE_WATER_GUN
	db 25, MOVE_BARRAGE
	db 33, MOVE_FLAME_WHEEL
	db 41, MOVE_SMOG
	db 49, MOVE_TAKE_DOWN
	db 57, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

GiftEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  9, MOVE_GROWL
	db 18, MOVE_POWDER_SNOW
	db 27, MOVE_PRESENT
	db 36, MOVE_DOUBLESLAP
	db 45, MOVE_ENCORE
	db 54, MOVE_BLIZZARD
	db 0 ; no more level-up moves

KotoraEvosAttacks:
	db EVOLVE_LEVEL, 35, DEX_RAITORA
	db 0 ; no more evolutions
	db  1, MOVE_THUNDERSHOCK
	db  6, MOVE_LEER
	db 11, MOVE_ROAR
	db 17, MOVE_QUICK_ATTACK
	db 23, MOVE_PURSUIT
	db 30, MOVE_BITE
	db 37, MOVE_SCARY_FACE
	db 45, MOVE_THUNDER
	db 53, MOVE_AGILITY
	db 0 ; no more level-up moves

RaitoraEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_THUNDERSHOCK
	db  7, MOVE_LEER
	db 13, MOVE_ROAR
	db 20, MOVE_QUICK_ATTACK
	db 27, MOVE_PURSUIT
	db 35, MOVE_BITE
	db 43, MOVE_SCARY_FACE
	db 52, MOVE_THUNDER
	db 61, MOVE_AGILITY
	db 0 ; no more level-up moves

MadameEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  7, MOVE_SAND_ATTACK
	db 13, MOVE_LEER
	db 19, MOVE_FURY_ATTACK
	db 25, MOVE_WING_ATTACK
	db 31, MOVE_SWORDS_DANCE
	db 37, MOVE_FALSE_SWIPE
	db 43, MOVE_AGILITY
	db 49, MOVE_SLASH
	db 55, MOVE_FURY_CUTTER
	db 0 ; no more level-up moves

NorowaraEvosAttacks:
	db EVOLVE_LEVEL, 1, DEX_KYONPAN
	db 0 ; no more evolutions
	db  1, MOVE_LEECH_LIFE
	db  8, MOVE_DISABLE
	db 16, MOVE_DESTINY_BOND
	db 25, MOVE_SPITE
	db 35, MOVE_CONFUSION
	db 46, MOVE_NIGHT_SHADE
	db 58, MOVE_SUBSTITUTE
	db 71, MOVE_PSYCHIC
	db 85, MOVE_PAIN_SPLIT
	db 100, MOVE_NAIL_DOWN
	db 0 ; no more level-up moves

KyonpanEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_LEECH_LIFE
	db  8, MOVE_DISABLE
	db 16, MOVE_SPLASH
	db 25, MOVE_SPITE
	db 35, MOVE_STOMP
	db 46, MOVE_NIGHT_SHADE
	db 58, MOVE_SUBSTITUTE
	db 71, MOVE_BODY_SLAM
	db 85, MOVE_PAIN_SPLIT
	db 100, MOVE_CONFUSE_RAY
	db 0 ; no more level-up moves

YamikarasuEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  6, MOVE_SAND_ATTACK
	db 12, MOVE_SPIKES
	db 19, MOVE_DETECT
	db 27, MOVE_FORESIGHT
	db 36, MOVE_FAINT_ATTACK
	db 46, MOVE_FURY_ATTACK
	db 57, MOVE_STALKER
	db 69, MOVE_PERISH_SONG
	db 0 ; no more level-up moves

HappiEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_POUND
	db  6, MOVE_TAIL_WHIP
	db 12, MOVE_GROWL
	db 19, MOVE_DEFENSE_CURL
	db 27, MOVE_DOUBLESLAP
	db 36, MOVE_SING
	db 46, MOVE_MINIMIZE
	db 57, MOVE_LIGHT_SCREEN
	db 69, MOVE_DOUBLE_EDGE
	db 82, MOVE_PAIN_SPLIT
	db 0 ; no more level-up moves

ScissorsEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_QUICK_ATTACK
	db  5, MOVE_LEER
	db 10, MOVE_FOCUS_ENERGY
	db 16, MOVE_DOUBLE_TEAM
	db 23, MOVE_SLASH
	db 31, MOVE_FALSE_SWIPE
	db 40, MOVE_PURSUIT
	db 50, MOVE_SWORDS_DANCE
	db 61, MOVE_FURY_CUTTER
	db 73, MOVE_AGILITY
	db 0 ; no more level-up moves

PurakkusuEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_VICEGRIP
	db  7, MOVE_FOCUS_ENERGY
	db 14, MOVE_HARDEN
	db 22, MOVE_SEISMIC_TOSS
	db 31, MOVE_ENDURE
	db 41, MOVE_SLASH
	db 52, MOVE_CROSS_CUTTER
	db 64, MOVE_SWORDS_DANCE
	db 77, MOVE_GUILLOTINE
	db 0 ; no more level-up moves

DevilEvosAttacks:
	db EVOLVE_LEVEL, 35, DEX_HELGAA
	db 0 ; no more evolutions
	db  1, MOVE_EMBER
	db  7, MOVE_LEER
	db 14, MOVE_ROAR
	db 21, MOVE_BITE
	db 28, MOVE_SWIFT
	db 35, MOVE_FIRE_SPIN
	db 42, MOVE_BONEMERANG
	db 49, MOVE_SCARY_FACE
	db 56, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

HelgaaEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_EMBER
	db  8, MOVE_LEER
	db 16, MOVE_ROAR
	db 24, MOVE_BITE
	db 32, MOVE_SWIFT
	db 40, MOVE_FIRE_SPIN
	db 48, MOVE_BONEMERANG
	db 56, MOVE_SCARY_FACE
	db 64, MOVE_FLAMETHROWER
	db 0 ; no more level-up moves

WolfmanEvosAttacks:
	db EVOLVE_LEVEL, 35, DEX_WARWOLF
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  7, MOVE_POWDER_SNOW
	db 14, MOVE_TAIL_WHIP
	db 21, MOVE_SAFEGUARD
	db 28, MOVE_FURY_SWIPES
	db 35, MOVE_SLASH
	db 42, MOVE_SCREECH
	db 49, MOVE_CONFUSE_RAY
	db 56, MOVE_BLIZZARD
	db 0 ; no more level-up moves

WarwolfEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  8, MOVE_POWDER_SNOW
	db 16, MOVE_TAIL_WHIP
	db 24, MOVE_SAFEGUARD
	db 32, MOVE_FURY_SWIPES
	db 40, MOVE_SLASH
	db 48, MOVE_SCREECH
	db 56, MOVE_CONFUSE_RAY
	db 64, MOVE_BLIZZARD
	db 0 ; no more level-up moves

Porygon2EvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  8, MOVE_SHARPEN
	db 15, MOVE_CONVERSION
	db 15, MOVE_CONVERSION2
	db 22, MOVE_PSYBEAM
	db 29, MOVE_TRI_ATTACK
	db 36, MOVE_RECOVER
	db 43, MOVE_AGILITY
	db 50, MOVE_HYPER_BEAM
	db 0 ; no more level-up moves

NameilEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_LICK
	db  7, MOVE_SUPERSONIC
	db 14, MOVE_DISABLE
	db 22, MOVE_STOMP
	db 31, MOVE_WRAP
	db 41, MOVE_DEFENSE_CURL
	db 52, MOVE_SLAM
	db 64, MOVE_AMNESIA
	db 77, MOVE_SCREECH
	db 0 ; no more level-up moves

HaganeilEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_HARDEN
	db 11, MOVE_BIND
	db 17, MOVE_RAGE
	db 23, MOVE_ROCK_THROW
	db 30, MOVE_SCREECH
	db 37, MOVE_DIG
	db 45, MOVE_SANDSTORM
	db 53, MOVE_SLAM
	db 62, MOVE_IRON_TAIL
	db 0 ; no more level-up moves

KingdraEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_BUBBLE
	db  9, MOVE_SMOKESCREEN
	db 17, MOVE_LEER
	db 25, MOVE_WATER_GUN
	db 32, MOVE_PIN_MISSILE
	db 33, MOVE_QUICK_ATTACK
	db 41, MOVE_DRAGONBREATH
	db 49, MOVE_AGILITY
	db 57, MOVE_OCTAZOOKA
	db 65, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

RaiEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db 10, MOVE_THUNDERSHOCK
	db 19, MOVE_QUICK_ATTACK
	db 29, MOVE_FOCUS_ENERGY
	db 39, MOVE_BITE
	db 50, MOVE_FURY_SWIPES
	db 61, MOVE_THUNDERBOLT
	db 73, MOVE_DETECT
	db 85, MOVE_THUNDER
	db 0 ; no more level-up moves

EnEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db 10, MOVE_EMBER
	db 19, MOVE_QUICK_ATTACK
	db 29, MOVE_FOCUS_ENERGY
	db 39, MOVE_BITE
	db 50, MOVE_FURY_SWIPES
	db 61, MOVE_FLAMETHROWER
	db 73, MOVE_ENDURE
	db 85, MOVE_FIRE_BLAST
	db 0 ; no more level-up moves

SuiEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db 10, MOVE_WATER_GUN
	db 19, MOVE_QUICK_ATTACK
	db 29, MOVE_FOCUS_ENERGY
	db 39, MOVE_BITE
	db 50, MOVE_FURY_SWIPES
	db 61, MOVE_BUBBLEBEAM
	db 73, MOVE_MIND_READER
	db 85, MOVE_HYDRO_PUMP
	db 0 ; no more level-up moves

NyulaEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  6, MOVE_TAIL_WHIP
	db 12, MOVE_LEER
	db 18, MOVE_PURSUIT
	db 24, MOVE_SAND_ATTACK
	db 30, MOVE_FAINT_ATTACK
	db 36, MOVE_DETECT
	db 42, MOVE_FURY_SWIPES
	db 48, MOVE_SLASH
	db 0 ; no more level-up moves

HououEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_WING_ATTACK
	db  9, MOVE_LEER
	db 18, MOVE_DETECT
	db 28, MOVE_GUST
	db 39, MOVE_LIGHT_SCREEN
	db 39, MOVE_REFLECT
	db 39, MOVE_SAFEGUARD
	db 51, MOVE_SACRED_FIRE
	db 64, MOVE_SCARY_FACE
	db 78, MOVE_RECOVER
	db 93, MOVE_SKY_ATTACK
	db 0 ; no more level-up moves

TogepyEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_PECK
	db  8, MOVE_WITHDRAW
	db 15, MOVE_MIRROR_MOVE
	db 22, MOVE_CHARM
	db 29, MOVE_SPIKE_CANNON
	db 36, MOVE_PROTECT
	db 43, MOVE_RECOVER
	db 50, MOVE_SKULL_BASH
	db 0 ; no more level-up moves

BuluEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  6, MOVE_TAIL_WHIP
	db 11, MOVE_SCARY_FACE
	db 17, MOVE_SING
	db 23, MOVE_BITE
	db 30, MOVE_SAFEGUARD
	db 37, MOVE_SWEET_KISS
	db 45, MOVE_DOUBLE_EDGE
	db 53, MOVE_PERISH_SONG
	db 0 ; no more level-up moves

TailEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_SCRATCH
	db  5, MOVE_LEER
	db  9, MOVE_SAND_ATTACK
	db 14, MOVE_PURSUIT
	db 19, MOVE_ENCORE
	db 25, MOVE_SWIFT
	db 31, MOVE_MUD_SLAP
	db 38, MOVE_FURY_SWIPES
	db 45, MOVE_MIMIC
	db 0 ; no more level-up moves

LeafyEvosAttacks:
	db 0 ; no more evolutions
	db  1, MOVE_TACKLE
	db  7, MOVE_SAND_ATTACK
	db 14, MOVE_QUICK_ATTACK
	db 21, MOVE_TAIL_WHIP
	db 28, MOVE_ABSORB
	db 35, MOVE_RAZOR_LEAF
	db 42, MOVE_GROWTH
	db 49, MOVE_MORNING_SUN
	db 56, MOVE_WRAP
	db 63, MOVE_SOLARBEAM
	db 0 ; no more level-up moves
