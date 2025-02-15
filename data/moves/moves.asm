INCLUDE "constants.asm"

MACRO move
	db \1 ; animation
	db \2 ; effect
	db \3 ; power
	db \4 ; type
	db \5 ; accuracy
	db \6 ; pp
	db \7 percent ; effect chance
ENDM

SECTION "data/moves/moves.asm", ROMX

Moves::
	move MOVE_POUND,	EFFECT_NORMAL_HIT,	 40, TYPE_NORMAL,   100 percent,     35,   0
	move MOVE_KARATE_CHOP,	EFFECT_NORMAL_HIT,	 50, TYPE_NORMAL,   100 percent,     25,   0
	move MOVE_DOUBLESLAP,	EFFECT_MULTI_HIT,	 15, TYPE_NORMAL,    85 percent,     10,   0
	move MOVE_COMET_PUNCH,	EFFECT_MULTI_HIT,	 18, TYPE_NORMAL,    85 percent,     15,   0
	move MOVE_MEGA_PUNCH,	EFFECT_NORMAL_HIT,	 80, TYPE_NORMAL,    85 percent,     20,   0
	move MOVE_PAY_DAY,	EFFECT_PAY_DAY,		 40, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_FIRE_PUNCH,	EFFECT_BURN_HIT,	 75, TYPE_FIRE,	    100 percent,     15,  10
	move MOVE_ICE_PUNCH,	EFFECT_FREEZE_HIT,	 75, TYPE_ICE,	    100 percent,     15,  10
	move MOVE_THUNDERPUNCH,	EFFECT_PARALYZE_HIT,	 75, TYPE_ELECTRIC, 100 percent,     15,  10
	move MOVE_SCRATCH,	EFFECT_NORMAL_HIT,	 40, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_VICEGRIP,	EFFECT_NORMAL_HIT,	 55, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_GUILLOTINE,	EFFECT_OHKO,		  1, TYPE_NORMAL,    30 percent,      5,   0
	move MOVE_RAZOR_WIND,	EFFECT_RAZOR_WIND,	 80, TYPE_NORMAL,    75 percent,     10,   0
	move MOVE_SWORDS_DANCE,	EFFECT_ATTACK_UP_2,	  0, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_CUT,		EFFECT_NORMAL_HIT,	 50, TYPE_NORMAL,    95 percent,     30,   0
	move MOVE_GUST,		EFFECT_NORMAL_HIT,	 40, TYPE_FLYING,   100 percent,     35,   0
	move MOVE_WING_ATTACK,	EFFECT_NORMAL_HIT,	 60, TYPE_FLYING,   100 percent,     35,   0
	move MOVE_WHIRLWIND,	EFFECT_FORCE_SWITCH,	  0, TYPE_NORMAL,    85 percent,     20,   0
	move MOVE_FLY,		EFFECT_FLY,		 70, TYPE_FLYING,    95 percent,     15,   0
	move MOVE_BIND,		EFFECT_TRAP_TARGET,	 15, TYPE_NORMAL,    75 percent,     20,   0
	move MOVE_SLAM,		EFFECT_NORMAL_HIT,	 80, TYPE_NORMAL,    75 percent,     20,   0
	move MOVE_VINE_WHIP,	EFFECT_NORMAL_HIT,	 35, TYPE_GRASS,    100 percent,     10,   0
	move MOVE_STOMP,	EFFECT_STOMP,		 65, TYPE_NORMAL,   100 percent,     20,  30
	move MOVE_DOUBLE_KICK,	EFFECT_DOUBLE_HIT,	 30, TYPE_FIGHTING, 100 percent,     30,   0
	move MOVE_MEGA_KICK,	EFFECT_NORMAL_HIT,	120, TYPE_NORMAL,    75 percent,      5,   0
	move MOVE_JUMP_KICK,	EFFECT_JUMP_KICK,	 70, TYPE_FIGHTING,  95 percent,     25,   0
	move MOVE_ROLLING_KICK,	EFFECT_STOMP,		 60, TYPE_FIGHTING,  85 percent,     15,  30
	move MOVE_SAND_ATTACK,	EFFECT_ACCURACY_DOWN,	  0, TYPE_NORMAL,   100 percent,     15,   0
	move MOVE_HEADBUTT,	EFFECT_STOMP,		 70, TYPE_NORMAL,   100 percent,     15,  30
	move MOVE_HORN_ATTACK,	EFFECT_NORMAL_HIT,	 65, TYPE_NORMAL,   100 percent,     25,   0
	move MOVE_FURY_ATTACK,	EFFECT_MULTI_HIT,	 15, TYPE_NORMAL,    85 percent,     20,   0
	move MOVE_HORN_DRILL,	EFFECT_OHKO,		  1, TYPE_NORMAL,    30 percent,      5,   0
	move MOVE_TACKLE,	EFFECT_NORMAL_HIT,	 35, TYPE_NORMAL,    95 percent,     35,   0
	move MOVE_BODY_SLAM,	EFFECT_PARALYZE_HIT,	 85, TYPE_NORMAL,   100 percent,     15,  30
	move MOVE_WRAP,		EFFECT_TRAP_TARGET,	 15, TYPE_NORMAL,    85 percent,     20,   0
	move MOVE_TAKE_DOWN,	EFFECT_RECOIL_HIT,	 90, TYPE_NORMAL,    85 percent,     20,   0
	move MOVE_THRASH,	EFFECT_RAMPAGE,		 90, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_DOUBLE_EDGE,	EFFECT_RECOIL_HIT,	100, TYPE_NORMAL,   100 percent,     15,   0
	move MOVE_TAIL_WHIP,	EFFECT_DEFENSE_DOWN,	  0, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_POISON_STING,	EFFECT_POISON_HIT,	 15, TYPE_POISON,   100 percent,     35,  10
	move MOVE_TWINEEDLE,	EFFECT_POISON_MULTI_HIT, 25, TYPE_BUG,	    100 percent,     20,  20
	move MOVE_PIN_MISSILE,	EFFECT_MULTI_HIT,	 14, TYPE_BUG,	     85 percent,     20,   0
	move MOVE_LEER,		EFFECT_DEFENSE_DOWN,	  0, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_BITE,		EFFECT_FLINCH_HIT,	 60, TYPE_NORMAL,   100 percent,     25,  10
	move MOVE_GROWL,	EFFECT_ATTACK_DOWN,	  0, TYPE_NORMAL,   100 percent,     40,   0
	move MOVE_ROAR,		EFFECT_FORCE_SWITCH,	  0, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_SING,		EFFECT_SLEEP,		  0, TYPE_NORMAL,    55 percent,     15,   0
	move MOVE_SUPERSONIC,	EFFECT_CONFUSE,		  0, TYPE_NORMAL,    55 percent,     20,   0
	move MOVE_SONICBOOM,	EFFECT_STATIC_DAMAGE,	 20, TYPE_NORMAL,    90 percent,     20,   0
	move MOVE_DISABLE,	EFFECT_DISABLE,		  0, TYPE_NORMAL,    55 percent,     20,   0
	move MOVE_ACID,		EFFECT_DEFENSE_DOWN_HIT,		 40, TYPE_POISON,   100 percent,     30,  10
	move MOVE_EMBER,	EFFECT_BURN_HIT,	 40, TYPE_FIRE,	    100 percent,     25,  10
	move MOVE_FLAMETHROWER,	EFFECT_BURN_HIT,	 95, TYPE_FIRE,	    100 percent,     15,  10
	move MOVE_MIST,		EFFECT_MIST,		  0, TYPE_ICE,	    100 percent,     30,   0
	move MOVE_WATER_GUN,	EFFECT_NORMAL_HIT,	 40, TYPE_WATER,    100 percent,     25,   0
	move MOVE_HYDRO_PUMP,	EFFECT_NORMAL_HIT,	120, TYPE_WATER,     80 percent,      5,   0
	move MOVE_SURF,		EFFECT_NORMAL_HIT,	 95, TYPE_WATER,    100 percent,     15,   0
	move MOVE_ICE_BEAM,	EFFECT_FREEZE_HIT,	 95, TYPE_ICE,	    100 percent,     10,  10
	move MOVE_BLIZZARD,	EFFECT_FREEZE_HIT,	120, TYPE_ICE,	     90 percent,      5,  30
	move MOVE_PSYBEAM,	EFFECT_CONFUSE_HIT,	 65, TYPE_PSYCHIC,  100 percent,     20,  10
	move MOVE_BUBBLEBEAM,	EFFECT_SPEED_DOWN_HIT,	 65, TYPE_WATER,    100 percent,     20,  10
	move MOVE_AURORA_BEAM,	EFFECT_ATTACK_DOWN_HIT,	 65, TYPE_ICE,	    100 percent,     20,  10
	move MOVE_HYPER_BEAM,	EFFECT_HYPER_BEAM,	150, TYPE_NORMAL,    90 percent,      5,   0
	move MOVE_PECK,		EFFECT_NORMAL_HIT,	 35, TYPE_FLYING,   100 percent,     35,   0
	move MOVE_DRILL_PECK,	EFFECT_NORMAL_HIT,	 80, TYPE_FLYING,   100 percent,     20,   0
	move MOVE_SUBMISSION,	EFFECT_RECOIL_HIT,	 80, TYPE_FIGHTING,  80 percent,     25,   0
	move MOVE_LOW_KICK,	EFFECT_STOMP,		 50, TYPE_FIGHTING,  90 percent,     20,  30
	move MOVE_COUNTER,	EFFECT_COUNTER,		  1, TYPE_FIGHTING, 100 percent,     20,   0
	move MOVE_SEISMIC_TOSS,	EFFECT_LEVEL_DAMAGE,	  1, TYPE_FIGHTING, 100 percent,     20,   0
	move MOVE_STRENGTH,	EFFECT_NORMAL_HIT,	 80, TYPE_NORMAL,   100 percent,     15,   0
	move MOVE_ABSORB,	EFFECT_LEECH_HIT,	 20, TYPE_GRASS,    100 percent,     20,   0
	move MOVE_MEGA_DRAIN,	EFFECT_LEECH_HIT,	 40, TYPE_GRASS,    100 percent,     10,   0
	move MOVE_LEECH_SEED,	EFFECT_LEECH_SEED,	  1, TYPE_GRASS,     90 percent,     10,   0
	move MOVE_GROWTH,	EFFECT_SP_ATK_UP,	  0, TYPE_NORMAL,   100 percent,     40,   0
	move MOVE_RAZOR_LEAF,	EFFECT_NORMAL_HIT,	 55, TYPE_GRASS,     95 percent,     25,   0
	move MOVE_SOLARBEAM,	EFFECT_RAZOR_WIND,	120, TYPE_GRASS,    100 percent,     10,   0
	move MOVE_POISONPOWDER,	EFFECT_POISON,		  0, TYPE_POISON,    75 percent,     35,   0
	move MOVE_STUN_SPORE,	EFFECT_PARALYZE,	  0, TYPE_GRASS,     75 percent,     30,   0
	move MOVE_SLEEP_POWDER,	EFFECT_SLEEP,		  0, TYPE_GRASS,     75 percent,     15,   0
	move MOVE_PETAL_DANCE,	EFFECT_RAMPAGE,		 70, TYPE_GRASS,    100 percent,     20,   0
	move MOVE_STRING_SHOT,	EFFECT_SPEED_DOWN,	  0, TYPE_BUG,	     95 percent,     40,   0
	move MOVE_DRAGON_RAGE,	EFFECT_STATIC_DAMAGE,	 40, TYPE_DRAGON,   100 percent,     10,   0
	move MOVE_FIRE_SPIN,	EFFECT_TRAP_TARGET,	 15, TYPE_FIRE,	     70 percent,     15,   0
	move MOVE_THUNDERSHOCK,	EFFECT_PARALYZE_HIT,	 40, TYPE_ELECTRIC, 100 percent,     30,  10
	move MOVE_THUNDERBOLT,	EFFECT_PARALYZE_HIT,	 95, TYPE_ELECTRIC, 100 percent,     15,  10
	move MOVE_THUNDER_WAVE,	EFFECT_PARALYZE,	  0, TYPE_ELECTRIC, 100 percent,     20,   0
	move MOVE_THUNDER,	EFFECT_PARALYZE_HIT,	120, TYPE_ELECTRIC,  70 percent,     10,  10
	move MOVE_ROCK_THROW,	EFFECT_NORMAL_HIT,	 50, TYPE_ROCK,	     65 percent,     15,   0
	move MOVE_EARTHQUAKE,	EFFECT_NORMAL_HIT,	100, TYPE_GROUND,   100 percent,     10,   0
	move MOVE_FISSURE,	EFFECT_OHKO,		  1, TYPE_GROUND,    30 percent,      5,   0
	move MOVE_DIG,		EFFECT_RAZOR_WIND,	 60, TYPE_GROUND,   100 percent,     10,   0
	move MOVE_TOXIC,	EFFECT_TOXIC,		  0, TYPE_POISON,    85 percent,     10,   0
	move MOVE_CONFUSION,	EFFECT_CONFUSE_HIT,	 50, TYPE_PSYCHIC,  100 percent,     25,  10
	move MOVE_PSYCHIC,	EFFECT_SP_DEF_DOWN_HIT,	 90, TYPE_PSYCHIC,  100 percent,     10,   0
	move MOVE_HYPNOSIS,	EFFECT_SLEEP,		  0, TYPE_PSYCHIC,   60 percent,     20,   0
	move MOVE_MEDITATE,	EFFECT_ATTACK_UP,	  0, TYPE_PSYCHIC,  100 percent,     40,   0
	move MOVE_AGILITY,	EFFECT_SPEED_UP_2,	  0, TYPE_PSYCHIC,  100 percent,     30,   0
	move MOVE_QUICK_ATTACK,	EFFECT_PRIORITY_HIT,	 40, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_RAGE,		EFFECT_RAGE,		 20, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_TELEPORT,	EFFECT_FORCE_SWITCH,	  0, TYPE_PSYCHIC,  100 percent,     20,   0
	move MOVE_NIGHT_SHADE,	EFFECT_LEVEL_DAMAGE,	  1, TYPE_GHOST,    100 percent,     15,   0
	move MOVE_MIMIC,	EFFECT_MIMIC,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SCREECH,	EFFECT_DEFENSE_DOWN_2,	  0, TYPE_NORMAL,    85 percent,     40,   0
	move MOVE_DOUBLE_TEAM,	EFFECT_EVASION_UP,	  0, TYPE_NORMAL,   100 percent,     15,   0
	move MOVE_RECOVER,	EFFECT_HEAL,		  0, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_HARDEN,	EFFECT_DEFENSE_UP,	  0, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_MINIMIZE,	EFFECT_EVASION_UP,	  0, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_SMOKESCREEN,	EFFECT_ACCURACY_DOWN,	  0, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_CONFUSE_RAY,	EFFECT_CONFUSE,		  0, TYPE_GHOST,    100 percent,     10,   0
	move MOVE_WITHDRAW,	EFFECT_DEFENSE_UP,	  0, TYPE_WATER,    100 percent,     40,   0
	move MOVE_DEFENSE_CURL,	EFFECT_DEFENSE_UP,	  0, TYPE_NORMAL,   100 percent,     40,   0
	move MOVE_BARRIER,	EFFECT_DEFENSE_UP_2,	  0, TYPE_PSYCHIC,  100 percent,     30,   0
	move MOVE_LIGHT_SCREEN,	EFFECT_LIGHT_SCREEN,	  0, TYPE_PSYCHIC,  100 percent,     30,   0
	move MOVE_HAZE,		EFFECT_RESET_STATS,	  0, TYPE_ICE,	    100 percent,     30,   0
	move MOVE_REFLECT,	EFFECT_REFLECT,		  0, TYPE_PSYCHIC,  100 percent,     20,   0
	move MOVE_FOCUS_ENERGY,	EFFECT_FOCUS_ENERGY,	  0, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_BIDE,		EFFECT_BIDE,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_METRONOME,	EFFECT_METRONOME,	  1, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_MIRROR_MOVE,	EFFECT_MIRROR_MOVE,	  0, TYPE_FLYING,   100 percent,     20,   0
	move MOVE_SELFDESTRUCT,	EFFECT_SELFDESTRUCT,	200, TYPE_NORMAL,   100 percent,      5,   0
	move MOVE_EGG_BOMB,	EFFECT_NORMAL_HIT,	100, TYPE_NORMAL,    75 percent,     10,   0
	move MOVE_LICK,		EFFECT_PARALYZE_HIT,	 20, TYPE_GHOST,    100 percent,     30,  30
	move MOVE_SMOG,		EFFECT_POISON_HIT,	 20, TYPE_POISON,    70 percent,     20,   0
	move MOVE_SLUDGE,	EFFECT_POISON_HIT,	 65, TYPE_POISON,   100 percent,     20,  30
	move MOVE_BONE_CLUB,	EFFECT_FLINCH_HIT,	 65, TYPE_GROUND,    85 percent,     20,  10
	move MOVE_FIRE_BLAST,	EFFECT_BURN_HIT,	120, TYPE_FIRE,	     85 percent,      5,  10
	move MOVE_WATERFALL,	EFFECT_NORMAL_HIT,	 80, TYPE_WATER,    100 percent,     15,   0
	move MOVE_CLAMP,	EFFECT_TRAP_TARGET,	 35, TYPE_WATER,     75 percent,     10,   0
	move MOVE_SWIFT,	EFFECT_SWIFT,		 60, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_SKULL_BASH,	EFFECT_RAZOR_WIND,	100, TYPE_NORMAL,   100 percent,     15,   0
	move MOVE_SPIKE_CANNON,	EFFECT_MULTI_HIT,	 20, TYPE_NORMAL,   100 percent,     15,   0
	move MOVE_CONSTRICT,	EFFECT_SPEED_DOWN_HIT,	 10, TYPE_NORMAL,   100 percent,     35,  10
	move MOVE_AMNESIA,	EFFECT_SP_DEF_UP_2,	  0, TYPE_PSYCHIC,  100 percent,     20,   0
	move MOVE_KINESIS,	EFFECT_ACCURACY_DOWN,	  0, TYPE_PSYCHIC,   80 percent,     15,   0
	move MOVE_SOFTBOILED,	EFFECT_HEAL,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_HI_JUMP_KICK,	EFFECT_JUMP_KICK,	 85, TYPE_FIGHTING,  90 percent,     20,   0
	move MOVE_GLARE,	EFFECT_PARALYZE,	  0, TYPE_NORMAL,    75 percent,     30,   0
	move MOVE_DREAM_EATER,	EFFECT_DREAM_EATER,	100, TYPE_PSYCHIC,  100 percent,     15,   0
	move MOVE_POISON_GAS,	EFFECT_POISON,		  0, TYPE_POISON,    55 percent,     40,   0
	move MOVE_BARRAGE,	EFFECT_MULTI_HIT,	 15, TYPE_NORMAL,    85 percent,     20,   0
	move MOVE_LEECH_LIFE,	EFFECT_LEECH_HIT,	 20, TYPE_BUG,	    100 percent,     15,   0
	move MOVE_LOVELY_KISS,	EFFECT_SLEEP,		  0, TYPE_NORMAL,    75 percent,     10,   0
	move MOVE_SKY_ATTACK,	EFFECT_RAZOR_WIND,	140, TYPE_FLYING,    90 percent,      5,   0
	move MOVE_TRANSFORM,	EFFECT_TRANSFORM,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_BUBBLE,	EFFECT_SPEED_DOWN_HIT,	 20, TYPE_WATER,    100 percent,     30,  10
	move MOVE_DIZZY_PUNCH,	EFFECT_NORMAL_HIT,	 70, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SPORE,	EFFECT_SLEEP,		  0, TYPE_GRASS,    100 percent,     15,   0
	move MOVE_FLASH,	EFFECT_ACCURACY_DOWN,	  0, TYPE_NORMAL,    70 percent,     20,   0
	move MOVE_PSYWAVE,	EFFECT_PSYWAVE,		  1, TYPE_PSYCHIC,   80 percent,     15,   0
	move MOVE_SPLASH,	EFFECT_SPLASH,		  0, TYPE_NORMAL,   100 percent,     40,   0
	move MOVE_ACID_ARMOR,	EFFECT_DEFENSE_UP_2,	  0, TYPE_POISON,   100 percent,     40,   0
	move MOVE_CRABHAMMER,	EFFECT_NORMAL_HIT,	 90, TYPE_WATER,     85 percent,     10,   0
	move MOVE_EXPLOSION,	EFFECT_SELFDESTRUCT,	250, TYPE_NORMAL,   100 percent,      5,   0
	move MOVE_FURY_SWIPES,	EFFECT_MULTI_HIT,	 18, TYPE_NORMAL,    80 percent,     15,   0
	move MOVE_BONEMERANG,	EFFECT_DOUBLE_HIT,	 50, TYPE_GROUND,    90 percent,     10,   0
	move MOVE_REST,		EFFECT_HEAL,		  0, TYPE_PSYCHIC,  100 percent,     10,   0
	move MOVE_ROCK_SLIDE,	EFFECT_FLINCH_HIT,	 75, TYPE_ROCK,	     90 percent,     10,  30
	move MOVE_HYPER_FANG,	EFFECT_FLINCH_HIT,	 80, TYPE_NORMAL,    90 percent,     15,  10
	move MOVE_SHARPEN,	EFFECT_ATTACK_UP,	  0, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_CONVERSION,	EFFECT_CONVERSION,	  0, TYPE_NORMAL,   100 percent,     30,   0
	move MOVE_TRI_ATTACK,	EFFECT_NORMAL_HIT,	 80, TYPE_NORMAL,   100 percent,     10,  30
	move MOVE_SUPER_FANG,	EFFECT_SUPER_FANG,	  1, TYPE_NORMAL,    90 percent,     10,   0
	move MOVE_SLASH,	EFFECT_NORMAL_HIT,	 70, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_SUBSTITUTE,	EFFECT_SUBSTITUTE,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_STRUGGLE,	EFFECT_RECOIL_HIT,	 50, TYPE_NORMAL,   100 percent,      0,   0
	move MOVE_SKETCH,	EFFECT_SKETCH,		  0, TYPE_NORMAL,   100 percent,      1,   0
	move MOVE_TRIPLE_KICK,	EFFECT_TRIPLE_KICK,	 60, TYPE_FIGHTING, 100 percent,     10,   0
	move MOVE_THIEF,	EFFECT_THIEF,		 40, TYPE_DARK,	    100 percent,     10,   0
	move MOVE_SPIDER_WEB,	EFFECT_MEAN_LOOK,	  0, TYPE_BUG,	    100 percent,     10,   0
	move MOVE_MIND_READER,	EFFECT_LOCK_ON,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_NIGHTMARE,	EFFECT_NIGHTMARE,	 50, TYPE_GHOST,    100 percent,     10,   0
	move MOVE_FLAME_WHEEL,	EFFECT_FLAME_WHEEL,	 60, TYPE_FIRE,	    100 percent,     10,   0
	move MOVE_SNORE,	EFFECT_SNORE,		 40, TYPE_NORMAL,   100 percent,     10,  30
	move MOVE_NAIL_DOWN,	EFFECT_NAIL_DOWN,	 40, TYPE_GHOST,    100 percent,     10,   0
	move MOVE_FLAIL,	EFFECT_REVERSAL,	  1, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_CONVERSION2,	EFFECT_CONVERSION2,	  0, TYPE_NORMAL,   100 percent,     15,   0
	move MOVE_COIN_HURL,	EFFECT_COIN_HURL,	 40, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_COTTON_SPORE,	EFFECT_SPEED_DOWN,	  0, TYPE_GRASS,    100 percent,     10,   0
	move MOVE_REVERSAL,	EFFECT_REVERSAL,	  1, TYPE_FIGHTING, 100 percent,     10,   0
	move MOVE_SPITE,	EFFECT_SPITE,		  0, TYPE_GHOST,    100 percent,      5,   0
	move MOVE_POWDER_SNOW,	EFFECT_NORMAL_HIT,	 40, TYPE_ICE,	    100 percent,     10,  10
	move MOVE_PROTECT,	EFFECT_PROTECT,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_MACH_PUNCH,	EFFECT_PRIORITY_HIT,	 40, TYPE_FIGHTING, 100 percent,     15,   0
	move MOVE_SCARY_FACE,	EFFECT_DEFENSE_DOWN_2,	  0, TYPE_NORMAL,    85 percent,     40,   0
	move MOVE_FAINT_ATTACK,	EFFECT_NORMAL_HIT,	 60, TYPE_DARK,	    100 percent,     10,   0
	move MOVE_SWEET_KISS,	EFFECT_CONFUSE,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_BELLY_DRUM,	EFFECT_ATTACK_UP,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SLUDGE_BOMB,	EFFECT_NORMAL_HIT,	 90, TYPE_POISON,   100 percent,     10,   0
	move MOVE_MUD_SLAP,	EFFECT_ACCURACY_DOWN,	 20, TYPE_NORMAL,   100 percent,     10, 100
	move MOVE_OCTAZOOKA,	EFFECT_NORMAL_HIT,	 65, TYPE_WATER,    100 percent,     10,   0
	move MOVE_SPIKES,	EFFECT_SPIKES,		 40, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_ZAP_CANNON,	EFFECT_PARALYZE_HIT,	100, TYPE_ELECTRIC,  50 percent,      5, 100
	move MOVE_FORESIGHT,	EFFECT_FORESIGHT,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_DESTINY_BOND,	EFFECT_DESTINY_BOND,	  0, TYPE_GHOST,    100 percent,      5,   0
	move MOVE_PERISH_SONG,	EFFECT_PERISH_SONG,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SYNCHRONIZE,	EFFECT_CONVERSION,	  0, TYPE_PSYCHIC,  100 percent,     10,   0
	move MOVE_DETECT,	EFFECT_LOCK_ON,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_BONE_LOCK,	EFFECT_NORMAL_HIT,	 25, TYPE_GROUND,   100 percent,     10,   0
	move MOVE_LOCK_ON,	EFFECT_LOCK_ON,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_OUTRAGE,	EFFECT_RAMPAGE,		 90, TYPE_DRAGON,   100 percent,     10,   0
	move MOVE_SANDSTORM,	EFFECT_SANDSTORM,	 20, TYPE_ROCK,	    100 percent,     10,   0
	move MOVE_GIGA_DRAIN,	EFFECT_NORMAL_HIT,	 60, TYPE_GRASS,    100 percent,     10,   0
	move MOVE_ENDURE,	EFFECT_ENDURE,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_CHARM,	EFFECT_ATTACK_DOWN_2,	  0, TYPE_NORMAL,    85 percent,     40,   0
	move MOVE_ROLLOUT,	EFFECT_ROLLOUT,		 30, TYPE_ROCK,	     79 percent - 1, 10,   0
	move MOVE_FALSE_SWIPE,	EFFECT_FALSE_SWIPE,	 40, TYPE_NORMAL,   100 percent,     20,   0
	move MOVE_SWAGGER,	EFFECT_SWAGGER,		  0, TYPE_NORMAL,   100 percent,     10, 100
	move MOVE_MILK_DRINK,	EFFECT_HEAL,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SPARK,	EFFECT_PARALYZE_HIT,	 65, TYPE_ELECTRIC, 100 percent,     20,  10
	move MOVE_FURY_CUTTER,	EFFECT_FURY_CUTTER,	 25, TYPE_BUG,	    100 percent,     20,  20
	move MOVE_STEEL_WING,	EFFECT_NORMAL_HIT,	 70, TYPE_METAL,    100 percent,     10,   0
	move MOVE_STALKER,	EFFECT_CONFUSE,		  0, TYPE_PSYCHIC,  100 percent,     10,   0
	move MOVE_ATTRACT,	EFFECT_ATTRACT,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SLEEP_TALK,	EFFECT_SLEEP_TALK,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_BELL_CHIME,	EFFECT_BELL_CHIME,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_RETURN,	EFFECT_RETURN,		 50, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_PRESENT,	EFFECT_PRESENT,		 50, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_FRUSTRATION,	EFFECT_FRUSTRATION,	 50, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SAFEGUARD,	EFFECT_SAFEGUARD,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_PAIN_SPLIT,	EFFECT_PAIN_SPLIT,	  1, TYPE_NORMAL,   100 percent,      5,   0
	move MOVE_SACRED_FIRE,	EFFECT_SACRED_FIRE,	 80, TYPE_FIRE,	    100 percent,     10,   0
	move MOVE_MAGNITUDE,	EFFECT_MAGNITUDE,	  1, TYPE_GROUND,   100 percent,     10,   0
	move MOVE_DYNAMICPUNCH,	EFFECT_NORMAL_HIT,	100, TYPE_FIGHTING, 100 percent,     10,   0
	move MOVE_MEGAPHONE,	EFFECT_SP_ATK_DOWN,	  0, TYPE_NORMAL,    85 percent,     40,   0
	move MOVE_DRAGONBREATH,	EFFECT_NORMAL_HIT,	 40, TYPE_DRAGON,   100 percent,     10,   0
	move MOVE_BATON_PASS,	EFFECT_BATON_PASS,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_ENCORE,	EFFECT_ENCORE,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_PURSUIT,	EFFECT_PURSUIT,		 40, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_RAPID_SPIN,	EFFECT_RAPID_SPIN,	 20, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_TEMPT,	EFFECT_EVASION_DOWN,		  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_IRON_TAIL,	EFFECT_IRON_TAIL,	 60, TYPE_METAL,    100 percent,     10,   0
	move MOVE_ROCK_HEAD,	EFFECT_NORMAL_HIT,	 90, TYPE_ROCK,	    100 percent,     10,   0
	move MOVE_VITAL_THROW,	EFFECT_VITAL_THROW,	 50, TYPE_FIGHTING, 100 percent,     10,   0
	move MOVE_MORNING_SUN,	EFFECT_MORNING_SUN,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SYNTHESIS,	EFFECT_SYNTHESIS,	  0, TYPE_GRASS,    100 percent,     10,   0
	move MOVE_MOONLIGHT,	EFFECT_MOONLIGHT,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_HIDDEN_POWER,	EFFECT_HIDDEN_POWER,	  1, TYPE_UNKNOWN,  100 percent,     10,   0
	move MOVE_CROSS_CUTTER,	EFFECT_NORMAL_HIT,	 50, TYPE_BUG,	    100 percent,     10,   0
	move MOVE_TWISTER,	EFFECT_NORMAL_HIT,	 60, TYPE_DRAGON,   100 percent,     10,   0
	move MOVE_RAIN_DANCE,	EFFECT_RAIN_DANCE,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_SUNNY_DAY,	EFFECT_SUNNY_DAY,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_F2,		EFFECT_NORMAL_HIT,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_F3,		EFFECT_NORMAL_HIT,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_F4,		EFFECT_NORMAL_HIT,	  0, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_UPROOT,	EFFECT_NORMAL_HIT,	 30, TYPE_NORMAL,   100 percent,     10,   0
	move MOVE_WIND_RIDE,	EFFECT_NORMAL_HIT,	 40, TYPE_FLYING,   100 percent,     10,   0
	move MOVE_WATER_SPORT,	EFFECT_NORMAL_HIT,	 30, TYPE_WATER,    100 percent,     10,   0
	move MOVE_STRONG_ARM,	EFFECT_NORMAL_HIT,	 30, TYPE_METAL,    100 percent,     10,   0
	move MOVE_BRIGHT_MOSS,	EFFECT_ACCURACY_DOWN,	  0, TYPE_GRASS,    100 percent,     10,   0
	move MOVE_WHIRLPOOL,	EFFECT_NORMAL_HIT,	 30, TYPE_WATER,    100 percent,     10,   0
	move MOVE_BOUNCE,	EFFECT_NORMAL_HIT,	  0, TYPE_WATER,    100 percent,     10,   0
