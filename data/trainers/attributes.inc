; Combination of pokered's TrainerPicAndMoneyPointers and the final game's TrainerClassAttributes.
; The money values are leftover from Generation I, where they used BCD, whereas this build reads it like a normal byte.
TrainerClassAttributes:
; TRAINER_HAYATO (originally Youngster)
	dw HayatoPic
	db 21 ; originally: 15
	littledt $ffff00 | AI_BASIC | AI_SETUP | AI_TYPES | AI_OFFENSIVE | AI_SMART | AI_OPPORTUNIST | AI_AGGRESSIVE | AI_CAUTIOUS
	db 0

; TRAINER_AKANE (originally Bug Catcher)
	dw AkanePic
	db 16 ; originally 10
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TSUKUSHI (originally Lass)
	dw TsukushiPic
	db 21 ; originally 15
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ENOKI (originally Sailor)
	dw EnokiPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_OKERA (originally Jr. Trainer Male)
	dw OkeraPic
	db 32 ; originally 20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_MIKAN (originally Jr. Trainer Female)
	dw MikanPic
	db 32 ; originally 20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BLUE (originally Pokémaniac)
	dw BluePic
	db 80 ; originally 50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GAMA (originally SuperNerd)
	dw GamaPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_RIVAL (originally Hiker)
	dw RivalPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_OKIDO (originally Biker)
	dw OakPic
	db $20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SAKAKI (originally Burglar)
	dw ProtagonistPic
	db $90
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PROTAGONIST (originally Engineer)
	dw ProtagonistPic
	db 80 ; originally 50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SIBA (originally unused Juggler duplicate)
	dw KurtPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_KASUMI (originally Fisher)
	dw KurtPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_KANNA (originally Swimmer)
	dw KurtPic
	db 5
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_WATARU (originally Cue Ball)
	dw KurtPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GERUGE_MEMBER_M (originally Gambler)
	dw KurtPic
	db 112 ; originally 70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TRIO_1 (originally Beauty)
	dw KurtPic
	db 112 ; originally 70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TRIO_2 (originally Psychic)
	dw KurtPic
	db 16 ; originally 10
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TRIO_3 (originally Rocker)
	dw KurtPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ROCKET_F (originally Juggler)
	dw YoungsterPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_YOUNGSTER (originally Tamer)
	dw YoungsterPic
	db 64 ; originally 40
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SCHOOLBOY (originally Bird Keeper)
	dw SchoolboyPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_FLEDGLING (originally Black Belt)
	dw FledglingPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_LASS (originally Rival 1)
	dw LassPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GENIUS (originally Prof. Oak)
	dw ProfessionalMPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PROFESSIONAL_M (originally Chief)
	dw ProfessionalMPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PROFESSIONAL_F (originally Scientist)
	dw ProfessionalFPic
	db 80 ; originally 50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BEAUTY (originally Giovanni)
	dw BeautyPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_POKEMANIAC (originally Rocket)
	dw PokemaniacPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ROCKET_M (originally Cooltrainer Male)
	dw RocketMPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GENTLEMAN (originally Cooltrainer Female)
	dw TeacherMPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TEACHER_M (originally Bruno)
	dw TeacherMPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TEACHER_F (originally Brock)
	dw TeacherFPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_MANCHILD (originally Misty)
	dw BugCatcherBoyPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BUG_CATCHER_BOY (originally Lt. Surge)
	dw BugCatcherBoyPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_FISHER (originally Erika)
	dw FisherPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SWIMMER_M (originally Koga)
	dw SwimmerMPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SWIMMER_F (originally Blaine)
	dw SwimmerFPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SAILOR (originally Sabrina)
	dw SuperNerdPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SUPER_NERD (originally Gentleman)
	dw SuperNerdPic
	db 112 ; originally 70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ENGINEER (originally Rival 2)
	dw EngineerPic
	db 101 ; originally 65
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ROCKER (originally Rival 3)
	dw GreenPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_HIKER (originally Loreli)
	dw BikerPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BIKER (originally Channeler)
	dw BikerPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ROCK_CLIMBER (originally Agatha)
	dw BurglarPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BURGLAR (originally Lance)
	dw BurglarPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; Everything beyond this point has no Generation I equivalent slot, so the money values are "unique".

; TRAINER_FIREBREATHER
	dw FirebreatherPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_JUGGLER
	dw JugglerPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BLACKBELT
	dw BlackbeltPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SPORTSMAN
	dw SportsmanPic
	db 112 ; originally 70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PSYCHIC
	dw MediumPic
	db 101 ; originally 65
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_KUNG_FU_MASTER
	dw MediumPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_FORTUNE_TELLER
	dw MediumPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_HOOLIGAN
	dw MediumPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SAGE
	dw MediumPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_MEDIUM
	dw MediumPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SOLDIER
	dw SoldierPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GERUGE_MEMBER_F
	dw KimonoGirlPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_KIMONO_GIRL
	dw KimonoGirlPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TWINS
	dw TwinsPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GERUGE_MEMBER_M_2
	dw TwinsPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ELITE_FOUR_M
	dw TwinsPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ELITE_FOUR_F
	dw TwinsPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
