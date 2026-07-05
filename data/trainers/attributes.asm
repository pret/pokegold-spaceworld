; Combination of pokered's TrainerPicAndMoneyPointers and the final game's TrainerClassAttributes.
TrainerClassAttributes:
; TRAINER_HAYATO
	dw HayatoPic
	db $15
	littledt $ffff00 | AI_BASIC | AI_SETUP | AI_TYPES | AI_OFFENSIVE | AI_SMART | AI_OPPORTUNIST | AI_AGGRESSIVE | AI_CAUTIOUS
	db 0

; TRAINER_AKANE
	dw AkanePic
	db $10
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TSUKUSHI
	dw TsukushiPic
	db $15
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ENOKI
	dw EnokiPic
	db $30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_OKERA
	dw OkeraPic
	db $20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_MIKAN
	dw MikanPic
	db $20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BLUE
	dw BluePic
	db $50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GAMA
	dw GamaPic
	db $25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_RIVAL
	dw RivalPic
	db $35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_OKIDO
	dw OakPic
	db $20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SAKAKI
	dw ProtagonistPic
	db $90
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PROTAGONIST
	dw ProtagonistPic
	db $50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SIBA
	dw KurtPic
	db $35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_KASUMI
	dw KurtPic
	db $35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_KANNA
	dw KurtPic
	db $5
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_WATARU
	dw KurtPic
	db $25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GERUGE_MEMBER_M
	dw KurtPic
	db $70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TRIO_1
	dw KurtPic
	db $70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TRIO_2
	dw KurtPic
	db $10
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TRIO_3
	dw KurtPic
	db $25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ROCKET_F
	dw YoungsterPic
	db $35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_YOUNGSTER
	dw YoungsterPic
	db $40
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SCHOOLBOY
	dw SchoolboyPic
	db $25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_FLEDGLING
	dw FledglingPic
	db $25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_LASS
	dw LassPic
	db $35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GENIUS
	dw ProfessionalMPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PROFESSIONAL_M
	dw ProfessionalMPic
	db $30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PROFESSIONAL_F
	dw ProfessionalFPic
	db $50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BEAUTY
	dw BeautyPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_POKEMANIAC
	dw PokemaniacPic
	db $30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ROCKET_M
	dw RocketMPic
	db $35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GENTLEMAN
	dw TeacherMPic
	db $35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TEACHER_M
	dw TeacherMPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TEACHER_F
	dw TeacherFPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_MANCHILD
	dw BugCatcherBoyPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BUG_CATCHER_BOY
	dw BugCatcherBoyPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_FISHER
	dw FisherPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SWIMMER_M
	dw SwimmerMPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SWIMMER_F
	dw SwimmerFPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SAILOR
	dw SuperNerdPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SUPER_NERD
	dw SuperNerdPic
	db $70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ENGINEER
	dw EngineerPic
	db $65
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ROCKER
	dw GreenPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_HIKER
	dw BikerPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BIKER
	dw BikerPic
	db $30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ROCK_CLIMBER
	dw BurglarPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BURGLAR
	dw BurglarPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; Everything beyond this point has no Generation I equivalent slot, so the money values are "unique".

; TRAINER_FIREBREATHER
	dw FirebreatherPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_JUGGLER
	dw JugglerPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BLACKBELT
	dw BlackbeltPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SPORTSMAN
	dw SportsmanPic
	db $70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PSYCHIC
	dw MediumPic
	db $65
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_KUNG_FU_MASTER
	dw MediumPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_FORTUNE_TELLER
	dw MediumPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_HOOLIGAN
	dw MediumPic
	db $30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SAGE
	dw MediumPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_MEDIUM
	dw MediumPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SOLDIER
	dw SoldierPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GERUGE_MEMBER_F
	dw KimonoGirlPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_KIMONO_GIRL
	dw KimonoGirlPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TWINS
	dw TwinsPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GERUGE_MEMBER_M_2
	dw TwinsPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ELITE_FOUR_M
	dw TwinsPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ELITE_FOUR_F
	dw TwinsPic
	db $99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
