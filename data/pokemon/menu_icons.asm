INCLUDE "constants.asm"

SECTION "data/pokemon/menu_icons.asm", ROMX

MonMenuIcons::
	db ICON_BULBASAUR  ; 01 BULBASAUR
	db ICON_BULBASAUR  ; 02 IVYSAUR
	db ICON_BULBASAUR  ; 03 VENUSAUR
	db ICON_CHARMANDER ; 04 CHARMANDER
	db ICON_CHARMANDER ; 05 CHARMELEON
	db ICON_CHARMANDER ; 06 CHARIZARD
	db ICON_SQUIRTLE   ; 07 SQUIRTLE
	db ICON_SQUIRTLE   ; 08 WARTORTLE
	db ICON_SQUIRTLE   ; 09 BLASTOISE
	db ICON_WEEDLE     ; 0a CATERPIE
	db ICON_WEEDLE     ; 0b METAPOD
	db ICON_BUTTERFREE ; 0c BUTTERFREE
	db ICON_WEEDLE     ; 0d WEEDLE
	db ICON_WEEDLE     ; 0e KAKUNA
	db ICON_MUSHI      ; 0f BEEDRILL
	db ICON_PIDGEY     ; 10 PIDGEY
	db ICON_PIDGEY     ; 11 PIDGEOTTO
	db ICON_PIDGEY     ; 12 PIDGEOT
	db ICON_LOKON      ; 13 RATTATA
	db ICON_LOKON      ; 14 RATICATE
	db ICON_PIDGEY     ; 15 SPEAROW
	db ICON_PIDGEY     ; 16 FEAROW
	db ICON_ONIX       ; 17 EKANS
	db ICON_ONIX       ; 18 ARBOK
	db ICON_PIKACHU    ; 19 PIKACHU
	db ICON_PIKACHU    ; 1a RAICHU
	db ICON_RHYDON     ; 1b SANDSHREW
	db ICON_RHYDON     ; 1c SANDSLASH
	db ICON_LOKON      ; 1d NIDORAN_F
	db ICON_LOKON      ; 1e NIDORINA
	db ICON_RHYDON     ; 1f NIDOQUEEN
	db ICON_LOKON      ; 20 NIDORAN_M
	db ICON_LOKON      ; 21 NIDORINO
	db ICON_RHYDON     ; 22 NIDOKING
	db ICON_CLEFAIRY   ; 23 CLEFAIRY
	db ICON_CLEFAIRY   ; 24 CLEFABLE
	db ICON_LOKON      ; 25 VULPIX
	db ICON_LOKON      ; 26 NINETALES
	db ICON_JIGGLYPUFF ; 27 JIGGLYPUFF
	db ICON_JIGGLYPUFF ; 28 WIGGLYTUFF
	db ICON_ZUBAT      ; 29 ZUBAT
	db ICON_ZUBAT      ; 2a GOLBAT
	db ICON_ODDISH     ; 2b ODDISH
	db ICON_ODDISH     ; 2c GLOOM
	db ICON_ODDISH     ; 2d VILEPLUME
	db ICON_MUSHI      ; 2e PARAS
	db ICON_MUSHI      ; 2f PARASECT
	db ICON_MUSHI      ; 30 VENONAT
	db ICON_BUTTERFREE ; 31 VENOMOTH
	db ICON_DIGLETT    ; 32 DIGLETT
	db ICON_DIGLETT    ; 33 DUGTRIO
	db ICON_LOKON      ; 34 MEOWTH
	db ICON_LOKON      ; 35 PERSIAN
	db ICON_RHYDON     ; 36 PSYDUCK
	db ICON_RHYDON     ; 37 GOLDUCK
	db ICON_MACHOP     ; 38 MANKEY
	db ICON_MACHOP     ; 39 PRIMEAPE
	db ICON_LOKON      ; 3a GROWLITHE
	db ICON_LOKON      ; 3b ARCANINE
	db ICON_POLIWAG    ; 3c POLIWAG
	db ICON_POLIWAG    ; 3d POLIWHIRL
	db ICON_POLIWAG    ; 3e POLIWRATH
	db ICON_MRMIME     ; 3f ABRA
	db ICON_MRMIME     ; 40 KADABRA
	db ICON_MRMIME     ; 41 ALAKAZAM
	db ICON_MACHOP     ; 42 MACHOP
	db ICON_MACHOP     ; 43 MACHOKE
	db ICON_MACHOP     ; 44 MACHAMP
	db ICON_ODDISH     ; 45 BELLSPROUT
	db ICON_ODDISH     ; 46 WEEPINBELL
	db ICON_ODDISH     ; 47 VICTREEBEL
	db ICON_TENTACOOL  ; 48 TENTACOOL
	db ICON_TENTACOOL  ; 49 TENTACRUEL
	db ICON_GEODUDE    ; 4a GEODUDE
	db ICON_GEODUDE    ; 4b GRAVELER
	db ICON_GEODUDE    ; 4c GOLEM
	db ICON_TAUROS     ; 4d PONYTA
	db ICON_TAUROS     ; 4e RAPIDASH
	db ICON_RHYDON     ; 4f SLOWPOKE
	db ICON_RHYDON     ; 50 SLOWBRO
	db ICON_VOLTORB    ; 51 MAGNEMITE
	db ICON_VOLTORB    ; 52 MAGNETON
	db ICON_PIDGEY     ; 53 FARFETCHD
	db ICON_PIDGEY     ; 54 DODUO
	db ICON_PIDGEY     ; 55 DODRIO
	db ICON_LAPRAS     ; 56 SEEL
	db ICON_LAPRAS     ; 57 DEWGONG
	db ICON_DITTO      ; 58 GRIMER
	db ICON_DITTO      ; 59 MUK
	db ICON_SHELLDER   ; 5a SHELLDER
	db ICON_SHELLDER   ; 5b CLOYSTER
	db ICON_GENGAR     ; 5c GASTLY
	db ICON_GENGAR     ; 5d HAUNTER
	db ICON_GENGAR     ; 5e GENGAR
	db ICON_GEODUDE    ; 5f ONIX
	db ICON_MRMIME     ; 60 DROWZEE
	db ICON_MRMIME     ; 61 HYPNO
	db ICON_SHELLDER   ; 62 KRABBY
	db ICON_SHELLDER   ; 63 KINGLER
	db ICON_VOLTORB    ; 64 VOLTORB
	db ICON_VOLTORB    ; 65 ELECTRODE
	db ICON_ODDISH     ; 66 EXEGGCUTE
	db ICON_ODDISH     ; 67 EXEGGUTOR
	db ICON_RHYDON     ; 68 CUBONE
	db ICON_RHYDON     ; 69 MAROWAK
	db ICON_MACHOP     ; 6a HITMONLEE
	db ICON_MACHOP     ; 6b HITMONCHAN
	db ICON_RHYDON     ; 6c LICKITUNG
	db ICON_DITTO      ; 6d KOFFING
	db ICON_DITTO      ; 6e WEEZING
	db ICON_TAUROS     ; 6f RHYHORN
	db ICON_RHYDON     ; 70 RHYDON
	db ICON_RHYDON     ; 71 CHANSEY
	db ICON_ODDISH     ; 72 TANGELA
	db ICON_RHYDON     ; 73 KANGASKHAN
	db ICON_MAGIKARP   ; 74 HORSEA
	db ICON_MAGIKARP   ; 75 SEADRA
	db ICON_MAGIKARP   ; 76 GOLDEEN
	db ICON_MAGIKARP   ; 77 SEAKING
	db ICON_STARYU     ; 78 STARYU
	db ICON_STARYU     ; 79 STARMIE
	db ICON_MRMIME     ; 7a MRMIME
	db ICON_MUSHI      ; 7b SCYTHER
	db ICON_MRMIME     ; 7c JYNX
	db ICON_MRMIME     ; 7d ELECTABUZZ
	db ICON_MRMIME     ; 7e MAGMAR
	db ICON_MUSHI      ; 7f PINSIR
	db ICON_TAUROS     ; 80 TAUROS
	db ICON_MAGIKARP   ; 81 MAGIKARP
	db ICON_ONIX       ; 82 GYARADOS
	db ICON_LAPRAS     ; 83 LAPRAS
	db ICON_DITTO      ; 84 DITTO
	db ICON_LOKON      ; 85 EEVEE
	db ICON_LOKON      ; 86 VAPOREON
	db ICON_LOKON      ; 87 JOLTEON
	db ICON_LOKON      ; 88 FLAREON
	db ICON_VOLTORB    ; 89 PORYGON
	db ICON_SHELLDER   ; 8a OMANYTE
	db ICON_SHELLDER   ; 8b OMASTAR
	db ICON_RHYDON     ; 8c KABUTO
	db ICON_RHYDON     ; 8d KABUTOPS
	db ICON_PIDGEY     ; 8e AERODACTYL
	db ICON_SNORLAX    ; 8f SNORLAX
	db ICON_PIDGEY     ; 90 ARTICUNO
	db ICON_PIDGEY     ; 91 ZAPDOS
	db ICON_PIDGEY     ; 92 MOLTRES
	db ICON_ONIX       ; 93 DRATINI
	db ICON_ONIX       ; 94 DRAGONAIR
	db ICON_LAPRAS     ; 95 DRAGONITE
	db ICON_MRMIME     ; 96 MEWTWO
	db ICON_MRMIME     ; 97 MEW
	db ICON_ODDISH     ; 98 HAPPA
	db ICON_ODDISH     ; 99 HANAMOGURA
	db ICON_ODDISH     ; 9a HANARYU
	db ICON_RHYDON     ; 9b HONOGUMA
	db ICON_RHYDON     ; 9c VOLBEAR
	db ICON_RHYDON     ; 9d DYNABEAR
	db ICON_LAPRAS     ; 9e KURUSU
	db ICON_LAPRAS     ; 9f AQUA
	db ICON_LAPRAS     ; a0 AQUARIA
	db ICON_PIDGEY     ; a1 HOHO
	db ICON_PIDGEY     ; a2 BOBO
	db ICON_LOKON      ; a3 PACHIMEE
	db ICON_LOKON      ; a4 MOKOKO
	db ICON_RHYDON     ; a5 DENRYU
	db ICON_LOKON      ; a6 MIKON
	db ICON_ODDISH     ; a7 MONJA
	db ICON_ODDISH     ; a8 JARANRA
	db ICON_MAGIKARP   ; a9 HANEEI
	db ICON_MAGIKARP   ; aa PUKU
	db ICON_MAGIKARP   ; ab SHIBIREFUGU
	db ICON_PIKACHU    ; ac PICHU
	db ICON_CLEFAIRY   ; ad PY
	db ICON_JIGGLYPUFF ; ae PUPURIN
	db ICON_RHYDON     ; af MIZUUO
	db ICON_PIDGEY     ; b0 NATY
	db ICON_PIDGEY     ; b1 NATIO
	db ICON_MAGIKARP   ; b2 GYOPIN
	db ICON_JIGGLYPUFF ; b3 MARIL
	db ICON_MAGIKARP   ; b4 MANBO1
	db ICON_MAGIKARP   ; b5 IKARI
	db ICON_MAGIKARP   ; b6 GROTESS
	db ICON_ZUBAT      ; b7 EKSING
	db ICON_MUSHI      ; b8 PARA
	db ICON_MUSHI      ; b9 KOKUMO
	db ICON_MUSHI      ; ba TWOHEAD
	db ICON_PIDGEY     ; bb YOROIDORI
	db ICON_DITTO      ; bc ANIMON
	db ICON_PIDGEY     ; bd HINAZU
	db ICON_ODDISH     ; be SUNNY
	db ICON_TAUROS     ; bf PAON
	db ICON_TAUROS     ; c0 DONPHAN
	db ICON_GENGAR     ; c1 TWINZ
	db ICON_LOKON      ; c2 KIRINRIKI
	db ICON_MRMIME     ; c3 PAINTER
	db ICON_LOKON      ; c4 KOUNYA
	db ICON_LOKON      ; c5 RINRIN
	db ICON_LOKON      ; c6 BERURUN
	db ICON_POLIWAG    ; c7 NYOROTONO
	db ICON_RHYDON     ; c8 YADOKING
	db ICON_ANNON      ; c9 ANNON
	db ICON_MUSHI      ; ca REDIBA
	db ICON_MUSHI      ; cb MITSUBOSHI
	db ICON_TAUROS     ; cc PUCHICORN
	db ICON_LOKON      ; cd EIFIE
	db ICON_LOKON      ; ce BLACKY
	db ICON_LOKON      ; cf TURBAN
	db ICON_DITTO      ; d0 BETBABY
	db ICON_MAGIKARP   ; d1 TEPPOUO
	db ICON_MAGIKARP   ; d2 OKUTANK
	db ICON_MACHOP     ; d3 GONGU
	db ICON_MACHOP     ; d4 KAPOERER
	db ICON_LOKON      ; d5 PUDIE
	db ICON_ODDISH     ; d6 HANEKO
	db ICON_ODDISH     ; d7 POPONEKO
	db ICON_ODDISH     ; d8 WATANEKO
	db ICON_MRMIME     ; d9 BARIRINA
	db ICON_MRMIME     ; da LIP
	db ICON_MRMIME     ; db ELEBABY
	db ICON_MRMIME     ; dc BOOBY
	db ICON_ODDISH     ; dd KIREIHANA
	db ICON_ODDISH     ; de TSUBOMITTO
	db ICON_TAUROS     ; df MILTANK
	db ICON_LAPRAS     ; e0 BOMBSEEKER
	db ICON_CLEFAIRY   ; e1 GIFT
	db ICON_LOKON      ; e2 KOTORA
	db ICON_LOKON      ; e3 RAITORA
	db ICON_PIDGEY     ; e4 MADAME
	db ICON_GENGAR     ; e5 NOROWARA
	db ICON_GENGAR     ; e6 KYONPAN
	db ICON_PIDGEY     ; e7 YAMIKARASU
	db ICON_RHYDON     ; e8 HAPPI
	db ICON_MUSHI      ; e9 SCISSORS
	db ICON_MUSHI      ; ea PURAKKUSU
	db ICON_LOKON      ; eb DEVIL
	db ICON_LOKON      ; ec HELGAA
	db ICON_RHYDON     ; ed WOLFMAN
	db ICON_RHYDON     ; ee WARWOLF
	db ICON_VOLTORB    ; ef PORYGON2
	db ICON_RHYDON     ; f0 NAMEIL
	db ICON_ONIX       ; f1 HAGANEIL
	db ICON_LAPRAS     ; f2 KINGDRA
	db ICON_LOKON      ; f3 RAI
	db ICON_LOKON      ; f4 EN
	db ICON_LOKON      ; f5 SUI
	db ICON_LOKON      ; f6 NYULA
	db ICON_PIDGEY     ; f7 HOUOU
	db ICON_CLEFAIRY   ; f8 TOGEPY
	db ICON_CLEFAIRY   ; f9 BULU
	db ICON_LOKON      ; fa TAIL
	db ICON_LOKON      ; fb LEAFY
