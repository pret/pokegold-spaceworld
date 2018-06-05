INCLUDE "constants.asm"

SECTION "Wild Pokémon", ROMX[$6A3C], BANK[$0F]

GrassWildMons:: ; f:6a3c

	db $01, $01 ; map group, map id
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn
if DEF(GOLD)
	db 7, DEX_SUNNY
	db 3, DEX_SUNNY
	db 5, DEX_SUNNY
else
	db 8, DEX_POPPO
	db 8, DEX_POPPO
	db 7, DEX_POPPO
endc
	db 5, DEX_PIKACHU
	db 5, DEX_POPPO
	db 5, DEX_POPPO
	; day
	db 4, DEX_KORATTA
	db 6, DEX_KIRINRIKI
	db 4, DEX_KIRINRIKI
if DEF(GOLD)
	db 4, DEX_HANEKO
else
	db 4, DEX_MARIL
endc
	db 4, DEX_POPPO
	db 8, DEX_KORATTA
	; nite
	db 7, DEX_KORATTA
	db 5, DEX_KORATTA
	db 5, DEX_KORATTA
if DEF(GOLD)
	db 7, DEX_KORATTA
	db 8, DEX_KORATTA
else
	db 5, DEX_HOHO
	db 3, DEX_HOHO
endc
	db 5, DEX_PIKACHU

	db $01, $02 ; map group, map id
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn
if DEF(GOLD)
	db 6, DEX_SUNNY
	db 6, DEX_SUNNY
	db 6, DEX_SUNNY
else
	db 8, DEX_POPPO
	db 8, DEX_POPPO
	db 6, DEX_POPPO
endc
	db 5, DEX_PIKACHU
	db 4, DEX_ARBO
	db 5, DEX_KORATTA
	; day
	db 5, DEX_POPPO
	db 7, DEX_YOROIDORI
	db 5, DEX_KORATTA
if DEF(GOLD)
	db 8, DEX_HANEKO
else
	db 8, DEX_MARIL
endc
	db 4, DEX_POPPO
	db 7, DEX_KORATTA
	; nite
	db 7, DEX_KORATTA
	db 6, DEX_ARBO
if DEF(GOLD)
	db 6, DEX_KORATTA
else
	db 6, DEX_HOHO
