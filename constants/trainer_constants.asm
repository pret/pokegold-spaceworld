DEF __trainer_class__ = 0

MACRO trainerclass
DEF \1 EQU __trainer_class__
DEF __trainer_class__ = __trainer_class__ + 1
DEF const_value = 1
ENDM

; trainer class ids
	trainerclass TRAINER_NONE ; 00

	trainerclass TRAINER_HAYATO ; 01

	trainerclass TRAINER_AKANE ; 02

	trainerclass TRAINER_TSUKISHI ; 03

	trainerclass TRAINER_ENOKI ; 04

	trainerclass TRAINER_OKERA ; 05

	trainerclass TRAINER_MIKAN ; 06

	trainerclass TRAINER_BLUE ; 07

	trainerclass TRAINER_GAMA ; 08

	trainerclass TRAINER_RIVAL ; 09

	trainerclass TRAINER_OKIDO ; 0a

	trainerclass TRAINER_SAKAKI ; 0b

	trainerclass TRAINER_PROTAGONIST ; 0c

	trainerclass TRAINER_SIBA ; 0d

	trainerclass TRAINER_KASUMI ; 0e

	trainerclass TRAINER_KANNA ; 0f

	trainerclass TRAINER_WATARU ; 10

	trainerclass TRAINER_GERUGE_MEMBER_M ; 11

	trainerclass TRAINER_TRIO_1 ; 12

	trainerclass TRAINER_TRIO_2 ; 13

	trainerclass TRAINER_TRIO_3 ; 14

	trainerclass TRAINER_ROCKET_F ; 15

	trainerclass TRAINER_YOUNGSTER ; 16

	trainerclass TRAINER_SCHOOLBOY ; 17
	const SCHOOLBOY_TETSUYA ; 01

	trainerclass TRAINER_FLEDGLING ; 18

	trainerclass TRAINER_LASS ; 19

	trainerclass TRAINER_PRODIGY ; 1a

	trainerclass TRAINER_PROFESSIONAL_M ; 1b

	trainerclass TRAINER_PROFESSIONAL_F ; 1c

	trainerclass TRAINER_BEAUTY ; 1d
	const BEAUTY_MEGUMI ; 01

	trainerclass TRAINER_POKEMANIAC ; 1e

	trainerclass TRAINER_ROCKET_M ; 1f

	trainerclass TRAINER_GENTLEMAN ; 20

	trainerclass TRAINER_TEACHER_M ; 21

	trainerclass TRAINER_TEACHER_F ; 22

	trainerclass TRAINER_MANCHILD ; 23

	trainerclass TRAINER_BUG_CATCHER_BOY ; 24
	const BUG_CATCHER_BOY_JUNICHI ; 01
	const BUG_CATCHER_BOY_SOUSUKE ; 02

	trainerclass TRAINER_FISHER ; 25

	trainerclass TRAINER_SWIMMER_F ; 26

	trainerclass TRAINER_SWIMMER_M ; 27

	trainerclass TRAINER_SAILOR ; 28

	trainerclass TRAINER_SUPER_NERD ; 29

	trainerclass TRAINER_ENGINEER ; 2a

	trainerclass TRAINER_ROCKER ; 2b

	trainerclass TRAINER_HIKER ; 2c

	trainerclass TRAINER_BIKER ; 2d

	trainerclass TRAINER_ROCK_CLIMBER ; 2e

	trainerclass TRAINER_BURGLAR ; 2f

	trainerclass TRAINER_FIREBREATHER ; 30
	const FIREBREATHER_AKITO ; 01

	trainerclass TRAINER_JUGGLER ; 31

	trainerclass TRAINER_BLACKBELT ; 32

	trainerclass TRAINER_SPORTSMAN ; 33
	const SPORTSMAN_SHIGEKI ; 01

	trainerclass TRAINER_PSYCHIC ; 34

	trainerclass TRAINER_KUNG_FU_MASTER ; 35

	trainerclass TRAINER_FORTUNE_TELLER ; 36

	trainerclass TRAINER_HOOLIGAN ; 37

	trainerclass TRAINER_SAGE ; 38

	trainerclass TRAINER_MEDIUM ; 39

	trainerclass TRAINER_SOLDIER ; 3a

	trainerclass TRAINER_GERUGE_MEMBER_F ; 3b

	trainerclass TRAINER_KIMONO_GIRL ; 3c
	const KIMONO_GIRL_TAMAO ; 01
	const KIMONO_GIRL_KOUME ; 02

	trainerclass TRAINER_TWINS ; 3d

	trainerclass TRAINER_GERUGE_MEMBER_M_2 ; 3e

	trainerclass TRAINER_ELITE_FOUR_M ; 3f

	trainerclass TRAINER_ELITE_FOUR_F ; 40

DEF NUM_TRAINER_CLASSES EQU __trainer_class__