endc
	db 7, DEX_ARBO
	db 8, DEX_KORATTA
	db 5, DEX_PIKACHU

	db $02, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 9, DEX_CATERPIE
	db 9, DEX_TRANSEL
	db 8, DEX_CATERPIE
	db 7, DEX_TRANSEL
	db 10, DEX_POPPO
	db 7, DEX_CATERPIE
	; day
	db 8, DEX_CATERPIE
	db 9, DEX_POPPO
	db 11, DEX_KORATTA
	db 9, DEX_KORATTA
	db 10, DEX_KORATTA
	db 8, DEX_CATERPIE
	; nite
	db 9, DEX_KORATTA
	db 10, DEX_HOHO
	db 11, DEX_NAZONOKUSA
	db 12, DEX_HOHO
	db 11, DEX_NAZONOKUSA
	db 13, DEX_NAZONOKUSA

	db $06, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 19, DEX_METAMON
	db 20, DEX_ONIDRILL
	db 18, DEX_METAMON
	db 17, DEX_TRANSEL
	db 21, DEX_ONIDRILL
	db 17, DEX_METAMON
	; day
	db 17, DEX_ONISUZUME
	db 18, DEX_ONISUZUME
	db 21, DEX_DODO
	db 19, DEX_DODO
	db 20, DEX_DODO
	db 18, DEX_METAMON
	; nite
	db 19, DEX_SLEEPE
	db 20, DEX_SLEEPE
	db 21, DEX_SLEEPE
	db 22, DEX_SLEEPE
	db 23, DEX_SLEEPE
	db 23, DEX_SLEEPE

	db $04, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 12, DEX_TAMATAMA
	db 12, DEX_KONGPANG
	db 11, DEX_TAMATAMA
	db 10, DEX_KONGPANG
	db 13, DEX_ONISUZUME
	db 10, DEX_TAMATAMA
	; day
	db 11, DEX_ONISUZUME
	db 12, DEX_ONISUZUME
	db 14, DEX_ISITSUBUTE
	db 12, DEX_ISITSUBUTE
	db 13, DEX_ISITSUBUTE
	db 11, DEX_TAMATAMA
	; nite
	db 12, DEX_ARBO
	db 13, DEX_ARBO
	db 14, DEX_ARBO
	db 15, DEX_ARBO
	db 16, DEX_ARBO
	db 16, DEX_ARBO

	db $04, $02 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 20, DEX_MENOKURAGE
	db 15, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 15, DEX_MENOKURAGE
	; day
	db 20, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 35, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	; nite
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 35, DEX_MENOKURAGE
	db 40, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 45, DEX_MENOKURAGE

	db $05, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 20, DEX_MENOKURAGE
	db 15, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 15, DEX_MENOKURAGE
	; day
	db 20, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 35, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	; nite
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 35, DEX_MENOKURAGE
	db 40, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 45, DEX_MENOKURAGE

	db $05, $02 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 20, DEX_MENOKURAGE
	db 15, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 15, DEX_MENOKURAGE
	; day
	db 20, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 35, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	; nite
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 35, DEX_MENOKURAGE
	db 40, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 45, DEX_MENOKURAGE

	db $05, $03 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 16, DEX_WANRIKY
	db 16, DEX_WANRIKY
	db 15, DEX_WANRIKY
	db 14, DEX_WANRIKY
	db 17, DEX_ONISUZUME
	db 14, DEX_WANRIKY
	; day
	db 15, DEX_ONISUZUME
	db 16, DEX_ONISUZUME
	db 18, DEX_KORATTA
	db 16, DEX_KORATTA
	db 17, DEX_KORATTA
	db 15, DEX_ONISUZUME
	; nite
	db 16, DEX_SLEEPE
	db 17, DEX_SLEEPE
	db 18, DEX_SLEEPE
	db 19, DEX_SLEEPE
	db 20, DEX_SLEEPE
	db 20, DEX_SLEEPE

	db $05, $04 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 17, DEX_ONISUZUME
	db 17, DEX_ONISUZUME
	db 16, DEX_ONISUZUME
	db 15, DEX_ONISUZUME
	db 18, DEX_DODO
	db 15, DEX_ONISUZUME
	; day
	db 16, DEX_DODO
	db 17, DEX_DONPHAN
	db 19, DEX_SAND
	db 17, DEX_SAND
	db 18, DEX_SAND
	db 16, DEX_DODO
	; nite
	db 17, DEX_DODO
	db 18, DEX_DODO
	db 19, DEX_DODO
	db 20, DEX_DODO
	db 21, DEX_BULU
	db 21, DEX_BULU

	db $06, $02 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 21, DEX_ONISUZUME
	db 21, DEX_ONISUZUME
	db 20, DEX_ONIDRILL
	db 19, DEX_ONIDRILL
	db 22, DEX_ONIDRILL
	db 19, DEX_ONISUZUME
	; day
	db 20, DEX_DODO
	db 22, DEX_SANDPAN
	db 21, DEX_DONPHAN
	db 21, DEX_SAND
	db 23, DEX_SAND
	db 20, DEX_DODO
	; nite
	db 21, DEX_DODO
	db 22, DEX_DODO
	db 23, DEX_DODO
	db 24, DEX_DODO
	db 25, DEX_BULU
	db 25, DEX_BULU

	db $06, $03 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 23, DEX_HANEKO
	db 23, DEX_POPONEKO
	db 22, DEX_HANEKO
	db 25, DEX_POPONEKO
	db 24, DEX_SAND
	db 21, DEX_HANEKO
	; day
	db 22, DEX_SAND
	db 23, DEX_SANDPAN
	db 25, DEX_ROKON
	db 23, DEX_ROKON
	db 21, DEX_MIKON
	db 22, DEX_HANEKO
	; nite
	db 23, DEX_HOHO
	db 24, DEX_HOHO
	db 25, DEX_HOHO
	db 26, DEX_HOHO
	db 27, DEX_BULU
	db 27, DEX_BULU

	db $07, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 24, DEX_HANEKO
	db 24, DEX_POPONEKO
	db 23, DEX_HANEKO
	db 22, DEX_POPONEKO
	db 25, DEX_POPONEKO
	db 22, DEX_HANEKO
	; day
	db 23, DEX_POPPO
	db 24, DEX_PIGEON
	db 26, DEX_ROKON
	db 24, DEX_ROKON
	db 25, DEX_ROKON
	db 23, DEX_HANEKO
	; nite
	db 24, DEX_HOHO
	db 25, DEX_HOHO
	db 26, DEX_SLEEPE
	db 27, DEX_SLEEPE
	db 28, DEX_SLEEPER
	db 28, DEX_SLEEPER

	db $08, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 20, DEX_MENOKURAGE
	db 15, DEX_MENOKURAGE
	db 35, DEX_IKARI
	db 15, DEX_MENOKURAGE
	; day
	db 20, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 35, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	; nite
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 35, DEX_MENOKURAGE
	db 40, DEX_MENOKURAGE
	db 35, DEX_IKARI
	db 45, DEX_MENOKURAGE

	db $07, $02 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 28, DEX_HANEKO
	db 28, DEX_POPONEKO
	db 27, DEX_HANEKO
	db 27, DEX_POPONEKO
	db 30, DEX_POPONEKO
	db 27, DEX_HANEKO
	; day
	db 28, DEX_POPPO
	db 29, DEX_PIGEON
	db 31, DEX_ROKON
	db 29, DEX_ROKON
	db 30, DEX_ROKON
	db 28, DEX_HANEKO
	; nite
	db 29, DEX_HOHO
	db 31, DEX_HOHO
	db 32, DEX_SLEEPE
	db 33, DEX_SLEEPE
	db 34, DEX_SLEEPER
	db 34, DEX_SLEEPER

	db $07, $03 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 28, DEX_REDIBA
	db 28, DEX_MANKEY
	db 27, DEX_REDIBA
	db 28, DEX_MANKEY
	db 31, DEX_MANKEY
	db 28, DEX_POPPO
	; day
	db 29, DEX_MANKEY
	db 30, DEX_PIGEON
	db 32, DEX_ROKON
	db 30, DEX_WOLFMAN
	db 31, DEX_WOLFMAN
	db 29, DEX_REDIBA
	; nite
	db 30, DEX_WOLFMAN
	db 33, DEX_WOLFMAN
	db 34, DEX_SLEEPE
	db 35, DEX_WOLFMAN
	db 36, DEX_SLEEPER
	db 36, DEX_WOLFMAN

	db $09, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 29, DEX_REDIBA
	db 29, DEX_MILTANK
	db 28, DEX_REDIBA
	db 29, DEX_MILTANK
	db 32, DEX_MANKEY
	db 29, DEX_REDIBA
	; day
	db 30, DEX_MANKEY
	db 31, DEX_OKORIZARU
	db 33, DEX_NYOROMO
	db 31, DEX_NYOROZO
	db 32, DEX_NYOROMO
	db 30, DEX_REDIBA
	; nite
	db 31, DEX_WOLFMAN
	db 34, DEX_WOLFMAN
	db 35, DEX_WOLFMAN
	db 36, DEX_WOLFMAN
	db 37, DEX_WOLFMAN
	db 37, DEX_WOLFMAN

	db $09, $02 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 32, DEX_MILTANK
	db 32, DEX_MILTANK
	db 31, DEX_MILTANK
	db 32, DEX_MILTANK
	db 35, DEX_OKORIZARU
	db 32, DEX_REDIBA
	; day
	db 33, DEX_MANKEY
	db 34, DEX_OKORIZARU
	db 36, DEX_NYOROMO
	db 34, DEX_NYOROZO
	db 35, DEX_NYOROZO
	db 33, DEX_REDIBA
	; nite
	db 34, DEX_WOLFMAN
	db 37, DEX_WOLFMAN
	db 38, DEX_WOLFMAN
	db 39, DEX_WOLFMAN
	db 40, DEX_WARWOLF
	db 40, DEX_WARWOLF

	db $0a, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 29, DEX_KARAKARA
	db 29, DEX_GARAGARA
	db 28, DEX_KARAKARA
	db 29, DEX_GARAGARA
	db 32, DEX_SIHORN
	db 29, DEX_KARAKARA
	; day
	db 30, DEX_SIHORN
	db 31, DEX_SIHORN
	db 33, DEX_YOROIDORI
	db 31, DEX_YOROIDORI
	db 32, DEX_YOROIDORI
	db 30, DEX_KARAKARA
	; nite
	db 31, DEX_ARBO
	db 34, DEX_ARBO
	db 35, DEX_ARBOK
	db 36, DEX_ARBOK
	db 37, DEX_ARBO
	db 37, DEX_ARBOK

	db $0b, $01 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 28, DEX_PICHU
	db 28, DEX_PICHU
	db 27, DEX_PIKACHU
	db 28, DEX_NAZONOKUSA
	db 31, DEX_KUSAIHANA
	db 28, DEX_PIKACHU
	; day
	db 29, DEX_NAZONOKUSA
	db 30, DEX_PAINTER
	db 32, DEX_NYARTH
	db 32, DEX_RATTA
	db 31, DEX_NYARTH
	db 29, DEX_NAZONOKUSA
	; nite
	db 31, DEX_RATTA
	db 33, DEX_ARBO
	db 34, DEX_ARBOK
	db 35, DEX_ARBOK
	db 36, DEX_ARBO
	db 36, DEX_ARBOK

	db $01, $03 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 29, DEX_PICHU
	db 29, DEX_PICHU
	db 28, DEX_PIKACHU
	db 29, DEX_NAZONOKUSA
	db 32, DEX_KUSAIHANA
	db 27, DEX_PIKACHU
	; day
	db 28, DEX_NAZONOKUSA
	db 29, DEX_PAINTER
	db 32, DEX_NYARTH
	db 32, DEX_RATTA
	db 30, DEX_NYARTH
	db 28, DEX_NAZONOKUSA
	; nite
	db 30, DEX_RATTA
	db 32, DEX_HOHO
	db 33, DEX_ARBO
	db 34, DEX_HOHO
	db 35, DEX_ARBOK
	db 35, DEX_HOHO

	db $05, $05 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 20, DEX_MENOKURAGE
	db 15, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 15, DEX_MENOKURAGE
	; day
	db 20, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 35, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	; nite
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 35, DEX_MENOKURAGE
	db 40, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 45, DEX_MENOKURAGE

	db $05, $06 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 20, DEX_MENOKURAGE
	db 15, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 15, DEX_MENOKURAGE
	; day
	db 20, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 35, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	; nite
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 35, DEX_MENOKURAGE
	db 40, DEX_MENOKURAGE
	db 35, DEX_HANEEI
	db 45, DEX_MENOKURAGE

	db $09, $03 ; map group, map id
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 20, DEX_MENOKURAGE
	db 15, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 15, DEX_MENOKURAGE
	; day
	db 20, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 35, DEX_MENOKURAGE
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	; nite
	db 25, DEX_MENOKURAGE
	db 30, DEX_MENOKURAGE
	db 35, DEX_MENOKURAGE
	db 40, DEX_MENOKURAGE
	db 35, DEX_DOKUKURAGE
	db 45, DEX_MENOKURAGE

	db $01, $0F ; map group, map id
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn
	db 7, DEX_REDIBA
	db 7, DEX_REDIBA
	db 5, DEX_TRANSEL
	db 5, DEX_PIKACHU
	db 7, DEX_POPPO
	db 5, DEX_POPPO
	; day
	db 6, DEX_POPPO
	db 4, DEX_CATERPIE
	db 6, DEX_CATERPIE
if DEF(GOLD)
	db 6, DEX_HANEKO
else
	db 6, DEX_MARIL
endc
	db 5, DEX_CATERPIE
	db 8, DEX_REDIBA
	; nite
	db 4, DEX_TRANSEL
	db 6, DEX_KORATTA
if DEF(GOLD)
	db 6, DEX_CATERPIE
else
	db 5, DEX_HOHO
endc
	db 6, DEX_REDIBA
	db 5, DEX_TRANSEL
	db 5, DEX_PIKACHU

	db -1 ; end
; f:6e3e
